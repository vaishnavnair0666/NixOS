import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../state"
PanelWindow {
    id: bar

    signal openThemeSwitcher()

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 32
    color: Theme.background

    RowLayout {
        anchors.fill: parent
        spacing: 8

        Text {
            text: "Bar"
            color: Theme.foreground
            Layout.leftMargin: 10
        }

        Item { Layout.fillWidth: true }

        Text {
            text: "Theme"
            color: Theme.color7

            MouseArea {
                anchors.fill: parent
                onClicked: bar.openThemeSwitcher()
            }
        }

        Item { width: 10 }
    }
}
