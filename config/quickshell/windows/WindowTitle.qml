import QtQuick
import QtQuick.Layouts
import "../state"

Item {
    id: root
    Layout.fillWidth: true
    height: parent.height

    property string title: "—"

    Text {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        elide: Text.ElideRight
        maximumLineCount: 1

        text: root.title
        color: Theme.foreground
        font.pixelSize: 13
    }
}
