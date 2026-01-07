import Quickshell
import QtQuick

FloatingWindow {
    required property MediaState media
    signal close()

    width: 400
    height: 200

    Text {
        text: media.currentTrack
    }
}
