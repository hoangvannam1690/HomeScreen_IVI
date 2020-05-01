import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root
    width: 1920
    height: 1200 -104 -141

//    XAnimator{
//        target: root
//        from: 1920
//        to: 0
//        duration: 200
//        running: true
//    }

    Rectangle {
       id: mDialScreen
       anchors.fill: parent

       color: "transparent"

       Rectangle {
           id: mrtg
           width: 600
           height: 120
           y: 100
           anchors.horizontalCenter:  parent.horizontalCenter
           color: "white"
           Text {
               id: mtxt
               anchors.fill: parent
               horizontalAlignment: Text.AlignRight
               verticalAlignment: Text.AlignVCenter
               text: callNumber
               color: "black"
               font.pixelSize: 46
           }
       }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            stackView.pop()
        }
    }
}
