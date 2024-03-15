import QtQuick

Image {
    id: image

    required property real cooldownTime
    required property bool paused
    property bool planting: false
    required property int sunlightConsumption
    required property int sunlightSum

    signal buzzered
    signal plantCanceled
    signal plantStarted

    function plant() {
        if (planting) {
            planting = false;
            numberAnimation.start();
        }
    }

    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 140 * 100

    Rectangle {
        id: curtain

        anchors.fill: parent
        color: '#000000'
        opacity: 0.5
        visible: !parent.enabled || deepCurtain.height > 0 || parent.sunlightSum < parent.sunlightConsumption
    }

    Rectangle {
        id: deepCurtain

        color: '#000000'
        opacity: 0.8
        width: parent.width
    }

    NumberAnimation {
        id: numberAnimation

        duration: image.cooldownTime
        paused: running && image.paused
        properties: 'height'
        target: deepCurtain
        to: 0
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: parent.enabled

        onClicked: {
            if (!parent.planting && !curtain.visible) {
                deepCurtain.height = height;
                parent.planting = true;
                parent.plantStarted();
            } else if (planting) {
                deepCurtain.height = 0;
                parent.planting = false;
                parent.plantCanceled();
            } else
                parent.buzzered();
        }
    }
}
