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
renderApi = require './api-renderer'

splitter = /{.*}/g
module.exports = (filename, namespace, withResources = false) ->
  schema = loadScheme filename
  indexes = buildIndexes schema

  classes = {}

  models =
    for propName, val of schema.properties
      p = new Property indexes, propName, val
      classes[propName] = p
      p
  console.log renderEntities
    namespace: namespace + '.Entities'
    models: models

  if withResources
    resources =
      for propName, val of schema.properties then do (propName, val) ->
        returnValue = classes[propName]

        endpoints =
          val.links?.map (link) ->
            inputs =
              if link.schema
                new Property indexes, link.method+' '+link.href, link.schema
              else
                {}

            hasArgs = !!link.href.match(splitter)
            # console.log link.title, ':hasArgs', hasArgs, link.href

            # hasArgs = argCount > 0
            buildUrl = do ->
              [a, b] = link.href.split(splitter)
              ->
                if b.length > 0
                  "'#{a}' + id + '#{b}'"
                else
                  "'#{a}' + id"

            # console.log hasArgs, buildUrl()

            buildUrl: buildUrl
            hasArgs: hasArgs
            title: link.title
            href: link.href
            method: link.method
            inputs: inputs?.properties ? []
            returnValue: returnValue
            isReturnArray: false

        resource: propName
        endpoints: endpoints ? []

    console.log renderApi {resources, namespace: namespace+'.Resources'}
