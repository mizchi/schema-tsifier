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

  classes = {}

  models =
    for propName, val of schema.properties
      p = new Property indexes, propName, val
      classes[propName] = p
      p

  # entityCode = renderEntities
  #   namespace: namespace
  #   models: models

  resources =
    for propName, val of schema.properties
      returnValue = classes[propName]

      endpoints =
        for link in val.links
          # console.log '--------------'
          # console.log link.method, link.href
          inputs =
            if link.schema
              new Property indexes, link.method+' '+link.href, link.schema
            else
              {}

          # console.log util.inspect
          #   href: link.href
          #   method: link.method
          #   inputs: inputs?.properties ? []
          #   returnValue: returnValue
          # , false, null

          title: link.title
          href: link.href
          method: link.method
          inputs: inputs?.properties ? []
          returnValue: returnValue
          isReturnArray: false

      resource: propName
      endpoints: endpoints
  # console.log util.inspect resources, false, null

  renderApi = require './api-renderer'
  # console.log renderApi
  console.log renderApi {resources, namespace: 'Qiita.Resources'}
