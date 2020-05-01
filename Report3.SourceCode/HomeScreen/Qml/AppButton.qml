import QtQuick 2.0

MouseArea {
    id: root
//    implicitWidth: 316 *scaleRatio
//    implicitHeight: 526 *scaleRatio
    width:  316 *scaleRatio
    height: 526 *scaleRatio

    property string icon
    property string title

    preventStealing: false  //  true: không flick listview được

    Image {
        id: idBackgroud
        width: root.width
        height: root.height     // +78
        source: icon + "_n.png"
    }
    Text {
        id: appTitle
        anchors.horizontalCenter: parent.horizontalCenter
        y: 350 *scaleRatio
        text: title
        font.pixelSize: 36 *scaleRatio
        color: "white"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_n.png"
            }
        },
        State {
            name: "Drag"
            PropertyChanges {
                target: idBackgroud // app
                source: icon + "_p.png"
                scale: 1.15  //1.2
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
