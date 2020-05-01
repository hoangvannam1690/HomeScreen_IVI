import QtQuick 2.0
//import QtQuick 2.11
import QtQuick.Controls 2.4
//import "./../Phone/"

Rectangle {
    id: root
    anchors.fill: parent
    anchors.centerIn: parent
    color: "transparent"
    visible: true
    //    opacity: 0.3

    TabBar {
        id: tabBar
        width: TabButton.width*buttonRepeater.count
        height: 100*appScale
        anchors.top: parent.top
        anchors.topMargin: 125*appScale
        anchors.horizontalCenter: parent.horizontalCenter
        contentHeight: 90*appScale
        background: Rectangle {
            color: "transparent"
        }

        Repeater {
            id: buttonRepeater
            model: ["Date", "Time", "Other"]
            TabButton {
                id: btn
                text: modelData
                font.pixelSize: 36 * appScale
                width: 300 * appScale

                background: Rectangle {
                    color: "lightgreen"
                    radius: 10
                    opacity: 0.8
                }
            }
        }
    }
}
