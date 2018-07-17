let SCHEMA
let RULES

function renderValue (key, value) {
  if (SCHEMA[key]['type'] === 'array') return value.join(', ')
  if (SCHEMA[key]['type'] === 'boolean') return value ? 'oui' : 'non'
  if (SCHEMA[key]['format'] === 'date') return (new Date(value * 1000)).toLocaleDateString()
  if (SCHEMA[key]['enum']) return SCHEMA[key]['enum'][value]
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
