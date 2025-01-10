import QtQuick

Image {
    asynchronous: true
    mipmap: true
    source: '../../res/scenes/shadow.png'
    sourceSize: Qt.size(width, height)
    width: height / 49 * 73
}
