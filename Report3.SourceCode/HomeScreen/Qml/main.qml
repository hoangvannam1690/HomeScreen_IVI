/*          Keyboard define
    - Nhấn Enter để mở app tương ứng
    - Nhấn Backspace để quay về Home
    - Nhấn Shift + Left/Right để đổi chỗ ứng dụng
*/
import QtQuick 2.11
import QtQuick.Window 2.0
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    // Screen standar: 1920x1200 => 1152x720 => 1024x640 => 768x480 W/H = 1.6  0.625
    // Default screen: 1920x1200
    // get screen size
//    property var screenWidth : Screen.width  >= 1920 ? 1920 : 1152
//    property var csreenHeight: Screen.height >= 1200 ? 1200 : 720
//    property var scaleRatio: Screen.height >= 1200 ? 1 : 0.6

    //-------------------------------------------------------------
    property var screenWidth : getWidth()
    property var csreenHeight: getHeight()
    property var scaleRatio: getScale()
    function getWidth() {
        if(Screen.width  >= 1920) return 1920
        else if(Screen.width  >= 1366) return 1152
        else return 720
    }
    function getHeight() {
        if(getWidth() === 1920) return 1200
        else if(getWidth() === 1152) return 720
        else return 480
    }
    function getScale() {
        if(getWidth() === 1920) return 1
        else if(getWidth() === 1152) return 0.6
        else return 0.375
    }

    // signal
    signal sendSignalScale(var msg)
    //-------------------------------------------------------------


    width: screenWidth; height: csreenHeight

    // Không cho kéo thay đổi kích thước
    minimumWidth: getWidth()
    minimumHeight: getHeight()
    maximumWidth: minimumWidth +1
    maximumHeight: minimumHeight+1

    Component.onCompleted: {
        screenSize.setScreenSize(window.width, window.height, scaleRatio)
        console.log("width: " + window.width + "; height: " + window.height + "; Scale: " +scaleRatio)
    }

    onScreenChanged: {
        timer.restart()
    }

    Timer {
        id: timer
        running: true
        repeat: false
        interval: 150 //10
        onTriggered: {
            screenWidth = getWidth()
            csreenHeight= getHeight()
            scaleRatio  = getScale()

            window.width = getWidth()
            window.height = getHeight()
            console.log("width: " + window.width + "; height: " + window.height + "; Scale: " +scaleRatio)
            screenSize.setScreenSize(window.width, window.height, scaleRatio)

            sendSignalScale(scaleRatio)
        }
    }

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/Img/bg_full.png"
    }

    // Sử dụng thuộc tính này để quay lại vị trí focus trước khi mở app
    // "Widget": Widget area;     "AppMenu": Application menu area
    property string focusPosition: "AppMenu"

    // ----------------- Status Area ---------------------
    StatusBar {
        id: statusBar
        onBntBackClicked: {
            stackView.pop()
            if(focusPosition === "AppMenu") applicationMenu.forceActiveFocus()
            else widgetArea.forceActiveFocus()
        }
        isShowBackBtn: stackView.depth === 1 ? false : true
    }

    // Home Screen windows, bao gồm Widget area và Application menu area
    Item {
        id: homeScreen
        width: 1920 * scaleRatio
        height: 1096 * scaleRatio

        function openApplication(url){
            parent.push(url)
        }

        // ----------------- Widget Area ---------------------
        WidgetArea {
            id: widgetArea
            spacing: 10 *scaleRatio *scaleRatio
            orientation: ListView.Horizontal
            width: 1920  * scaleRatio
            height: 570  * scaleRatio
        }
        // ------------- Application men Area ----------------
        ApplicationMenu {
            id: applicationMenu
            y: 570  *scaleRatio
            focus: true
        }
    }

    // Hiệu ứng khi mở app và khi thoát app trở về home
    StackView {
        id: stackView
        width: 1920
        anchors.top: statusBar.bottom
        initialItem: homeScreen

        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 100
                easing.type: Easing.OutCubic
            }
        }
        popEnter : Transition {
            XAnimator {
                from: -1920
                to: 0
                duration: 100
                easing.type: Easing.InCubic
            }
        }
        //************************ Hardkey ********************************
        // Nhấn phím Backspace trên bàn phím
        Keys.onPressed: {
            if (event.key === Qt.Key_Backspace && stackView.depth !== 1) {
                console.log("back to home screen.............")
                stackView.pop()

                // Trả focus về vị trí trước khi mở ứng dụng
                if(focusPosition === "AppMenu") applicationMenu.forceActiveFocus()
                else widgetArea.forceActiveFocus()
            }
        }
        onFocusChanged:  applicationMenu.forceActiveFocus()
    }
}
