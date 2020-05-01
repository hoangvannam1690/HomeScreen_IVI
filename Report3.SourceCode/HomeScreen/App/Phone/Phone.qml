import QtQuick 2.11
import QtQuick.Controls 2.4

import "./../Common/"      // Header
import "./"                // Button

Item {
    id: root
    width: screenWidth
    height: screenHeight - (70 * appScale)
    focus: true

    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    property string callNumber
    property bool isCall: false

    XAnimator{
        target: root
        from: screenWidth
        to: 0
        duration: 200
        running: true
    }

    //Header
    AppHeader{
        id: headerItem
        appName: "Phone"
    }

    Rectangle{
        id: numberDial
        width: screenWidth
        height:  screenHeight - (141 * appScale)
        anchors.top: headerItem.bottom
        color: "transparent"

        TextField {
            id: numberDisplay
            width: 600* appScale
            height: 120* appScale
            y: 100 *appScale
            anchors.horizontalCenter: parent.horizontalCenter

            horizontalAlignment: Text.AlignRight
            color: "black"
            font.pixelSize: 46 * appScale
            clip: true
            text: callNumber
        }

        Grid {
            id: keypad
            anchors.top: parent.top
            anchors.topMargin: numberDisplay.height + numberDisplay.y + 50 *appScale
            anchors.horizontalCenter:  parent.horizontalCenter

            OpacityAnimator {
                id: myAnimator
                target: keypad
                from: 1
                to: 0.3
                duration: 800
                running: false
            }

            columns: 3
            columnSpacing: 25 * appScale
            rowSpacing: 25 * appScale

            MyButton { id: btn01; title: "1"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn02; title: "2"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn03; title: "3"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn04; title: "4"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn05; title: "5"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn06; title: "6"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn07; title: "7"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn08; title: "8"; onClicked: if(!isCall) callNumber += title }
            MyButton { id: btn09; title: "9"; onClicked: if(!isCall) callNumber += title }

            MyButton {
                id: btnCall
                title: "Call"
                onClicked: {
                    if(isCall == false) {
                        callNumber = "Calling... " + callNumber
                        isCall = true
                    }
                }
            }
            MyButton { id: btn00; title: "0"; onClicked: if(!isCall) callNumber += title }
            MyButton {
                id: btnReject
                title: "Reject"
                onClicked: {
                    callNumber = ""
                    isCall = false
                }
            }
        }
    }

    function myAnimation () {
        myAnimator.running = true
    }
}

