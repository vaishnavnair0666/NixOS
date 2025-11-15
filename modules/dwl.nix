{ inputs, ... }: {
  environment.systemPackages = [ inputs.dwlFlake.defaultPackage ];
}
