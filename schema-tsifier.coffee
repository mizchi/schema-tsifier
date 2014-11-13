path = require 'path'
fs   = require 'fs'
util = require 'util'
yaml = require 'js-yaml'
_    = require 'lodash'

Property = require './property'

schema = null
indexes = null

loadScheme = (filename) ->
  CWD = process.cwd()

  switch path.extname filename
    when '.yml', '.yaml'
      yaml.safeLoad(fs.readFileSync(path.join(CWD,filename), 'utf8'))
    else
      require path.join(CWD,filename)

buildIndexes = do ->
  flattened = {}
  (tree, path = '#') ->
    flattened[path] = tree
    for own k, v of tree when typeof v isnt 'string'
      ns = path+'/'+k
      buildIndexes v, ns
    flattened

renderEntities = require './entity-renderer'
module.exports = (filename, namespace) ->
  schema = loadScheme filename
  indexes = buildIndexes schema

  models =
    for prop, val of schema.properties
      new Property indexes, prop, val

  console.log renderEntities
    namespace: namespace
    models: models
