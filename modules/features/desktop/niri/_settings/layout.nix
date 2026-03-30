{...}: {
  layout = {
    gaps = 9;

    center-focused-column = "on-overflow";
    always-center-single-column = null;
    preset-column-widths = [
      {proportion = 0.33333;}
      {proportion = 0.5;}
      {proportion = 0.66667;}
    ];

    preset-window-heights = [
      {proportion = 0.33333;}
      {proportion = 0.5;}
      {proportion = 0.66667;}
    ];
    default-column-width = {
      proportion = 0.5;
    };
    border = {
      off = null;

      width = 4;

      active-color = "#ffc87f";
      inactive-color = "#505050";
      urgent-color = "#9b0000";
    };
    shadow = {
      softness = 30;
      spread = 5;
      color = "#0007";
    };
    struts = {};
  };
}
