import Quickshell 
import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 

Window {
    id: launcher
    width: 500
    height: 400
    visible: true
    color: "#222222"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    // center window on screen
    Component.onCompleted: {
        var screen = Qt.application.screens[0]
        x = (screen.width - width) / 2
        y = (screen.height - height) / 3
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8
        // padding: 12

        TextField {
            id: search
            placeholderText: "Search apps..."
            Layout.fillWidth: true
            focus: true
        }

        ListView {
            id: appList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: [
                "firefox",
                "alacritty",
                "thunar",
                "nvim"
            ]

            delegate: Button {
                text: modelData
                onClicked: {
                    Quickshell.execDetached(modelData)
                    Qt.quit()   // close after launch
                }
            }
        }
    }

    // Escape key to close launcher
    Keys.onReleased: if (event.key === Qt.Key_Escape) Qt.quit()
}
