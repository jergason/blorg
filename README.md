# Blarg

It's a blog. Robots made the theme, so it's kinda janky. Sorry :(

## Dev

```bash
bundle install              # first time
bundle exec jekyll serve    # local server at http://localhost:4000
bundle exec jekyll build    # one-shot build into _site/
```

## Open Graph / social card workflow

`jekyll build` runs `_plugins/og_check.rb`, which warns about posts whose social card metadata is missing or likely to render badly:

- missing/oversized title (>70 chars)
- missing/too-short/too-long description (50–200 char sweet spot)
- `image:` not set, file missing on disk, below 1200×630, or aspect ratio outside ~1.91:1

Silence it with `JEKYLL_SKIP_OG_CHECK=1 bundle exec jekyll build`.

To eyeball how a post will actually unfurl, use `bin/og-preview`:

```bash
bin/og-preview                  # most recent post — builds, opens browser
bin/og-preview build-buy        # match by slug substring
bin/og-preview --all            # every post on one page
bin/og-preview --no-build       # skip rebuild, use existing _site
bin/og-preview --no-open        # don't auto-open
```

It parses the `<meta>` tags from the built HTML and renders three mock cards (X, Slack, iMessage-ish) plus a raw meta dump. Output goes to `.og-preview.html` (gitignored).

For the real platform-side render once a post is deployed, paste the URL into [opengraph.xyz](https://www.opengraph.xyz).
