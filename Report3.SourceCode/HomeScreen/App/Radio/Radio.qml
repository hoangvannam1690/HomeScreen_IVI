import QtQuick 2.11
import QtQuick.Controls 2.4
import QtMultimedia 5.9

import QtGraphicalEffects 1.0
import QtQuick.Extras 1.4
import QtQuick.Window 2.0

import "./../Common/"
import "./../Phone/"    //MyButton.qml

Item {
    id: root    
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: screenHeight - 104*appScale  // screenHeight - statusBar.height    

    opacity: 1

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
        appName: "Radio"
    }

    // Background
    Image {
        id: radio_bg
        anchors.top: headerItem.bottom
        width: 1920 *appScale
        height: root.height - headerItem.height
        source: "qrc:/App/Radio/Data/radio_bg0.png"
    }

    Audio {
        id: radio
        source: radioListModel.get(0).url            //radioListModel.get(currentIndex).url
    }

    ListModel {
        id: radioListModel
        ListElement { name: "VOV Giao Thông HCM"; url: "https://5a6872aace0ce.streamlock.net/nghevovgthcm/vovgthcm.stream_aac/playlist.m3u8"}
        ListElement { name: "VOV Giao Thông HN"; url: "https://5a6872aace0ce.streamlock.net/nghevovgthn/vovgthn.stream_aac/chunklist_w1165648695.m3u8"}
        ListElement { name: "VOV1"; url: "https://5a6872aace0ce.streamlock.net/nghevov1/vov1.stream_aac/chunklist_w221458733.m3u8"}
        ListElement { name: "VOV2"; url: "https://5a6872aace0ce.streamlock.net/nghevov2/vov2.stream_aac/chunklist_w744829061.m3u8"}
        ListElement { name: "VOV3"; url: "https://5a6872aace0ce.streamlock.net/nghevov3/vov3.stream_aac/chunklist_w1731217585.m3u8"}
        ListElement { name: "VOV4"; url: "https://5a6872aace0ce.streamlock.net/nghevovmientrung/vovmientrung.stream_aac/chunklist_w377809675.m3u8"}
        ListElement { name: "VOV5"; url: "https://5a6872aace0ce.streamlock.net/nghevov5/vov5.stream_aac/chunklist_w1905585553.m3u8"}
        ListElement { name: "VOV63"; url: "https://5a6872aace0ce.streamlock.net/nghevov63/vov63.stream_aac/playlist.m3u8"}
        ListElement { name: "VOV247"; url: "https://5a6872aace0ce.streamlock.net/nghevov247/vov247.stream_aac/playlist.m3u8"}
        ListElement { name: "VOV Mekong 90"; url: "http://media.kythuatvov.vn:1936/live/MEKONG.sdp/playlist.m3u8"}
        ListElement { name: "VOV Sức Khỏe"; url: "http://media.kythuatvov.vn:1936/live/VOV89.sdp/playlist.m3u8"}
        ListElement { name: "VOH 95.6"; url: "http://125.212.213.71:1935/live/channel1/playlist.m3u8"}
        ListElement { name: "VOH AM.610"; url: "http://125.212.213.71:1935/live/channel2/playlist.m3u8"}
        ListElement { name: "VOH 99.9"; url: "http://125.212.213.71:1935/live/channel3/playlist.m3u8"}
        // ListElement { name: "XONE FM"; url: "http://node-29.zeno.fm/v51ym0g96qruv"}   // WARNING: channel này load bị treo?
        ListElement { name: "JOY FM"; url: "http://cdn.mediatech.vn/hntvRadio/joyfm.stream_aac/playlist.m3u8"}
        ListElement { name: "Bình Dương 92.5"; url: "https://hplusliveall.e96bbe18.sabai.vn/570448cae6e420d5057ba249a3d1b6c31588823059/btvfm92.audio.sbd.tms/chunklist.m3u8"}
    }

    //==========================================================================
    Rectangle {
        id: radioListArea
        width: 900 * appScale
        height: root.height - headerItem.height
        anchors.centerIn: radio_bg  //parent
        color: "transparent"
    }

    Component {
        id: appDelegate
        Item {
            width: 350 *appScale
            height: 128 *appScale
            scale: PathView.iconScale
            property real  rotationAngle: PathView.angle

            Text {
                anchors.centerIn: parent
                text: name
                font.pixelSize: 56 *appScale
                color: "white"
                smooth: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    view.currentIndex = index
                    console.log("Clicked - index: " + index);
                     radio.stop()   // Dừng phát kênh trước đó
                    radio.source = url
                    radio.play()
                    console.log(url)
                    isPlay = true
                }
            }
        }
    }

    Component {
        id: appHighlight
        Rectangle {
            width: radioListArea.width
            height: 80
            color: "lightsteelblue"     //"transparent"
            opacity: 0.2
        }
    }

    PathView {
        parent: radioListArea

        id: view
        anchors.fill: parent
        highlight: appHighlight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
//        focus: true
        model: radioListModel
        delegate: appDelegate

        onCurrentIndexChanged: {
            console.log(radioListModel.get(currentIndex).url)
            radio.source = radioListModel.get(currentIndex).url
            if(isPlay == true) {
                radio.play()
                // isPlay = true
            }
        }

        //======================
        KeyNavigation.left: btnPlay
        KeyNavigation.right: btnRescan

        pathItemCount: 5
        path: Path {
            startX: radioListArea.width/2
            startY: 0
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "angle"; value: 75 }
            PathAttribute { name: "iconScale"; value: 0.35 }
            PathLine { x: radioListArea.width / 2; y: radioListArea.height / 4;  }
            PathAttribute { name: "z"; value: 50 }
            PathAttribute { name: "angle"; value: 70 }
            PathAttribute { name: "iconScale"; value: 0.65 }
            PathLine { x: radioListArea.width /2; y: radioListArea.height/2; }
            PathAttribute { name: "z"; value: 100 }
            PathAttribute { name: "angle"; value: 0 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: radioListArea.width /2; y: 3*(radioListArea.height/4); }
            PathAttribute { name: "z"; value: 50 }
            PathAttribute { name: "angle"; value: -70 }
            PathAttribute { name: "iconScale"; value: 0.65 }
            PathLine { x: radioListArea.width /2; y: radioListArea.height; }
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "angle"; value: -75 }
            PathAttribute { name: "iconScale"; value: 0.35 }
        }
    }

    //==========================================================================

    // Khu vực button
    // Next
    MouseArea {
        id: btnNext
        focus: true
        width: 620 *appScale
        height: 340 *appScale
        anchors.top: headerItem.bottom
        anchors.left: radio_bg.left

        //===============================
        KeyNavigation.up: btnPre
        KeyNavigation.down: btnPlay
        KeyNavigation.right: btnVolUp
        //===============================
        Keys.onPressed: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                nextImg.source = "qrc:/App/Radio/Data/Next_p.png"
                nextImg.scale = 0.9
                view.decrementCurrentIndex()
            }
        }
        Keys.onReleased: {
            nextImg.source = "qrc:/App/Radio/Data/Next_n.png"
            nextImg.scale = 1
        }

        Image {
            id: nextImg
            source: "qrc:/App/Radio/Data/Next_n.png"
            anchors.fill: parent
            scale: 1
        }
        onPressed: {
            nextImg.source = "qrc:/App/Radio/Data/Next_p.png"
            nextImg.scale = 0.9
        }
        onReleased: {
            nextImg.source = "qrc:/App/Radio/Data/Next_n.png"
            nextImg.scale = 1
            view.decrementCurrentIndex()
        }
    }

    // Play / Pause
    // Khi play sẽ hiển thị nút pause
    // khi dừng thì sẽ hiển thị nút play
    // Khởi tạo state ban đầu là false: nút play sẽ hiển thị


    // Trả lại true nếu mouse nằm trong hình ảnh (phần hiển thị, không phải Rectangle)
    // False nếu mouse nằm ngoài
    // Mục đích: tránh bị chồng nhau ở đường viền chéo
    /* FIXME: chưa làm được?
    property bool m_btnPlay: {
            var x1 = width / 2;
            var y1 = height / 2;
            var x2 = mouseX;
            var y2 = mouseY;
            var distanceFromCenter = Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2);
            var radiusSquared = Math.pow(Math.min(width, height) / 2, 2);
            var isWithinOurRadius = distanceFromCenter < radiusSquared;
            return isWithinOurRadius;
        }
 */


    //======================================================
    property bool isPlay: false
    MouseArea {
        id: btnPlay
        width: 474 *appScale
        height: 415 *appScale

        anchors.verticalCenter: radio_bg.verticalCenter
        anchors.left: radio_bg.left

        KeyNavigation.down: btnPre
        KeyNavigation.right: btnRescan

        Keys.onPressed: {
            if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                playImg.scale = 0.9
            }
        }
        Keys.onReleased: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                playImg.scale = 1
                isPlay = !isPlay
                isPlay ? radio.play() : radio.pause()
            }
        }        

        Image {
            id: playImg
            source: isPlay === false ? "qrc:/App/Radio/Data/Play_n.png" : "qrc:/App/Radio/Data/Pause_n.png"
            anchors.fill: parent
            scale: 1
        }
        onPressed: {
            playImg.scale = 0.9
        }
        onReleased: {
            playImg.scale = 1
            isPlay = !isPlay
            isPlay ? radio.play() : radio.pause()
        }
    }

    // Pre
    MouseArea {
        id: btnPre
        width: 620 *appScale
        height: 340 *appScale
        anchors.bottom: radio_bg.bottom
        anchors.left: radio_bg.left

        KeyNavigation.right: btnVolDown
        KeyNavigation.down: btnNext

        Keys.onPressed: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                preImg.scale = 0.9
                preImg.source = "qrc:/App/Radio/Data/Prev_p.png"
            }
        }
        Keys.onReleased: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                preImg.scale = 1
                preImg.source = "qrc:/App/Radio/Data/Prev_n.png"
                view.incrementCurrentIndex()
            }
        }

        Image {
            id: preImg
            source: "qrc:/App/Radio/Data/Prev_n.png"
            anchors.fill: parent
            scale: 1
        }
        onPressed: {
            preImg.scale = 0.9
            preImg.source = "qrc:/App/Radio/Data/Prev_p.png"
        }
        onReleased: {
            preImg.scale = 1
            preImg.source = "qrc:/App/Radio/Data/Prev_n.png"
            view.incrementCurrentIndex()
        }
    }


    // Vol up
    MouseArea {
        id: btnVolUp
        width: 620 *appScale
        height: 340 *appScale
        anchors.top: headerItem.bottom
        anchors.right:  radio_bg.right

//        KeyNavigation.left: btnNext
        KeyNavigation.down: btnRescan

        Keys.onPressed: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                btnVolUp.scale = 0.9
                if(radio.volume < 1) radio.volume += 0.2
                else radio.volume = 1.0
                popVolume.open()
                radioListArea.opacity = 0.25
                timerVolume.restart()
            }
        }
        Keys.onReleased: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                btnVolUp.scale = 1
            }
        }

        Image {
            id: volUpImg
            source: "qrc:/App/Radio/Data/VolUp_n.png"
            anchors.fill: parent
            scale: 1
        }
        onPressed: {
            btnVolUp.scale = 0.9
            if(radio.volume < 1) radio.volume += 0.2
            else radio.volume = 1.0

            popVolume.open()
            radioListArea.opacity = 0.25
            timerVolume.restart()
        }
        onReleased: {
            btnVolUp.scale = 1
        }
    }

    // Scan channel
    MouseArea {
        id: btnRescan
        width: 474 *appScale
        height: 415 *appScale
        anchors.verticalCenter: radio_bg.verticalCenter
        anchors.right:  radio_bg.right

//        KeyNavigation.up: btnVolUp
        KeyNavigation.down: btnVolDown
        KeyNavigation.left: btnPlay

        Keys.onPressed: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                reScanImg.scale = 0.9
                console.log("No new channel found")
                radioListArea.opacity = 0.25
                popNotification.open()
                timeNotify.restart()
            }
        }
        Keys.onReleased: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                reScanImg.scale = 1
            }
        }

        Image {
            id: reScanImg
            source: "qrc:/App/Radio/Data/Rescan_n.png"
            anchors.fill: parent
            scale: 1
        }
        onPressed: {
            reScanImg.scale = 0.9
            console.log("No new channel found")
            radioListArea.opacity = 0.25
            popNotification.open()
            timeNotify.restart()
        }
        onReleased: {
            reScanImg.scale = 1            
        }
    }

    Popup {
        id: popNotification
        anchors.centerIn: parent
        width: 850*appScale
        height: 100*appScale        
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        Text {
            id: popNotificationtxt
            anchors.centerIn: parent
            text: "<b>No new channel found</b>"
            font.pixelSize: 72 *appScale
            color: "red"
        }
    }

    //FIXME: Khi 2 timer chạy liên tiếp: 1 trong 2 timer kết thúc,
    // opacity = 1, trong khi Popup còn lại vẫn đang show => lỗi hiển thị
    Timer{
        id: timeNotify
        running: true
        repeat: false
        interval: 1000
        onTriggered: {
            popNotification.close()
            radioListArea.opacity = 1
        }
    }

    // Vol down
    MouseArea {
        id: btnVolDown
        width: 620 *appScale
        height: 340 *appScale
        anchors.bottom: radio_bg.bottom
        anchors.right:  radio_bg.right

        KeyNavigation.up: btnRescan
        KeyNavigation.left: btnPre

        Keys.onPressed: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                volDownImg.scale = 0.9
                if(radio.volume > 0) radio.volume -= 0.2
                else radio.volume = 0.0
                popVolume.open()
                radioListArea.opacity = 0.25
                timerVolume.restart()
            }
        }
        Keys.onReleased: {
            if((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                volDownImg.scale = 1
            }
        }

        Image {
            id: volDownImg
            source: "qrc:/App/Radio/Data/VolDown_n.png"
            anchors.fill: parent
            scale: 1
        }
        onPressed: {
            volDownImg.scale = 0.9
            if(radio.volume > 0) radio.volume -= 0.2
            else radio.volume = 0.0

            popVolume.open()
            radioListArea.opacity = 0.25
            timerVolume.restart()
        }
        onReleased: {
            volDownImg.scale = 1
        }
    }

    Popup {
        id: popVolume
        anchors.centerIn: parent
        width: img_volume.width
        height: img_volume.height

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Image {
            id: img_volume
            source: vol_level()
            width: 256 *appScale
            height: 256 *appScale
        }
    }
    Timer{
        id: timerVolume
        running: true
        repeat: false
        interval: 1500
        onTriggered: {
            popVolume.close()
            radioListArea.opacity = 1
        }
    }


    // Trả về hình ảnh tương ứng với mức volume hiện tại
    // Có 5 mức tương ứng 5 image
    property string vol_img_path: "qrc:/App/Radio/Data/Speak_"
    function vol_level() {
        if(radio.volume == 1.0)
            return vol_img_path + "5.png"
        else if(radio.volume < 1.0 && radio.volume >= 0.8)
            return vol_img_path + "4.png"
        else if(radio.volume < 0.8 && radio.volume >= 0.6)
            return vol_img_path + "3.png"
        else if(radio.volume < 0.6 && radio.volume >= 0.4)
            return vol_img_path + "2.png"
        else return vol_img_path + "1.png"
    }

    KeyNavigation.up: btnPre
    KeyNavigation.down: btnNext
    KeyNavigation.left: btnPlay
    KeyNavigation.right: btnPlay

    Component.onCompleted: {
        btnNext.forceActiveFocus()
        radio.volume = 0.6  // Khởi tạo volume 0.6/1.0
        player.stop()
    }

    Component.onDestruction:  {
        console.log("exit radio....")
    }
}
