import Quickshell
import QtQuick

import "windows"
import "state"

ShellRoot {
    id: shell

    property bool showBar: true
    property bool showThemeSwitcher: false
    property bool showCalendar: false

    /* ===== Bar ===== */
    Bar {
        visible: shell.showBar
        onOpenThemeSwitcher: shell.showThemeSwitcher = !shell.showThemeSwitcher
        onClockClicked: shell.showCalendar = !shell.showCalendar
    }

    /* ===== Outside click catcher (BEHIND calendar) ===== */
    PanelWindow {
        visible: shell.showCalendar
        exclusiveZone: -1
        color: "#00000000"

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: shell.showCalendar = false
        }
    }

    /* ===== Calendar (ON TOP of click catcher) ===== */
    CalendarPanel {
        visible: shell.showCalendar
    }

    /* ===== Theme switcher ===== */
    ThemeSwitcher {
        visible: shell.showThemeSwitcher
        onClose: shell.showThemeSwitcher = false
    }
}
