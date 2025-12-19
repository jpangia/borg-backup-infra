import borg
import util
import config

def backup_home():
    """
    Creates a backup of the home directory
    """

    borg.ensure_init()
    pass

def backup_more():
    """
    Creates a backup of the More drive
    """
    borg.ensure_init()
    pass

def backup_windows():
    """
    Creates a backup of the Windows drive
    """
    borg.ensure_init()
    pass

def main():
    """
    run everything.
    
    """
    util.load_env()
    cfg = config.load_config_or_default()

    backup_home()
    backup_more()
    backup_windows()