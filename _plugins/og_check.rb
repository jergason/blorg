# OG/SEO sanity check. Runs after site write, warns about posts whose
# social card metadata is missing, malformed, or likely to render badly.
#
# Skip with: JEKYLL_SKIP_OG_CHECK=1 bundle exec jekyll build

module OgCheck
  RECOMMENDED_W = 1200
  RECOMMENDED_H = 630
  MIN_W = 600
  MIN_H = 315
  TITLE_MAX = 70           # twitter truncates ~70, fb ~88
  DESC_MAX = 200           # most platforms cut ~200
  DESC_MIN = 50            # too-short descriptions look bad

  module_function

  def png_dims(path)
    File.open(path, 'rb') do |f|
      sig = f.read(8)
      return nil unless sig && sig.bytes[0, 8] == [137, 80, 78, 71, 13, 10, 26, 10]
      f.read(8) # IHDR length + type
      data = f.read(8)
      return nil unless data && data.bytesize == 8
      data.unpack('N2')
    end
  end

  def jpg_dims(path)
    File.open(path, 'rb') do |f|
      return nil unless f.read(2) == "\xFF\xD8".b
      loop do
        byte = f.read(1)
        return nil unless byte
        next unless byte == "\xFF".b
        marker = f.read(1)
        return nil unless marker
        m = marker.ord
        next if m == 0xFF || m == 0x00
        if (0xC0..0xCF).include?(m) && ![0xC4, 0xC8, 0xCC].include?(m)
          f.read(3)
          h = f.read(2).unpack1('n')
          w = f.read(2).unpack1('n')
          return [w, h]
        else
          len = f.read(2)
          return nil unless len && len.bytesize == 2
          f.read(len.unpack1('n') - 2)
        end
      end
    end
  rescue StandardError
    nil
  end

  def image_dims(path)
    return nil unless File.file?(path)
    case path.downcase
    when /\.png\z/ then png_dims(path)
    when /\.jpe?g\z/ then jpg_dims(path)
    end
  end

  def resolve_image(site, image)
    return nil unless image
    rel = image.is_a?(Hash) ? image['path'] : image
    return nil unless rel.is_a?(String)
    rel = rel.sub(%r{\Ahttps?://[^/]+}, '')
    File.join(site.source, rel.sub(%r{\A/}, ''))
  end

  def check_post(site, post)
    issues = []
    title = post.data['title']
    desc = post.data['description']
    image = post.data['image']

    issues << 'missing title' if title.nil? || title.strip.empty?
    issues << "title too long (#{title.length} > #{TITLE_MAX})" if title && title.length > TITLE_MAX

    if desc.nil? || desc.strip.empty?
      issues << 'missing description (falls back to site description on socials)'
    else
      issues << "description too long (#{desc.length} > #{DESC_MAX}, will get truncated)" if desc.length > DESC_MAX
      issues << "description very short (#{desc.length} < #{DESC_MIN})" if desc.length < DESC_MIN
    end

    if image.nil?
      issues << 'no image set (no card image will render)'
    else
      path = resolve_image(site, image)
      if path.nil? || !File.file?(path)
        issues << "image file not found on disk: #{image}"
      else
        dims = image_dims(path)
        if dims.nil?
          issues << "could not read dimensions for #{image} (unsupported format?)"
        else
          w, h = dims
          if w < MIN_W || h < MIN_H
            issues << "image too small #{w}x#{h} (min #{MIN_W}x#{MIN_H}, target #{RECOMMENDED_W}x#{RECOMMENDED_H})"
          elsif w < RECOMMENDED_W || h < RECOMMENDED_H
            issues << "image below recommended #{w}x#{h} (target #{RECOMMENDED_W}x#{RECOMMENDED_H})"
          end
          ratio = w.to_f / h
          if ratio < 1.7 || ratio > 2.1
            issues << format('image aspect %.2f:1 (target 1.91:1, twitter large_image expects this)', ratio)
          end
        end
      end
    end

    issues
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  next if ENV['JEKYLL_SKIP_OG_CHECK'] == '1'

  total = 0
  bad = 0
  site.posts.docs.each do |post|
    next unless post.data['published'] != false
    total += 1
    issues = OgCheck.check_post(site, post)
    next if issues.empty?
    bad += 1
    Jekyll.logger.warn 'OG check:', "#{post.relative_path}"
    issues.each { |msg| Jekyll.logger.warn '  -', msg }
  end
  if bad.zero?
    Jekyll.logger.info 'OG check:', "#{total} posts ok"
  else
    Jekyll.logger.warn 'OG check:', "#{bad}/#{total} posts have issues"
  end
end
