
class Borg:
    def __init__(self, cfg: dict):
        self.cfg = cfg

    def backup(self, name: str, target_path: str):
        """
        Create a backup named `name` of the directory at `path` 
        according to `cfg`
        
        :param name: name of the repository to back up to
        :type name: str
        :param path: path to the directory to back up
        :type path: str
        """
        user = self.cfg.server.user
        host = self.cfg.server.hostname
        path_root = self.cfg.server.backup_root
        archive_name = "" #$(date +"tumpa2_windows-%Y%m%d-%H%M%S")

        self.ensure_init()
        # todo: make the command that runs `borg --verbose --progress create --stats {user}@{host}:{path_root}/{name}::{archive_name} {target_path}`


    def backup_all(self):
        """
        Creates a backup of all target directories
        defined in the config
        """

        for trgt in self.cfg.backup_targets:
            self.backup(trgt)
        

    def ensure_init(self, ):
        """
        
        """

        user = self.cfg.server.user
        host = self.cfg.server.hostname
        path_root = self.cfg.server.backup_root



    def do_check():
        """
        checks repo consistency
        """

    def do_create():
        """
        util function to run the command to make a backup.
        Creates the backup, prunes the repo, and checks repo consistency
        """
        pass

    def prune_repo():
        """
        util function to reduce the repository to a configurable number of copies
        """
        pass