from pathlib import Path

import yaml

with (Path(__file__).parent / 'config/openapis.yml').open() as f:
    SCHEMA = yaml.safe_load(f.read())

with (Path(__file__).parent / 'config/variables.yml').open() as f:
    VARIABLES = yaml.safe_load(f.read())


def add_schema(name, data=None):
    if data is None:
        data = VARIABLES[name]
    keys = ['type', 'format', 'description']
    properties = {}
    required = []
    for key, props in data.items():
        if props.get('required'):
            required.append(key)
        if 'type' not in props:
            # A subcomponent.
            add_schema(key, props)
            properties[key] = {'$ref': f'#/components/schemas/{key}'}
            continue
        if not props.get('public'):
            continue
        properties[key] = {}
        for subkey in keys:
            if subkey in props:
                properties[key][subkey] = props[subkey]
    schema = {'properties': properties}
    if required:
        schema['required'] = required
    SCHEMA['components']['schemas'][name] = schema


add_schema('beneficiaire')
add_schema('formation')
add_schema('scenario')
