{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ acpi upower ];
  services.upower.enable = true;

  boot.initrd.availableKernelModules = [
    "usbhid"
    "hid_generic"
    "hid"
    "xhci_pci"
    "uhci_hcd"
    "ohci_hcd"
    "ehci_pci"
  ];

}
