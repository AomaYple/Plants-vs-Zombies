import QtQuick

AnimatedImage {
    id: animatedImage

    required property point collectedPosition
    required property real endPositionY
    required property bool natural
    property bool picked: true

    signal clicked
    signal collected

    asynchronous: true
    mipmap: true
    source: '../../res/scenes/sunlight.gif'
    sourceSize: Qt.size(width, height)
    width: height / 56 * 57

    onStatusChanged: if (status === Image.Ready) {
        if (natural) {
            yAnimation.duration = 5000;
            yAnimation.to = endPositionY;
            yAnimation.start();
        } else {
            scale = 0.5;
            scaleAnimation.start();
        }
    }

    SuspendableTimer {
        interval: 8000
        paused: parent.paused
        running: mouseArea.enabled

        onTriggered: {
            parent.picked = false;
            opacityAnimation.start();
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            enabled = false;
            scaleAnimation.complete();
            yAnimation.stop();
            yAnimation.to = collectedPosition.y;
            yAnimation.duration = xAnimation.duration;
            xAnimation.start();
            yAnimation.start();
            parent.clicked();
        }
    }

    NumberAnimation {
        id: xAnimation

        duration: 500
        paused: running && target.paused
        properties: 'x'
        target: animatedImage
        to: target.collectedPosition.x

        onFinished: opacityAnimation.start()
    }

    NumberAnimation {
        id: yAnimation

        paused: running && target.paused
        properties: 'y'
        target: animatedImage
    }

    NumberAnimation {
        id: scaleAnimation

        duration: 300
        paused: running && target.paused
        properties: 'scale'
        target: animatedImage
        to: 1

        onFinished: {
            yAnimation.to = endPositionY;
            yAnimation.start();
        }
    }

    NumberAnimation {
        id: opacityAnimation

        duration: 500
        paused: running && target.paused
        properties: 'opacity'
        target: animatedImage
        to: 0

        onFinished: {
            target.destroy();
            if (target.picked)
                target.collected();
        }
    }
}
