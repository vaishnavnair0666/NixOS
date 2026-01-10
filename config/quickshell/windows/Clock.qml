import QtQuick
import QtQuick.Layouts
import "../state"

Item {
    id: root
	signal clicked()
    implicitWidth: clockText.implicitWidth
    implicitHeight: parent.height

    property string format: "HH:mm"

    Text {
        id: clockText
        anchors.verticalCenter: parent.verticalCenter
        text: Qt.formatDateTime(new Date(), format)
        color: Theme.foreground
        font.pixelSize: 13
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clockText.text = Qt.formatDateTime(new Date(), format)
        }
    }

	MouseArea {
		anchors.fill: parent
		onClicked: root.clicked()
	}

}
