import QtQuick 2.12
import QtQml.Models 2.1
import QtQuick.Controls 2.4

ListView {
    id: appListMenu    
    orientation: ListView.Horizontal
    interactive: true
    spacing: 5  *scaleRatio
    clip: true
    highlightMoveDuration: 100
    width: 1920 *scaleRatio
    height: 526 *scaleRatio

    snapMode: ListView.SnapOneItem  // ListView.SnapToItem
    // Cần enable key Navigation, nếu giá trị false, không thể Navigation
    keyNavigationEnabled: true

    // Hiệu ứng đổi chỗ item
    move: Transition {
        NumberAnimation { properties: "x,y"; duration: 200 }
    }
    moveDisplaced: Transition {
        NumberAnimation{ properties: "x,y"; duration: 200 }
    }

    function saveData () {
        xmlwriter.clearData()
        for (var index = 0; index < visualModel.items.count;index++){
            xmlwriter.setData(index +1, visualModel.items.get(index).model.title, visualModel.items.get(index).model.url, visualModel.items.get(index).model.iconPath)
        }
        xmlwriter.appendApp()
        xmlwriter.writeToFile("applications.xml")
    }

    model: DelegateModel {
        id: visualModel
        model: appsModel
        delegate: DropArea {
            id: delegateRoot
            width: 316 *scaleRatio
            height: 526 *scaleRatio
            keys: "AppButton"

            onEntered: {
                visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                saveData()
            }

            property int visualIndex: DelegateModel.itemsIndex
            Binding { target: icon; property: "visualIndex"; value: visualIndex }

            // Sau khi drag/drop thì trả lại focus về appListMenu
            // Nếu không thì sẽ không thể nhấn hardkey            
            onExited: {
                appListMenu.focus = true
            }

            onActiveFocusChanged:  {
                app.focus = true
                app.state = "Focus"
            }

            Keys.onPressed: {
                if (event.key === Qt.Key_Up || event.key === Qt.Key_Down) {
                    widgetArea.forceActiveFocus()
                    focusPosition = "Widget"
                    app.state = "Normal"
                }

                // Xử lý mở app khi nhấn Enter
                if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    homeScreen.openApplication(model.url)
                    console.log("Open " + app.title)
                }

                // ---------------------- Hardkeys Reorder ------------------------------
                // Nhấn giữ Shift + Left/Right để sắp xếp application list
                if((event.modifiers & Qt.ShiftModifier) && (event.key === Qt.Key_Left)) {
                    console.log("Shift + move to left" )
                    visualModel.items.move(visualIndex,visualIndex -1,1)
                    event.accepted = true
                    saveData()
                }
                if((event.modifiers & Qt.ShiftModifier) && (event.key === Qt.Key_Right)) {
                    console.log("Shift + move to right" )
                    visualModel.items.move(visualIndex,visualIndex +1,1)
                    event.accepted = true
                    saveData()
                }
            }

            Keys.onReleased: {
                app.focus = true
                app.state = "Focus"
                console.log("Select app: " + app.title)

                for (var index = 0; index < visualModel.items.count;index++){
                    if (index !== icon.visualIndex) {
                        visualModel.items.get(index).focus = false
                    }
                    else {
                        visualModel.items.get(index).focus = true
                    }
                }
            }

            Item {
                id: icon
                property int visualIndex: 0
                width: 316 *scaleRatio
                height: 526 *scaleRatio
                anchors {
                    horizontalCenter: parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter
                }

                AppButton{
                    id: app
                    title: model.title
                    icon: model.iconPath

                    // Sử dụng cho drag.target
                    property bool turnOnDrag: false

                    // Không thể đặt trực tiếp target = icon, sẽ không thể flick được list.
                    drag.target: turnOnDrag ? icon : undefined
                    drag.axis: Drag.XAxis   // Chỉ cho phép drag theo chiều ngang theo App list
                    drag.smoothed: false

                    onClicked: homeScreen.openApplication(model.url)

                    // Press & hold (800ms) thì phóng to icon
                    onPressAndHold:  {
                        app.focus = true
                        //app.state = "Drag"
                        turnOnDrag = true
                        app.scale = 1.2
                    }
                    onReleased: {
                        turnOnDrag = false
                        app.scale = 1
                    }

                    // Chuyển focus vào button được click, bỏ focus ở các button khác
                    onPressed:  {
                        app.focus = true
                        app.state = "Focus"
                        for (var index = 0; index < visualModel.items.count;index++){
                            if (index !== icon.visualIndex) {
                                visualModel.items.get(index).focus = false
                            }
                            else {
                                visualModel.items.get(index).focus = true
                                appListMenu.currentIndex = index
                            }
                        }                        
                    }
                }

                Drag.active: app.turnOnDrag        // cho phép drag khi press & hold
                Drag.source: icon
                Drag.keys: "AppButton"
                Drag.hotSpot.x: delegateRoot.width*2/3
                Drag.hotSpot.y: delegateRoot.height*2/3

                states: [
                    State {
                        when:  app.turnOnDrag
                        ParentChange {
                            target: icon
                            parent: appListMenu
                        }
                        AnchorChanges {
                            target: icon
                            anchors.horizontalCenter: undefined
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
            }
        }        
    }

    ScrollBar.horizontal:  ScrollBar {
        id: scrollview
        parent: appListMenu.parent
        anchors.bottom: appListMenu.bottom
        anchors.left: appListMenu.left
        anchors.right: appListMenu.right
        visible: visualModel.items.count > 6 ? true : false
    }
}
