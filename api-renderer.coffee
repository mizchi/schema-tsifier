changeCase = require 'change-case'
h = require 'handlebars'
h.registerHelper 'classify', (name) -> changeCase.pascalCase name

getTypeName = (expr) ->
  if expr.type.length is 2
    [a, b] = expr.type
    isNullable = a is 'null' or b is 'null'
    if isNullable
      "#{expr.name}?"
    else
      expr.name
  else
    expr.name

getTypeExpr = (expr) ->
  # TODO Fixme
  if expr.type is undefined
    expr = type: expr

  type =
    if typeof expr.type isnt 'string' and expr.type.length is 2
      [a, b] = expr.type
      if a is 'null'
        b
      else if b is 'null'
        a
      else
        'any'
    else
      expr.type

  switch type
    when 'array'
      getTypeExpr(expr.items)+'[]'
    when 'string'
      "string"
    when 'boolean'
      "boolean"
    when 'number', 'integer'
      'number'
    else
      'any'

tag2typeExpr = (expr) ->
  if expr.type
    typeName = getTypeName(expr)
    typeExpr = getTypeExpr(expr)
    "#{typeName}: #{typeExpr}"
  else if expr.properties
    exprs =
      for i in expr.properties
        tag2typeExpr i
    expr.name + ': {' + exprs.join('; ') + '}'
  else
    "#{expr.name}: any"

h.registerHelper 'tag2typeExpr', tag2typeExpr

template = h.compile('''
module {{namespace}} {
  export function request(method: string, href: string, params: Object){
    //TODO: do something
  }

  {{#each resources}}
  export class {{classify resource}} {
    {{#each endpoints}}

    {{#if inputs.length}}
    public static {{title}}(params: { {{#each inputs}}{{tag2typeExpr .}}; {{/each}} }) {
    {{else}}
    public static {{title}}(params = {}) {
    {{/if}}
      return request('{{method}}', '{{href}}', params);
    }
    {{/each}}
  }

  {{/each}}
}
''')

module.exports = (m) ->
  template m
