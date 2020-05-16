import QtQuick 2.0
import QtQuick.Layouts 1.11
import "Common"
import QtQml 2.2

Item {
    implicitWidth: 1920 * scaleRatio
    implicitHeight: 104 * scaleRatio
    signal bntBackClicked
    property bool isShowBackBtn: false
    Button {
        anchors.left: parent.left
        icon: "qrc:/Img/StatusBar/btn_top_back"
        width: 135 * scaleRatio
        height: 101 * scaleRatio
        iconWidth: width
        iconHeight: height
        onClicked: bntBackClicked()
        visible: isShowBackBtn
    }

    Item {
        id: clockArea
        x: 660 * scaleRatio
        width: 300 * scaleRatio
        height: parent.height
        Image {
            anchors.left: parent.left
            height: 104 * scaleRatio
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
        Text {
            id: clockTime
            text: "10:28"
            color: "white"
            font.pixelSize: 72  * scaleRatio
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104  * scaleRatio
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }
    Item {
        id: dayArea
        anchors.left: clockArea.right
        width: 300  * scaleRatio
        height: parent.height
        Text {
            id: day
            text: "Jun. 24"
            color: "white"
            font.pixelSize: 72  * scaleRatio
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104  * scaleRatio
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }

    Image {
        id: batteryArea
        source: "qrc:/Img/StatusBar/indi_battery_06.png"
        anchors.right: parent.right
        anchors.rightMargin: 30 *scaleRatio
        anchors.verticalCenter:  parent.verticalCenter
    }

    Image {
        id: lteArea
        source: "qrc:/Img/StatusBar/indi_rssi_bt_06.png"
        anchors.right: batteryArea.left
        anchors.rightMargin: 30 *scaleRatio
        anchors.verticalCenter:  parent.verticalCenter
    }

    Image {
        id: wifiArea
        source: "qrc:/Img/StatusBar/indi_wifi_04.png"
        anchors.right: lteArea.left
        anchors.rightMargin: 30 *scaleRatio
        anchors.verticalCenter:  parent.verticalCenter
    }

    // Display khi gọi điện rảnh tay bluetooth
    Image {
        id: btDialArea
        source: "qrc:/Img/StatusBar/indi_dial_bt.png"
        anchors.right: wifiArea.left
        anchors.rightMargin: 30 *scaleRatio
        anchors.verticalCenter:  parent.verticalCenter
        visible: false
//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                if(btDialArea.visible == false) btDialArea.visible = true
//                else btDialArea.visible = false
//                muteArea.anchors.right = btDialArea.visible ? btDialArea.left : wifiArea.left
//            }
//        }
    }

    // Mute
    property bool isMute: false
    Image {
        id: muteArea
        source: "qrc:/Img/StatusBar/indi_audio_on.png"
        anchors.right: btDialArea.visible ? btDialArea.left : wifiArea.left
        anchors.rightMargin: 30 *scaleRatio
        anchors.verticalCenter:  parent.verticalCenter
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: {
                isMute = !isMute
                muteArea.source = isMute ? "qrc:/Img/StatusBar/indi_audio_off.png" : "qrc:/Img/StatusBar/indi_audio_on.png"
            }
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
