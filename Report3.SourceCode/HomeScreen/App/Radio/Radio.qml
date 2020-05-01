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
    height: screenHeight - (70 * appScale)

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

    Audio {
        id: radio
        source: "https://5a6872aace0ce.streamlock.net/nghevovgthcm/vovgthcm.stream_aac/playlist.m3u8" //VOV Giao Thông HCM
        //source: "https://5a6872aace0ce.streamlock.net/nghevovgthn/vovgthn.stream_aac/chunklist_w1165648695.m3u8" //VOV Giao Thông HN
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
