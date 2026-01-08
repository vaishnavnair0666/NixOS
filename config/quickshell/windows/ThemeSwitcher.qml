import Qt.labs.folderlistmodel
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../state"

PanelWindow {
    id: dropdown
    signal close()
    exclusiveZone: -1

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 420
    color: "#01000000"

    Process { id: wallustProc }

	Process {
		id: loadAnsiThemeProc
		property string buf: ""

		command: ["cat", "/home/vaish/.cache/wallust/ansi.json"]

		stdout: SplitParser {
			onRead: function(chunk) {
				if (!chunk) return
				loadAnsiThemeProc.buf += chunk
			}
		}

		Component.onCompleted: {
			buf = ""
		}

		onRunningChanged: {
			if (!running && buf.length > 0) {
				try {
					Theme.applyFromAnsi(JSON.parse(buf))
					console.log("ANSI theme applied")
				} catch (e) {
					console.error("ANSI parse error", e)
				}
				buf = ""
			}
		}
	}

    /* =====================
       STATE
       ===================== */

    property string selectedWallpaper: ""

    /* =====================
       WALLPAPER MODEL
       ===================== */

    FolderListModel {
        id: wallpaperModel
        folder: "file:///home/vaish/Pictures/Wallpapers"
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]
        showDirs: false
        showDotAndDotDot: false
        sortField: FolderListModel.Name
    }

    /* =====================
       APPLY WALLPAPER
       ===================== */

    Process {
        id: applyWallpaperProc
    }

    /* =====================
       UI
       ===================== */

    Rectangle {
        id: panel
        width: Math.min(parent.width, 420)
        height: parent.height
        radius: 12
        color: Theme.background

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 6

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            Text {
                text: "Wallpapers"
                color: Theme.foreground
                font.pixelSize: 16
                font.bold: true
            }

            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                contentHeight: grid.implicitHeight

                Grid {
                    id: grid
                    width: parent.width
                    columns: 3
                    spacing: 10

                    Repeater {
                        model: wallpaperModel

                        Rectangle {
                            width: (grid.width - (grid.columns - 1) * grid.spacing) / grid.columns
                            height: width * 0.6
                            radius: 8
                            clip: true
                            color: Theme.color8

                            property bool selected:
                                filePath === selectedWallpaper

                            Image {
                                anchors.fill: parent
                                source: fileUrl
                                fillMode: Image.PreserveAspectCrop
                                asynchronous: true
                                cache: true
                            }

                            Rectangle {
                                anchors.fill: parent
                                color: selected ? Theme.color4 : "black"
                                opacity: selected ? 0.25 : 0.12
                            }

                            Rectangle {
                                anchors.fill: parent
                                radius: 8
                                color: "transparent"
                                border.width: selected ? 2 : 0
                                border.color: Theme.color4
                            }

                            MouseArea {
                                anchors.fill: parent
								onClicked: {
									selectedWallpaper = filePath

									applyWallpaperProc.command = [
										"swww", "img", filePath,
										"--transition-type", "any",
										"--transition-duration", "0.8"
									]
									applyWallpaperProc.running = true

									wallustProc.command = ["wallust", "run", filePath]
									wallustProc.running = true

									Qt.callLater(function () {
										loadAnsiThemeProc.running = true
									})
								}
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 36
                radius: 6
                color: Theme.color1

                Text {
                    anchors.centerIn: parent
                    text: "Close"
                    color: Theme.foreground
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: dropdown.close()
                }
            }
        }
    }
}
