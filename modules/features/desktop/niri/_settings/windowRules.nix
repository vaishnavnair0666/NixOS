{...}: {
  window-rules = [
    {
      matches = [
        {
          app-id = "firefox$";
          title = "^Picture-in-Picture$";
        }
      ];

      open-floating = true;
    }
    {
      matches = [{app-id = "foot";}];

      opacity = 0.8;

      shadow = {
        on = null;
        softness = 30;
        spread = 8;

        draw-behind-window = true;
        color = "#00000088";
      };

      geometry-corner-radius = 8;

      focus-ring = {off = null;};
    }
    {
      matches = [{app-id = "imv";}];

      open-floating = true;
    }
  ];
}
