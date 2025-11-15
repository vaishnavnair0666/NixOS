{ ... }:
let user = "vaish";
in {
  users.users.${user} = {
    isNormalUser = true;
    description = "vaish";
    linger = false;
    extraGroups =
      [ "wheel" "networkmanager" "audio" "video" "input" "bluetooth" ];
  };
  systemd.services."user-${user}.slice".wantedBy = [ "multi-user.target" ];
}

