pragma Singleton
import QtQuick

QtObject {
    /* =====================
       META
       ===================== */

    property string name: "tokyonight"

    /* =====================
       BASE COLORS
       ===================== */

    property color bg: "#24283b"
    property color panel: "#1f2335"
    property color surface: "#2a2f45"

    property color fg: "#c0caf5"
    property color muted: "#565f89"

    property color accent: "#7aa2f7"
    property color accentAlt: "#bb9af7"

    property color danger: "#f7768e"
    property color warning: "#e0af68"

    /* =====================
       THEME APPLIERS
       ===================== */

    function applyTokyoNight() {
        name = "tokyonight"
        bg = "#24283b"
        panel = "#1f2335"
        surface = "#2a2f45"
        fg = "#c0caf5"
        muted = "#565f89"
        accent = "#7aa2f7"
        accentAlt = "#bb9af7"
        danger = "#f7768e"
        warning = "#e0af68"
    }

    function applyLight() {
        name = "light"
        bg = "#f5f5f5"
        panel = "#ffffff"
        surface = "#eaeaea"
        fg = "#1a1a1a"
        muted = "#777777"
        accent = "#005fcc"
        accentAlt = "#7b5cff"
        danger = "#d70000"
        warning = "#b58900"
    }
}
