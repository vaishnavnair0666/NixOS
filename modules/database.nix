{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    postgresql
    mongodb-tools
    mongosh
    sqlite
    mariadb.client
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    initialScript = pkgs.writeText "init.sql" ''
      CREATE USER dev WITH PASSWORD 'dev';
      CREATE DATABASE dev OWNER dev;
    '';
  };

}
