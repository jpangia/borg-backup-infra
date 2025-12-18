def make_default_config():
    """
    util function to create a default cfg.json file
    """
    # logging location
    # storage server user name
    # storage server host name
    # storage server ssh key location
    # ssh_askpass script location/name
    # include array of names of locations to back up and paths to those locations


def load_config_or_default():
    """
    reads the config variables from `cfg.json` or creates a default `cfg.json` 
    and reads the variables from there.
    """
