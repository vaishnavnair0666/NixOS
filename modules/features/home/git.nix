{...}: {
  flake.nixosModules.hm-git = {user, ...}: {
    home-manager.users.${user} = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "vaishnavnair0666";
            email = "vaishnavnair0666@gmail.com";
          };
          init.defaultBranch = "main";
          pull.rebase = true;
          push.autoSetupRemote = true;
          gpg.format = "ssh";
        };
        signing = {
          key = "~/.ssh/github.pub";
          signByDefault = true;
        };
      };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "yes";
          };
          "github.com" = {
            user = "git";
            identityFile = "~/.ssh/github";
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
