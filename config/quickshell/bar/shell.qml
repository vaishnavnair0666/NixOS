import QtQuick
import QtQuick.Layouts
import Quickshell
import "modules" as Modules


ShellRoot {
	// Create a Bar on every monitor
	Variants {
		model: Quickshell.screens


		Modules.Bar {
			screen: modelData
		}
	}
}
