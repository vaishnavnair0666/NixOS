{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # 🗄️ Databases
    postgresql
    mongodb-tools # CLI tools for Mongo
    mongosh # Mongo shell
    sqlite
    mysql-client

  ];

  # Enable PostgreSQL service (if you want local dev DB always on)
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    # Optional: initial DB/user setup
    initialScript = pkgs.writeText "init.sql" ''
      CREATE USER dev WITH PASSWORD 'dev';
      CREATE DATABASE dev OWNER dev;
    '';
  };

  # MongoDB local dev (if needed)
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-7_0;
  };
}
