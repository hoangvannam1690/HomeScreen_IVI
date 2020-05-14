import QtQuick 2.0

MouseArea {
    id: root
//    implicitWidth:
//    implicitHeight:
//    width:  316 *scaleRatio
//    height: 526 *scaleRatio
    width: 620
    height: 340

    property string icon
    property string btnTitle

    Image {
        id: idBackgroud
        width: root.width
        height: root.height
        source: icon + "_n.png"
    }
//    Text {
//        id: appTitle
//        anchors.horizontalCenter: parent.horizontalCenter
//        y: 350 *scaleRatio
//        text: title
//        font.pixelSize: 36 *scaleRatio
//        color: "white"
//    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
                scale: 0.8
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_n.png"
            }
        }
    ]

    onPressed: root.state = "Pressed"
    onReleased: {
        root.focus = true
        root.state = "Focus"
    }
    onFocusChanged: {
        if (root.focus === true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
}
