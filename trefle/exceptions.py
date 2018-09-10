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


class ParsingError(Exception):

    def __init__(self, msg, rule, line):
        super().__init__(f'{rule}:{line.index}: {msg} in `{line.sentence}`')
