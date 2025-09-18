import QtQuick
import QtQuick.Layouts
import Quickshell


Item {
	id: root
	property var screen


	// PanelWindow is the Quickshell surface type for bars/panels
	PanelWindow {
		id: panel
		screen: root.screen
		anchors.left: true
		anchors.right: true
		anchors.top: true


		implicitHeight: 40
		color: "transparent"


		// Reserve space so compositors/tilers know not to cover this area
		exclusiveZone: 40


		// Optional: allow click-through by default (mask can be used to accept clicks)
		// mask: Region {}


		// Layout: Left | Center (expands) | Right
		RowLayout {
			anchors.fill: parent
			spacing: 8
			// Left side
			Text {
				text: "MyBar"
				font.pixelSize: 14
				color: "white"
				Layout.alignment: Qt.AlignVCenter
			}
			// left section
			Item {
				Layout.preferredWidth: 300
				RowLayout { anchors.verticalCenter: parent.verticalCenter; id: leftLayout }
			}

			// Center (expands)
			Item {
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

				// Example: put Clock here
				Loader {
					source: "../widgets/Clock.qml"
				}
			}

			// center section that expands and keeps centered content properly
			Item {
				Layout.fillWidth: true
				RowLayout { anchors.verticalCenter: parent.verticalCenter; id: centerLayout; anchors.horizontalCenter: parent.horizontalCenter }
				Loader {
					source: "../widgets/Battery.qml"
					Layout.alignment: Qt.AlignVCenter
				}

			}


			// right section
			Item {
				Layout.preferredWidth: 300
				RowLayout { anchors.verticalCenter: parent.verticalCenter; id: rightLayout }
			}


			// Example: add widgets by creating instances here
			Component.onCompleted: {
				// You can dynamically load widgets or place static ones here.
				// Example (if files exist in widgets/):
				// leftLayout.addItem(Qt.createComponent("../widgets/Launcher.qml").createObject(leftLayout));
			}
		}
	}
}
