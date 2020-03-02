let SCHEMA
let RULES
let SCENARIOS

function renderValue (key, value, schema) {
  schema = schema || SCHEMA[key]
  if (schema['type'] === 'array' && value) return value.map(v => renderValue(key, v, schema['items'])).join(', ')
  if (schema['type'] === 'boolean') return value ? 'oui' : 'non'
  if (schema['format'] === 'date' && value) return (new Date(value * 1000)).toLocaleDateString()
  if (schema['enum']) return `${schema['enum'][value]} (${value})`
  return value
}

function renderLabel (key, value) {
  return SCHEMA[key]['label']
}

REQUESTS = 0

function request(uri, settings) {
  return new Promise( (res, rej) => {
    const xhr = new XMLHttpRequest(),
          progress = document.querySelector('#progress'),
          close = () => {if (!--REQUESTS) progress.style.display = 'none'}
    settings = settings || {};
    REQUESTS++
    progress.style.display = 'block'
    xhr.onprogress = (e) => {
      if (e.lengthComputable) progress.value = Math.round(e.loaded * 100 / e.total)
    }
    xhr.open(settings.method || 'get', uri, true)
    xhr.onload = () => {
      if (xhr.status == 200) res(JSON.parse(xhr.responseText))
      else rej(JSON.parse(xhr.responseText))
      close()
    }
    xhr.onerror = (err) => {
      close()
      rej(err)
    }
    xhr.send(settings.body)
  })
}

function init () {
  request('../explore/schema')
    .then((data) => {
      SCHEMA = data
      route.start(true)
    })
}
