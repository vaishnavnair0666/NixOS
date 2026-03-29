{
  lib,
  self',
  ...
}: {
  spawn-at-startup = [(lib.getExe self'.packages.myNoctalia)];
}
