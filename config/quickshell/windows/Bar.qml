import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar

    signal openThemeSwitcher()

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 32
    color: "#1e1e2e"

    RowLayout {
        anchors.fill: parent
        spacing: 8

        Text {
            text: "Bar"
            color: "white"
            Layout.leftMargin: 10
        }

        Item { Layout.fillWidth: true }

        Text {
            text: "Theme"
            color: "#7aa2f7"

            MouseArea {
                anchors.fill: parent
                onClicked: bar.openThemeSwitcher()
            }
        }

        Item { width: 10 }
    }
}
