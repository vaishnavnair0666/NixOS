// modules/AppLauncherModule.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root
    property bool openDrawer: false

    readonly property var pinnedApps: [
        "firefox",
        "alacritty",
        "thunar",
        "code"
    ]

    RowLayout {
        // spacing: 6
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            left: parent.left
            right: parent.right
        }
        // padding: 6
        height: 48

        // Icon buttons for pinned apps
        Repeater {
            model: root.pinnedApps
            delegate: Button {
                text: modelData  // replace with icons if available
                onClicked: {
                    proc.command = [ modelData ]
                    proc.startDetached()
                }
            }
        }

        // Launcher button
        Button {
            text: "⋮"
            onClicked: root.openDrawer = !root.openDrawer
        }
    }

    Window {
        id: drawerWindow
        visible: root.openDrawer
        width: 300
        height: 400
        color: "#222222"
        flags: Qt.Popup | Qt.FramelessWindowHint
		x: (Screen.width - width) / 2
		y: Screen.height - height - 20  // bottom with some margin

        ColumnLayout {
            anchors.fill: parent
            // spacing: 4
            // padding: 8

            // search bar
            TextField {
                id: searchField
                placeholderText: "Search apps..."
                Layout.fillWidth: true
            }

            // list of apps (fallback: pinnedOnly or a bigger list)
            ListView {
                id: appList
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: root.pinnedApps
                delegate: Button {
                    text: modelData
                    visible: modelData.toLowerCase().includes(searchField.text.toLowerCase())
                    onClicked: {
                        proc.command = [ modelData ]
                        proc.startDetached()
                        root.openDrawer = false
                    }
                }
            }
        }
    }

    Process {
        id: proc
    }
}
