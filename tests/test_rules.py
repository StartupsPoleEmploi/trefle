from pff.core import Rule


def test_rule_load():
    data = {
        'SI foo = bar': {
            'ET bar = foo': ['alors 1', 'alors 2'],
            'ET baz = foo': ['alors 3', 'alors 4'],
        },
        'SI foo = baz': {
            'ET foobar = baz': {
                'ET bar = foo': ['alors 5', 'alors 6'],
                'ET baz = foo': ['alors 7', 'alors 8'],
            }
        }
    }
    rules = Rule.load(data)
    assert len(rules) == 4
    assert rules[0].output == ['alors 1', 'alors 2']
    assert len(rules[0].conditions) == 2
    assert rules[0].conditions[0].raw == 'foo = bar'
    assert rules[0].conditions[1].raw == 'bar = foo'
    assert rules[1].output == ['alors 3', 'alors 4']
    assert len(rules[1].conditions) == 2
    assert rules[1].conditions[0].raw == 'foo = bar'
    assert rules[1].conditions[1].raw == 'baz = foo'
    assert rules[2].output == ['alors 5', 'alors 6']
    assert len(rules[2].conditions) == 3
    assert rules[2].conditions[0].raw == 'foo = baz'
    assert rules[2].conditions[1].raw == 'foobar = baz'
    assert rules[2].conditions[2].raw == 'bar = foo'
    assert rules[3].output == ['alors 7', 'alors 8']
    assert len(rules[3].conditions) == 3
    assert rules[3].conditions[0].raw == 'foo = baz'
    assert rules[3].conditions[1].raw == 'foobar = baz'
    assert rules[3].conditions[2].raw == 'baz = foo'
