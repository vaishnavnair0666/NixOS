pragma Singleton
import QtQuick

QtObject {
    /* ===== META ===== */
    property string name: "ansi"

    /* ===== ANSI CORE ===== */
    property color background: "#000000"
    property color foreground: "#ffffff"
    // property color cursor: "#ffffff"

    /* ===== ANSI 16 COLORS ===== */
    property color color0: "#000000"
    property color color1: "#ff0000"
    property color color2: "#00ff00"
    property color color3: "#ffff00"
    property color color4: "#0000ff"
    property color color5: "#ff00ff"
    property color color6: "#00ffff"
    property color color7: "#ffffff"

    property color color8: "#808080"
    property color color9: "#ff5555"
    property color color10: "#55ff55"
    property color color11: "#ffff55"
    property color color12: "#5555ff"
    property color color13: "#ff55ff"
    property color color14: "#55ffff"
    property color color15: "#ffffff"

    /* ===== APPLY ANSI ===== */
    function applyFromAnsi(p) {
        name = p.wallpaper ?? "wallust-ansi"

        background = p.background
        foreground = p.foreground
        // cursor = p.cursor

        color0 = p.color0
        color1 = p.color1
        color2 = p.color2
        color3 = p.color3
        color4 = p.color4
        color5 = p.color5
        color6 = p.color6
        color7 = p.color7

        color8 = p.color8
        color9 = p.color9
        color10 = p.color10
        color11 = p.color11
        color12 = p.color12
        color13 = p.color13
        color14 = p.color14
        color15 = p.color15
    }
}
