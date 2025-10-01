import QtQuick
import Quickshell
import Quickshell.Services.Power

Item {
    Row {
        spacing: 4
        anchors.centerIn: parent

        Text {
            text: battery.charging ? "⚡" : "🔋"
        }
        Text {
            text: battery.chargePercent + "%"
        }
    }

    Battery {
        id: battery
    }
}
