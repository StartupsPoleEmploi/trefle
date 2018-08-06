class DataError(Exception):

    def __init__(self, error, key='error'):
        self.error = error
        self.key = key

    def __str__(self):
        return f'{self.key}: {self.error}'


class NoDataError(DataError):
    ...


class WrongPointerError(Exception):
    ...


class UpstreamError(Exception):
    ...


class NoStepError(Exception):
    ...
