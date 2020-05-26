import QtQuick 2.6
import QtQuick.Controls 2.4
import "./../../Qml"

// sử dụng cho FileDialog
import Qt.labs.platform 1.1
import QtQuick.Dialogs 1.0

Item {
    id: root

    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: screenHeight - (104 * appScale)

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
        width: root.width
        height: 100 *appScale

        playlistButtonStatus: playlist_bt.opened ? 1 : 0
        onClickPlaylistButton: {
            if (!playlist_bt.opened) {
                playlist_bt.open()
            } else {
                playlist_bt.close()
            }
        }

        // Hiển thị icon Folder
        // Click để lựa chọn add folder music
        Image {
            id: addMusic
            source: "qrc:/App/Media/Image/Folder2.png"
            width: 85 *appScale
            height: width
            visible: mediaInfoControl.visible
            anchors.right: parent.right
            anchors.rightMargin: 35 *appScale

            MouseArea{
                anchors.fill: parent
                onClicked: openMediaFolder.open()
            }
        }
    }

    //Playlist
    PlaylistView{
        id: playlist_bt
        y: headerItem.height + 104*appScale
        width: 675  *appScale
        height: root.height - headerItem.height
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: playlist_bt.position*playlist_bt.width
        anchors.bottom: parent.bottom

        width: root.width - playlist_bt.width
        height: root.height - headerItem.height

        visible: musicCount
    }

    //------------------- Hardkey control ------------------------
    Keys.onPressed: {
        if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            if (!playlist_bt.opened) {
                playlist_bt.open()
                console.log("Show playlist ")
            } else {
                playlist_bt.close()
                console.log("Hide playlist ")
            }
        }
    }

    // Hiển thị khi list music empty
    Image {
        id: imgDialog
        visible: !mediaInfoControl.visible
        source: "qrc:/App/Media/Image/Folder.png"

        width: 256 *appScale
        height: width
        anchors.centerIn: parent

        Text {
            id: nameDialog
            anchors.top: imgDialog.bottom
            anchors.topMargin: 50 *appScale
            text: "Open music folder"
            font.pixelSize: 36*appScale
            color: "white"
        }

        MouseArea {
            anchors.fill: imgDialog
            onClicked: {
                openMediaFolder.open()
            }
        }
    }
    FolderDialog {
        id: openMediaFolder
        folder: StandardPaths.writableLocation(StandardPaths.MusicLocation)
        onAccepted: {
            utility.setMusicDir(folder)
        }
    }
}
