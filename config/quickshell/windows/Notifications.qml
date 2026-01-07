import Quickshell
import QtQuick

PopupWindow {
    signal close()

    anchors.right: true
    anchors.top: true
    width: 400
    height: 600

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: close()
    }
}
