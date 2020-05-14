import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.9

Item {
    property var songTitle: audioTitle.text
    property var musicCount: album_art_view.count
    width: parent.width
    height: parent.height

    property var stateList: false
    function getAudioTitle() {
        if(musicCount >0 && stateList === false) return album_art_view.currentItem.myData.title
        else return ""
    }
    function getAudioSinger() {
        if(musicCount >0 && stateList === false) return album_art_view.currentItem.myData.singer
        else return ""
    }

    Text {
        id: audioTitle
        anchors.top: parent.top
        anchors.topMargin: 20 *appScale
        anchors.left: parent.left
        anchors.leftMargin: 20 *appScale
        text: getAudioTitle()

        color: "white"
        font.pixelSize: 36 *appScale
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors.top: audioTitle.bottom
        anchors.left: audioTitle.left
        text: getAudioSinger()

        color: "white"
        font.pixelSize: 32 *appScale
    }

    NumberAnimation {
        id: textChangeAni
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
    Text {
        id: audioCount
        anchors.top: parent.top
        anchors.topMargin: 20 *appScale
        anchors.right: parent.right
        anchors.rightMargin: 20 *appScale
        text: musicCount
        color: "white"
        font.pixelSize: 36 *appScale
    }
    Image {
        anchors.top: parent.top
        anchors.topMargin: 23 *appScale
        anchors.right: audioCount.left
        anchors.rightMargin: 10 *appScale
        width: 38 *appScale
        height: width
        source: "qrc:/App/Media/Image/music.png"
    }

    Component {
        id: appDelegate
        Item {
            id:myItemmm
            property variant myData: model
            width: 450 *appScale
            height: width
            scale: PathView.iconScale           // FIXME: Có cảnh báo khi click bài hát không liền kề
            Image {
                id: myIcon
                anchors.fill: parent
                y: 20 *appScale
                anchors.horizontalCenter: parent.horizontalCenter
                source: album_art
            }
            MouseArea {
                anchors.fill: parent
                onClicked: album_art_view.currentIndex = index
            }
        }
    }

    // Khung chứa album art
    Rectangle {
        id: alBumArtArea

        width: parent.width
        height: root.height - headerItem.height - headerItem.height - 104 *appScale
        anchors.top: parent.top

        anchors.right: parent.right
        color: "transparent"     //"blue"
        opacity: 0.2
        z: -3
    }

    PathView {
        id: album_art_view
        anchors.fill: alBumArtArea

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: myModel
        delegate: appDelegate
        pathItemCount: 3
        interactive: true
        clip: true
        path: Path {
            startX: 0
            startY: alBumArtArea.height/2
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine {
                x: alBumArtArea.width/2
                y: alBumArtArea.height/2
            }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine {
                x: alBumArtArea.width
                y: alBumArtArea.height/2
            }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
        currentIndex: playlist.currentIndex
        onCurrentIndexChanged: {
            if (currentIndex !== playlist.currentIndex) {
                playlist.currentIndex = currentIndex
            }
        }
    }

    //Progress area
    // Sử dụng Progress làm mốc, các thông tin currentTime, totalTime sẽ anchors theo mốc này.
    Text {
        id: currentTime
        anchors.verticalCenter: progressBar.verticalCenter
        anchors.right: progressBar.left
        anchors.rightMargin: 20 *appScale
        text: utility.getTimeInfo(player.position)
        color: "white"
        font.pixelSize: 24 *appScale
    }

    Slider{
        id: progressBar
        width: (1491 - 675*playlist_bt.position )*appScale
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 230 *appScale
        anchors.horizontalCenter: parent.horizontalCenter
        from: 0
        to: player.duration
        value: player.position
        background: Rectangle {
            x: progressBar.leftPadding
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            implicitWidth: 200*appScale
            implicitHeight: 4*appScale
            width: progressBar.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: (progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width))
            y: (progressBar.topPadding + progressBar.availableHeight / 2 - height / 2)
            source: "qrc:/App/Media/Image/point.png"
            Image {
                anchors.centerIn: parent
                source: "qrc:/App/Media/Image/center_point.png"
            }
        }
        onMoved: {
            if (player.seekable){
                player.setPosition(Math.floor(position*player.duration))
            }
        }
    }
    Text {
        id: totalTime
        anchors.verticalCenter: progressBar.verticalCenter
        anchors.left: progressBar.right
        anchors.leftMargin: 20*appScale
        text: utility.getTimeInfo(player.duration)
        color: "white"
        font.pixelSize: 24*appScale
    }

    // Media control area
    // Toàn bộ button được căn theo khung này
    // Button Play là trung tâm: căn theo cả verticalCenter và horizontalCenter
    // Các button khác dựa vào tọa độ của Play
    Rectangle {
        id: ctrlArea
        anchors {
            top: progressBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        color: "transparent" //"orange"
        opacity: 0.2
    }

    SwitchButton {
        id: shuffer
        anchors.verticalCenter: play.verticalCenter
        anchors.right: progressBar.left

        // Sau khi Scale, Item hiển thị nhỏ hơn, nhưng vẫn chiếm vị trí kích thước gốc
        // Làm điều bên dưới để dịch chuyển Item 1 đoạn bằng với kích thước đã scale
        anchors.rightMargin: (repeater.width *appScale - repeater.width)/2
        icon_off: "qrc:/App/Media/Image/shuffle.png"
        icon_on: "qrc:/App/Media/Image/shuffle-1.png"
        status: playlist.playbackMode === Playlist.Random ? 1 : 0
        onClicked: {
            if (playlist.playbackMode === Playlist.Random) {
                playlist.playbackMode = Playlist.Sequential
            } else {
                playlist.playbackMode = Playlist.Random
            }
        }
    }    
    ButtonControl {
        id: prev
        anchors.verticalCenter: play.verticalCenter
        anchors.right: play.left
        icon_default: "qrc:/App/Media/Image/prev.png"
        icon_pressed: "qrc:/App/Media/Image/hold-prev.png"
        icon_released: "qrc:/App/Media/Image/prev.png"
        onClicked: {
            player.playlist.previous()
        }
    }
    ButtonControl {
        id: play
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: ctrlArea.verticalCenter

        icon_default: player.state == MediaPlayer.PlayingState ?  "qrc:/App/Media/Image/pause.png" : "qrc:/App/Media/Image/play.png"
        icon_pressed: player.state == MediaPlayer.PlayingState ?  "qrc:/App/Media/Image/hold-pause.png" : "qrc:/App/Media/Image/hold-play.png"
        icon_released: player.state== MediaPlayer.PlayingState ?  "qrc:/App/Media/Image/pause.png" : "qrc:/App/Media/Image/play.png"
        onClicked: {
            if (player.state != MediaPlayer.PlayingState){
                player.play()
            } else {
                player.pause()
            }
        }
        Connections {
            target: player
            onStateChanged:{
                play.source = player.state == MediaPlayer.PlayingState ?  "qrc:/App/Media/Image/pause.png" : "qrc:/App/Media/Image/play.png"
            }
        }
    }
    ButtonControl {
        id: next
        anchors.verticalCenter: play.verticalCenter
        anchors.left: play.right
        icon_default: "qrc:/App/Media/Image/next.png"
        icon_pressed: "qrc:/App/Media/Image/hold-next.png"
        icon_released: "qrc:/App/Media/Image/next.png"
        onClicked: {
            player.playlist.next()
        }
    }
    SwitchButton {
        id: repeater
        anchors.verticalCenter: play.verticalCenter
        anchors.left: progressBar.right
        anchors.leftMargin: (repeater.width *appScale - repeater.width)/2
        icon_on: "qrc:/App/Media/Image/repeat1_hold.png"
        icon_off: "qrc:/App/Media/Image/repeat.png"
        status: playlist.playbackMode === Playlist.Loop ? 1 : 0
        onClicked: {
            console.log(player.playlist.playbackMode)
            if (player.playlist.playbackMode === Playlist.Loop) {
                player.playlist.playbackMode = Playlist.Sequential
            } else {
                player.playlist.playbackMode = Playlist.Loop
            }
        }
    }

    Connections{
        target: playlist
        onCurrentIndexChanged: {
            album_art_view.currentIndex = index;
        }
    }

    Connections{
        target: utility
        onAddMediaChanged: {
//            stateList = utility.stateAddList()  //stateList
            stateList = utility.state
        }
    }
}

