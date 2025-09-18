import QtQuick

Item {
	id: root
	implicitWidth: clock.implicitWidth
	implicitHeight: clock.implicitHeight

	Timer {
		id: timer
		interval: 1000
		repeat: true
		running: true
		onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm:ss")
	}

	Text {
		id: clock
		text: Qt.formatTime(new Date(), "hh:mm")
		font.pixelSize: 16
		color: "white"
	}
}

