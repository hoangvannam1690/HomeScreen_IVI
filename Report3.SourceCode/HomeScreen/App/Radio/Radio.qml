import QtQuick 2.11
import QtQuick.Controls 2.4
import QtMultimedia 5.9
import "./../Common/"

Item {
    id: root
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: screenHeight - 104*appScale  // screenHeight - statusBar.height

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
        ListElement { name: "XONE FM"; url: "http://node-29.zeno.fm/v51ym0g96qruv"}
        ListElement { name: "JOY FM"; url: "http://cdn.mediatech.vn/hntvRadio/joyfm.stream_aac/playlist.m3u8"}

        ListElement { name: "Bình Dương 92.5"; url: "https://hplusliveall.e96bbe18.sabai.vn/570448cae6e420d5057ba249a3d1b6c31588823059/btvfm92.audio.sbd.tms/chunklist.m3u8"}
//        ListElement { name: ""; url: ""}

    }

    Audio {
        id: radio
        source: "https://5a6872aace0ce.streamlock.net/nghevovgthcm/vovgthcm.stream_aac/playlist.m3u8" //VOV Giao Thông HCM
    }

    // Ảnh động, hiển thị animate khi phát radio và dừng khi stop radio
    // TODO: Cần xây dựng lại giao diện
    AnimatedImage {
        id: animationRadio
        scale: 0.6 * appScale
        anchors.centerIn: parent
        source: "qrc:/App/Radio/Data/Radio.gif"
        playing: false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            player.pause()
            animationRadio.playing = radio.playbackState !== MediaPlayer.PlayingState ? true : false
            radio.playbackState === MediaPlayer.PlayingState ? radio.stop() : radio.play()
        }
    }

    // Xử lý hardkey
    Keys.onPressed: {        
        if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            player.pause()
            animationRadio.playing = radio.playbackState !== MediaPlayer.PlayingState ? true : false
            radio.playbackState === MediaPlayer.PlayingState ? radio.stop() : radio.play()
            console.log("Play/Stop radio.")
        }
    }

    Component.onDestruction:  {
        console.log("exit radio....")
    }
}
