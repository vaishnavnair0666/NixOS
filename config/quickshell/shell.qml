import Quickshell
import QtQuick

// Local modules
import "windows"
import "state"

ShellRoot {
    id: shell


    property bool showBar: true
    property bool showThemeSwitcher: false


    Bar {
        visible: shell.showBar
        onOpenThemeSwitcher: {
            shell.showThemeSwitcher = !shell.showThemeSwitcher
        }
    }


    ThemeSwitcher {
        visible: shell.showThemeSwitcher
        onClose: shell.showThemeSwitcher = false
    }
}
