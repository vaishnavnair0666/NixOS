import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../state"
PanelWindow {
    id: bar

    signal openThemeSwitcher()
	signal clockClicked()

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 32
    color: Theme.background

    RowLayout {
        anchors.fill: parent
        spacing: 8

        Item { width: 20 }

        // Left: focused window title
        WindowTitle {
            title: "Focused Window"
        }

        // Theme switcher entry
        Text {
            text: "Theme"
            color: Theme.color7

            MouseArea {
                anchors.fill: parent
                onClicked: bar.openThemeSwitcher()
            }
        }

        Item { Layout.fillWidth: true }

        // Right cluster
        SystemStats {}
		Clock {
			onClicked: bar.clockClicked()
		}

        Item { width: 25 }
    }
}
