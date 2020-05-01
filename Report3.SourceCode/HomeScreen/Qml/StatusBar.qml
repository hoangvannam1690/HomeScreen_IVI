import QtQuick 2.0
import QtQuick.Layouts 1.11
import "Common"
import QtQml 2.2

Item {
    implicitWidth: 1920 * scaleRatioStatusBar
    implicitHeight: 104 * scaleRatioStatusBar
    signal bntBackClicked
    property bool isShowBackBtn: false
    property var scaleRatioStatusBar: 1
    Button {
        anchors.left: parent.left
        icon: "qrc:/Img/StatusBar/btn_top_back"
        width: 135 * scaleRatioStatusBar
        height: 101 * scaleRatioStatusBar
        iconWidth: width
        iconHeight: height
        onClicked: bntBackClicked()
        visible: isShowBackBtn
    }

    Item {
        id: clockArea
        x: 660 * scaleRatioStatusBar
        width: 300 * scaleRatioStatusBar
        height: parent.height
        Image {
            anchors.left: parent.left
            height: 104 * scaleRatioStatusBar
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
        Text {
            id: clockTime
            text: "10:28"
            color: "white"
            font.pixelSize: 72  * scaleRatioStatusBar
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104  * scaleRatioStatusBar
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }
    Item {
        id: dayArea
        anchors.left: clockArea.right
        width: 300  * scaleRatioStatusBar
        height: parent.height
        Text {
            id: day
            text: "Jun. 24"
            color: "white"
            font.pixelSize: 72  * scaleRatioStatusBar
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104  * scaleRatioStatusBar
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }

    QtObject {
        id: time
        property var locale: Qt.locale("en_US")
        property date currentTime: new Date()

        Component.onCompleted: {
            clockTime.text = currentTime.toLocaleTimeString(locale, "hh:mm");
            day.text = currentTime.toLocaleDateString(locale, "MMM. dd");
        }
    }

    Timer{
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            time.currentTime = new Date()
            clockTime.text = time.currentTime.toLocaleTimeString(locale, "hh:mm");
            day.text = time.currentTime.toLocaleDateString(Qt.locale("en_US"), "MMM. dd");
        }
    }
}
