import QtQuick 2.6
import QtQuick.Controls 2.4
import "./../../Qml"

Item {
    id: root

    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: screenHeight - (104 * appScale)  //screenHeight - (70 * appScale)
//    height: 1200-104

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
        height: 141 *appScale

        playlistButtonStatus: playlist_bt.opened ? 1 : 0
        onClickPlaylistButton: {
            if (!playlist_bt.opened) {
                playlist_bt.open()
            } else {
                playlist_bt.close()
            }
        }
    }

    //Playlist
    PlaylistView{
        id: playlist_bt       
        y: headerItem.height + 104*appScale    //141 + 104
        width: 675  *appScale
        height: parent.height-headerItem.height
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: playlist_bt.position*playlist_bt.width    //FIXME: chỗ này tác dụng gì??
        anchors.bottom: parent.bottom

        width: root.width - playlist_bt.width
        height: root.height - headerItem.height
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
}
