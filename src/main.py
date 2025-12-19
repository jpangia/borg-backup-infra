from borg import Borg
import util
import config

def main():
    """
    run everything.
    
    """
    cfg = config.load_config_or_default()
    util.load_env(cfg)

    bg = Borg(cfg)

    bg.backup_all()