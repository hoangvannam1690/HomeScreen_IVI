import QtQuick 2.0

// Button used in Phone
MouseArea {
    id: root
    implicitWidth: 180 * appScale
    implicitHeight: 75 * appScale
    property string icon
    property string title

//    preventStealing: false  //  true: không flick listview được

    Rectangle {
        id: idBackgroud
        width: root.width
        height: root.height
        radius: 10 *appScale
        color: "white"
        opacity: 0.5
    }

    Text {
        id: appTitle
        anchors.centerIn: parent
        text: title
        font.pixelSize: 32 *appScale
        color: "blue"
    }

    states: [
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                opacity: 0.9
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                opacity: 0.5
            }
        }
    ]

    onPressed: root.state = "Pressed"
    onReleased: root.state = "Normal"
}
