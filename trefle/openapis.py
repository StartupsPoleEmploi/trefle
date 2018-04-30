from pathlib import Path

import yaml

with (Path(__file__).parent / 'config/openapis.yml').open() as f:
    SCHEMA = yaml.safe_load(f.read())

with (Path(__file__).parent / 'config/variables.yml').open() as f:
    VARIABLES = yaml.safe_load(f.read())


def add_schema(name, data=None):
    if data is None:
        data = VARIABLES[name]
    schema_keys = ['type', 'format', 'description', 'nullable', 'enum']
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
                'allOf': [{'$ref': f'#/components/schemas/{key.title()}'}],
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
                    value = value.values()
                properties[key][subkey] = value
    schema = {'properties': properties}
    if required:
        schema['required'] = required
    SCHEMA['components']['schemas'][name.title()] = schema


add_schema('beneficiaire')
add_schema('formation')
add_schema('financement')
