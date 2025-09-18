import Quickshell
import QtQuick
import QtQuick.Layouts
// Import your modules from the modules/ folder
import "modules"
PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 40
    color: "#282c34"

    RowLayout {
        anchors.fill: parent
        // Left: Workspace names
        WorkspaceModule { }

        // Spacer to push clock into center
        Item { Layout.fillWidth: true }

        // Center: Clock
        ClockModule { }

        // Spacer to push sysinfo to right
        Item { Layout.fillWidth: true }

		// AppLauncherModule { }
        // Item { Layout.fillWidth: true }
        // Right: System info + buttons
        SysInfoModule { }
    }
}
