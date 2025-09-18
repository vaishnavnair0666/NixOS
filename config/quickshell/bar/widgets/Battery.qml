import QtQuick

Item {
  id: root
  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  property int percent: 0
  property bool charging: false

  // Load service
  Qt.include("../services/batteryService.js")

  Connections {
    target: this
    function onStateChanged() {
      root.percent = state.percent
      root.charging = state.charging
    }
  }

  Text {
    id: label
    text: (root.charging ? "⚡ " : "") + root.percent + "%"
    color: "white"
    font.pixelSize: 14
  }
}

