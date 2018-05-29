from pathlib import Path

import yaml

with (Path(__file__).parent / 'config/openapis.yml').open() as f:
    OPENAPI = yaml.safe_load(f.read())

with (Path(__file__).parent / 'config/schema.yml').open() as f:
    SCHEMA = yaml.safe_load(f.read())


def add_schema(name, data=None):
    if data is None:
        data = SCHEMA[name]
    schema_keys = ['type', 'format', 'description', 'nullable', 'enum',
                   'pattern', 'items']
    properties = {}
    required = []
    for key, props in data.items():
        if props.get('required'):
            required.append(key)
        if 'type' not in props:
            # A foreign key.
            add_schema(key, props)
            # Allow the foreign key to be null (eg. financement.organisme).
            properties[key] = {
                'allOf': [{'$ref': f'#/components/schemas/{key}'}],
                'nullable': True
            }
            continue
        if not props.get('public'):
            continue
        properties[key] = {}
        for subkey in schema_keys:
            if subkey in props:
                value = props[subkey]
                if subkey == 'enum':
                    value = value.keys()
                if subkey == 'format' and value == 'idcc':
                    # https://github.com/p1c2u/openapi-core/issues/41
                    continue
                properties[key][subkey] = value
    schema = {'properties': properties}
    if required:
        schema['required'] = required
    OPENAPI['components']['schemas'][name] = schema


add_schema('beneficiaire')
add_schema('formation')
add_schema('financement')
