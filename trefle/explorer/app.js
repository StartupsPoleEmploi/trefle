let SCHEMA
let RULES

function renderValue (key, value, schema) {
  schema = schema || SCHEMA[key]
  if (schema['type'] === 'array' && value) return value.map(v => renderValue(key, v, schema['items'])).join(', ')
  if (schema['type'] === 'boolean') return value ? 'oui' : 'non'
  if (schema['format'] === 'date' && value) return (new Date(value * 1000)).toLocaleDateString('fr-FR')
  if (schema['enum']) return `${schema['enum'][value]} (${value})`
  return value
}

function renderLabel (key, value) {
  return SCHEMA[key]['label']
}


function init () {
  fetch('/explore/schema')
  .then((response) => response.json())
  .then((data) => {
    SCHEMA = data
    route.start(true)
  })
}
