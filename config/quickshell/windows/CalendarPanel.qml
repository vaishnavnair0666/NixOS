import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../state"

PanelWindow {
    id: calendar

    exclusiveZone: -1
    visible: false
    focusable: visible

    anchors {
        top: true
        right: true
    }
	margins{
		top : 38
	}
    implicitWidth: 320
    implicitHeight: 360
    color: "transparent"

    /* ===== Real current date ===== */
    readonly property date today: new Date()

    /* ===== Viewed month/year ===== */
    property int viewYear: today.getFullYear()
    property int viewMonth: today.getMonth()   // 0-based

    /* ===== Selection ===== */
    property int selectedDay: today.getDate()

    /* ===== Derived values ===== */
    property date firstOfMonth: new Date(viewYear, viewMonth, 1)
    property int startOffset: (firstOfMonth.getDay() + 6) % 7
    property int daysInMonth: new Date(viewYear, viewMonth + 1, 0).getDate()

    /* ===== Lifecycle ===== */
    onVisibleChanged: {
        if (visible) {
            forceActiveFocus()
            selectedDay = today.getDate()
        }
    }

    /* ===== Month switching ===== */
    function changeMonth(delta) {
        viewMonth += delta
        if (viewMonth < 0) {
            viewMonth = 11
            viewYear--
        } else if (viewMonth > 11) {
            viewMonth = 0
            viewYear++
        }
        selectedDay = 1
    }

    /* ===== Keyboard navigation ===== */
    Keys.onPressed: function(event) {
        if (!visible) return

        switch (event.key) {
        case Qt.Key_Left:
            selectedDay = Math.max(1, selectedDay - 1)
            break
        case Qt.Key_Right:
            selectedDay = Math.min(daysInMonth, selectedDay + 1)
            break
        case Qt.Key_Up:
            selectedDay = Math.max(1, selectedDay - 7)
            break
        case Qt.Key_Down:
            selectedDay = Math.min(daysInMonth, selectedDay + 7)
            break
        case Qt.Key_PageUp:
            changeMonth(-1)
            break
        case Qt.Key_PageDown:
            changeMonth(1)
            break
        case Qt.Key_Escape:
            visible = false
            break
        default:
            return
        }

        event.accepted = true
    }

    /* ===== UI ===== */
    Rectangle {
        anchors.fill: parent
        radius: 12
        color: Theme.background
        border.color: Theme.color8
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            /* ===== Header with month controls ===== */
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "‹"
                    font.pixelSize: 16
                    color: Theme.foreground
                    MouseArea {
                        anchors.fill: parent
                        onClicked: changeMonth(-1)
                    }
                }

                Text {
                    Layout.fillWidth: true
                    text: Qt.formatDate(new Date(viewYear, viewMonth, 1), "MMMM yyyy")
                    horizontalAlignment: Text.AlignHCenter
                    color: Theme.foreground
                    font.bold: true
                    font.pixelSize: 14
                }

                Text {
                    text: "›"
                    font.pixelSize: 16
                    color: Theme.foreground
                    MouseArea {
                        anchors.fill: parent
                        onClicked: changeMonth(1)
                    }
                }
            }

            /* ===== Month grid ===== */
            GridLayout {
                columns: 7
                columnSpacing: 6
                rowSpacing: 6

                Repeater {
                    model: ["Mo","Tu","We","Th","Fr","Sa","Su"]
                    Text {
                        text: modelData
                        color: Theme.muted
                        font.pixelSize: 11
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                Repeater {
                    model: 42

                    Rectangle {
                        width: 36
                        height: 28
                        radius: 6

                        property int dayNumber: index - startOffset + 1
                        property bool validDay: dayNumber >= 1 && dayNumber <= daysInMonth
                        property bool isToday:
                            validDay &&
                            viewYear === today.getFullYear() &&
                            viewMonth === today.getMonth() &&
                            dayNumber === today.getDate()
                        property bool isSelected: validDay && dayNumber === selectedDay

                        color: isToday
                            ? Theme.color4
                            : isSelected
                                ? Theme.color2
                                : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: validDay ? dayNumber : ""
                            color: (isToday || isSelected)
                                ? Theme.background
                                : Theme.foreground
                            font.pixelSize: 11
                        }
                    }
                }
            }

            /* ===== Agenda (placeholder) ===== */
            ColumnLayout {
                spacing: 6

                Text {
                    text: "Today"
                    color: Theme.foreground
                    font.bold: true
                    font.pixelSize: 12
                }

                Repeater {
                    model: [
                        { time: "10:00", title: "Standup" },
                        { time: "14:30", title: "Review" }
                    ]

                    RowLayout {
                        spacing: 6

                        Text {
                            text: modelData.time
                            color: Theme.color4
                            font.pixelSize: 11
                        }

                        Text {
                            text: modelData.title
                            color: Theme.foreground
                            font.pixelSize: 11
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
    }
}
