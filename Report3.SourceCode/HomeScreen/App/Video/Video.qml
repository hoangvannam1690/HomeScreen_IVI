import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

import QtMultimedia 5.9
import Qt.labs.platform 1.1
import QtQuick.Dialogs 1.0

import "./../Common/"

Item {
    id: root
    focus: true

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
        appName: "Video"
    }

    property string videoSource: "empty"
    Video {
        id: video
        implicitWidth: parent.width
        implicitHeight: parent.height - headerItem
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        fillMode: VideoOutput.Stretch
        source: videoSource
    }    

    FileDialog {
        id: myFile
        folder: StandardPaths.writableLocation(StandardPaths.MoviesLocation)
        selectMultiple: false
        selectFolder: false
        onAccepted:{
            console.log(this.fileUrl)
            videoSource = this.fileUrl
            video.play()
        }
    }

    Image {
        id: mImage
        source: "qrc:/App/Video/Data/Play_Button.png"
        width: 350 *appScale
        height: width
        anchors.centerIn: parent
        visible: video.playbackState !== MediaPlayer.PlayingState ? true : false  //true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            player.pause()
            if(videoSource == "empty") {
                myFile.open()
            }
            else {
                mImage.visible = video.playbackState == MediaPlayer.PlayingState ? true : false
                video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
                console.log(video.source)
            }
        }
    }

    Keys.onPressed: {
        if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            if(videoSource == "empty") {
                player.pause()
                myFile.open()
            }
            else {
                mImage.visible = video.playbackState == MediaPlayer.PlayingState ? true : false
                video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
                console.log(video.source)
            }
        }
    }
}
