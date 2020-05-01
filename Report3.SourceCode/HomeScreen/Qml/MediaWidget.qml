import QtQuick 2.0
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    implicitWidth: 635 *scaleRatio
    implicitHeight: 570 *scaleRatio
    Rectangle {
        anchors{
            fill: parent
            margins: 10 *scaleRatio
        }
        opacity: 0.7
        color: "#111419"
    }
    Image {
        id: bgBlur
        x:10 *scaleRatio
        y:10 *scaleRatio
        width: 615 *scaleRatio
        height: 550 *scaleRatio
        source: {
            if (myRowCount > 0 && myRowCount >  playlistCurrentIndex)
                return myModel.data(myModel.index(playlistCurrentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Image {
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40 *scaleRatio
        text: "USB Music"
        color: "white"
        font.pixelSize: 34 *scaleRatio
    }
    Image {
        id: bgInner
        x:201 *scaleRatio
        y:119 *scaleRatio
        width: 258 *scaleRatio
        height: 258 *scaleRatio
        source: {
            if (myRowCount > 0 && myRowCount >  playlistCurrentIndex)
                return myModel.data(myModel.index(playlistCurrentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        x:201 *scaleRatio
        y:119 *scaleRatio
        width: 258 *scaleRatio
        height: 258 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        x: 42 *scaleRatio
        y: (56+343) *scaleRatio
        width: 551 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myRowCount > 0 && myRowCount >  playlistCurrentIndex)
                return myModel.data(myModel.index(playlistCurrentIndex,0), 258)
        }
        color: "white"
        font.pixelSize: 30 *scaleRatio
    }
    Text {
        id: txtTitle
        x: 42 *scaleRatio
        y: (56+343+55) *scaleRatio
        width: 551 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myRowCount > 0 && myRowCount >  playlistCurrentIndex)
                return myModel.data(myModel.index(playlistCurrentIndex,0), 257)
        }
        color: "white"
        font.pixelSize: 48 *scaleRatio
    }
    Image{
        id: imgDuration
        x: 62 *scaleRatio
        y: (56+343+55+62) *scaleRatio
        width: 511 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }
    Image{
        id: imgPosition
        x: 62 *scaleRatio
        y: (56+343+55+62) *scaleRatio
        width: 0 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        },
        State {
            name: "Drag"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
                scale: 1.1
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        root.focus = true
        root.state = "Normal"
    }
    onFocusChanged: {
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }

    Connections{
        target: playlist
        onCurrentIndexChanged:{
            if (myModel.rowCount() > 0 && myModel.rowCount() >  playlist.currentIndex) {
                bgBlur.source = myModel.data(myModel.index(playlist.currentIndex,0), 260)
                bgInner.source = myModel.data(myModel.index(playlist.currentIndex,0), 260)
                txtSinger.text = myModel.data(myModel.index(playlist.currentIndex,0), 258)
                txtTitle.text = myModel.data(myModel.index(playlist.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 511  *scaleRatio
        }
        onPositionChanged: {
            imgPosition.width = (player.position / player.duration)*(511)  *scaleRatio;
        }
    }
}
