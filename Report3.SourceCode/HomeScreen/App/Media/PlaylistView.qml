import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.9

Drawer {
    id: drawer
    property alias mediaPlaylist: mediaPlaylist
    interactive: false
    modal: false
    background: Rectangle {
        id: playList_bg
        anchors.fill: parent
        color: "transparent"
    }        

    ListView {
        id: mediaPlaylist
        anchors.fill: parent
        model: myModel
        clip: true
        spacing: 2 *appScale
        snapMode: ListView.SnapPosition

        focus: true
        highlightMoveDuration: 100

        currentIndex: playlist.currentIndex  //playlistCurrentIndex
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: 675*appScale
                height: 120*appScale
                source: "qrc:/App/Media/Image/playlist.png"
                opacity: 0.5
            }
            Text {
                text: title
                anchors.fill: parent
                anchors.leftMargin: 70 *appScale
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.pixelSize: 32 *appScale
            }

            // --------------------- hardkey control ------------------------
            // Sử dụng phím Up/Down để chọn bài hát
            Keys.onReleased: {
                if(event.key === Qt.Key_Down || event.key === Qt.Key_Up) {
                    // console.log("Select song")
                }

                // Nhấn Enter để Play/Pause
                if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    if(player.playlist.currentIndex !== index) {
                        player.playlist.currentIndex = index
                         player.play()
                        console.log("Play song: " + mediaInfoControl.songTitle)
                    }
                    else {
                        if (player.state !== MediaPlayer.PlayingState){
                            player.play()
                        } else {
                            player.pause()
                        }
                    }

                }

                // Nếu playlist đang mở, nhấn backspace để ẩn
                if(event.key === Qt.Key_Backspace && playlist_bt.opened) {
                    playlist_bt.close()
                }
            }

            // --------------------- Mouse control ------------------------
            onClicked: {
//                player.playlist.currentIndex = index
            }
            onPressed: {
//                playlistItem.source = "qrc:/App/Media/Image/hold.png"
                player.playlist.currentIndex = index
            }
            onReleased: {
//                playlistItem.source = "qrc:/App/Media/Image/playlist.png"
            }
        }

        highlight: Image {
            id: imgHighlight
            source: "qrc:/App/Media/Image/playlist_item.png"
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 15 *appScale
                width: 38 *appScale
                height: 33 *appScale
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/App/Media/Image/playing.png"
            }
        }

        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylist.parent
            anchors.top: mediaPlaylist.top
            anchors.left: mediaPlaylist.right
            anchors.bottom: mediaPlaylist.bottom
        }
    }

    Connections{
        target: playlist     //player.playlist
        onCurrentIndexChanged: {
            mediaPlaylist.currentIndex = index;

        }
    }
}
