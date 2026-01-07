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
        color: "#24283b"

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 6

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            /* ===== Header ===== */

            Text {
                text: "Wallpapers"
                color: Theme.fg
                font.pixelSize: 16
                font.bold: true
            }

            /* ===== Grid ===== */

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
                            color: Theme.accent

                            property bool selected:
                                filePath === selectedWallpaper

                            Image {
                                anchors.fill: parent
                                source: fileUrl
                                fillMode: Image.PreserveAspectCrop
                                asynchronous: true
                                cache: true
                            }

                            /* Selection overlay */
                            Rectangle {
                                anchors.fill: parent
                                color: selected ? "#7aa2f7" : "black"
                                opacity: selected ? 0.25 : 0.12
                            }

                            /* Selection border */
                            Rectangle {
                                anchors.fill: parent
                                radius: 8
                                color: "transparent"
                                border.width: selected ? 2 : 0
                                border.color: "#7aa2f7"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selectedWallpaper = filePath

                                    applyWallpaperProc.command = [
                                        "swww",
                                        "img",
                                        filePath,
                                        "--transition-type",
                                        "any",
                                        "--transition-duration",
                                        "0.8"
                                    ]
                                    applyWallpaperProc.running = true
                                }
                            }
                        }
                    }
                }
            }

            /* ===== Close ===== */

            Rectangle {
                Layout.fillWidth: true
                height: 36
                radius: 6
                color: Theme.danger

                Text {
                    anchors.centerIn: parent
                    text: "Close"
                    color: "black"
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
