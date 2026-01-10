import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../state"

RowLayout {
    id: root
    spacing: 6
    height: parent.height

    property int cpu: 0
    property int ram: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "grep 'cpu ' /proc/stat"]
        stdout: SplitParser {
            onRead: d => {
                if (!d) return
                const p = d.trim().split(/\s+/)
                const idle = +p[4]
                const total = p.slice(1).reduce((a, b) => a + +b, 0)
                root.cpu = Math.round(100 * (1 - idle / total))
            }
        }
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | awk '/Mem/ {print int($3/$2*100)}'"]
        stdout: SplitParser {
            onRead: d => {
                if (d) root.ram = parseInt(d)
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
        }
    }

    Text { text: "CPU " + root.cpu + "%"; color: Theme.color4 }
    Text { text: "RAM " + root.ram + "%"; color: Theme.color2 }
}
