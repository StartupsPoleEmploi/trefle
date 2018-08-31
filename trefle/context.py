from .exceptions import DataError
from .validators import validate_field


class Context:

    def __init__(self, data):
        self.data = data
        self.cleaned_data = {}

    def get(self, key, default=None):
        try:
            return self[key]
        except DataError:
            return default

    def set(self, key, data):
        self.cleaned_data[key] = validate_field(key, data)

    def update(self, *args, **kwargs):
        self.data.update(*args, **kwargs)

    def __getitem__(self, key):
        if key not in self.cleaned_data:
            self.set(key, self.data)
        return self.cleaned_data[key]

    def __setitem__(self, key, value):
        try:
            self.set(key, {key: value})
        except DataError:
            pass
        else:
            self.data[key] = value

    def __delitem__(self, key):
        del self.data[key]
        del self.cleaned_data[key]

    def __contains__(self, key):
        return key in self.data

    def copy(self):
        copy = Context(self.data.copy())
        copy.cleaned_data = self.cleaned_data.copy()
        return copy
