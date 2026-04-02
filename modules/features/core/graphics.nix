{...}: {
  flake.nixosModules.graphics = {pkgs, ...}: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      mesa-demos
      wayland-utils
      vulkan-loader
      vulkan-tools
    ];

    services.xserver.videoDrivers = ["amdgpu"];
  };
}
