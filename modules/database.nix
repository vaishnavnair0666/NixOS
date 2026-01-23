{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mongodb-tools
    mongosh
    sqlite
    mariadb.client
    pgcli
  ];
}
