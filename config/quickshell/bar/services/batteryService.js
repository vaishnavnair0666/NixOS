// ~/.config/quickshell/mybar/services/batteryService.js
(function (exports) {
  const { Process } = Quickshell;

  let state = { percent: 100, charging: false };

  function poll() {
    let proc = new Process({
      command: ["acpi", "-b"],
      onFinished: (exitCode, stdout, stderr) => {
        if (exitCode === 0) {
          // Example output: "Battery 0: Discharging, 87%, 02:15:00 remaining"
          const m = stdout.match(/(Charging|Discharging).*?(\\d+)%/);
          if (m) {
            state.charging = m[1] === "Charging";
            state.percent = parseInt(m[2]);
            exports.stateChanged(); // notify QML bindings
          }
        }
      },
    });
    proc.start();
  }

  // run poll periodically
  Timer {
    interval: 10000; repeat: true; running: true
    onTriggered: poll()
  }

  exports.state = state;

  // QML can bind to this signal
  exports.stateChanged = function () {};
})(this);
