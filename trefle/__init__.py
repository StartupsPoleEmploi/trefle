import pkg_resources

from . import config

config.init()

VERSION = pkg_resources.get_distribution(__package__).version
