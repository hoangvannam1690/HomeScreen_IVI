import QtQuick 2.0
import QtQuick.Controls 2.2

Popup {
    id: testPopup

    property string popupInfoName: "Popup Title"
    property var popMargins: 25
    topInset: 0
    leftInset: 0
    rightInset: 0

    width: iconListArea.width
    height: iconListArea.height
    anchors.centerIn: parent

    background: Rectangle {
        id: bgPopup
        anchors.fill: parent
        color: "transparent"    // "blue"     //"transparent"
        opacity: 0.05
        anchors.margins: popMargins

    }

    modal: false   // True: Làm mờ toàn bộ các item bên ngoài popup, cả StatusBar cũng bị ảnh hưởng
    focus: true
    closePolicy: Popup.CloseOnEscape   // | Popup.CloseOnPressOutsideParent

    // Hiệu ứng khi đóng / mở popup
    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0.0
            to: 1.0
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1.0
            to: 0.0
            duration: 150
        }
    }


    Rectangle {
        id: headerPopup
        width: parent.width
        height: parent.height/10

        color: "transparent"  //"red"
        opacity: 1

        Text {
            id: namePopup
            text: popupInfoName

            font.pixelSize: 36
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }   

    onClosed: settingMenu.opacity = 1
}
