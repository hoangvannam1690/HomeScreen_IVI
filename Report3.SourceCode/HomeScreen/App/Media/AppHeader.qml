import QtQuick 2.0

Item {
    property alias playlistButtonStatus: playlist_button.status
    signal clickPlaylistButton
    Image {
        id: headerItem
        anchors.fill: parent
        source: "qrc:/App/Media/Image/title.png"
        SwitchButton {
            id: playlist_button
            anchors.left: parent.left
            anchors.leftMargin: 20 *appScale
            anchors.verticalCenter: parent.verticalCenter
            icon_off: "qrc:/App/Media/Image/drawer.png"
            icon_on: "qrc:/App/Media/Image/back.png"
            onClicked: {
                clickPlaylistButton()
            }
        }
        Text {
            anchors.left: playlist_button.right
            anchors.leftMargin: 5 *appScale
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Playlist")
            color: "white"
            font.pixelSize: 32 *appScale
        }

        Text {
            id: headerTitleText
            text: qsTr("Media Player")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46 *appScale
        }
    }
}
