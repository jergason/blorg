fs = require 'fs'
path = require 'path'

findDate = (doc) ->
  dateRe = /date: '([^']+)'/
  dateLines = doc.split('\n')
  dateLines = dateLines.filter (line) -> dateRe.test line
  console.log 'dateLines is', dateLines
  return '' if !dateLines?.length
  res  = dateRe.exec(dateLines[0])
  console.log 'res is', res[1]
  res[1]

makeNewFileName = (doc, fullPath) ->
  dirname = path.dirname fullPath
  baseName = path.basename fullPath
  date = findDate doc
  console.log 'got ', date, ' back from FindDate'
  newBaseName = if date then "#{date}-#{baseName}" else baseName
  path.join dirname, newBaseName

getUnDatedPostList = (path) ->
  files = fs.readdirSync path
  console.log 'files is', files
  undatedPostList = files.filter (f) ->
    !/^\d{4}-\d{2}-\d{2}/.test f
  undatedPostList

rewriteFile = (pathToFile) ->
  data = fs.readFileSync pathToFile, encoding: 'utf8'
  newFileName = makeNewFileName data, pathToFile
  #fs.unlinkSync pathToFile
  #fs.writeFileSync newFileName, data
  console.log 'unlinking', pathToFile
  console.log 'rewriting as', newFileName


list = getUnDatedPostList path.join(__dirname, '_posts')
console.log 'filteredList is', list
list.forEach (l) ->
  rewriteFile path.join(__dirname, '_posts', l)
