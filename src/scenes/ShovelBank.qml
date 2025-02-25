import QtQuick
import QtMultimedia

Image {
    property bool shoveling: false

    signal clicked

    asynchronous: true
    mipmap: true
    source: '../../res/scenes/shovelBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 72 * 70

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: parent.enabled

        onClicked: {
            soundEffect.play();
            parent.clicked();
        }

        SoundEffect {
            id: soundEffect

            source: '../../res/sounds/shovel.wav'
        }
    }
}
