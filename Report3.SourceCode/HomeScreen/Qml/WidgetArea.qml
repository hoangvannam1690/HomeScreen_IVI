import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

ListView {
    id: lvWidget
    implicitWidth: 1920 * scaleRatio
    implicitHeight: 570 * scaleRatio
    interactive: false
    focus: true

    displaced: Transition {
        NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
    }

    keyNavigationEnabled: true    

    model: DelegateModel {
        id: visualModelWidget
        model: ListModel {
            id: widgetModel
            ListElement { type: "map"; url: "qrc:/App/Map/Map.qml" }
            ListElement { type: "climate"; url: "qrc:/App/Climate/Climate.qml" }
            ListElement { type: "media"; url: "qrc:/App/Media/Media.qml" }
        }       

        delegate: DropArea {
            id: delegateRootWidget
            width: 635 * scaleRatio
            height: 570 * scaleRatio
            keys: ["widget"]                       
            onEntered: {
                visualModelWidget.items.move(drag.source.visualIndex, iconWidget.visualIndex)
                iconWidget.item.enabled = false
            }
            property int visualIndex: DelegateModel.itemsIndex
            Binding { target: iconWidget; property: "visualIndex"; value: visualIndex }
            onExited: iconWidget.item.enabled = true
            onDropped: {
                console.log(drop.source.visualIndex)
            }            

            // -------------------- Xử lý KeyNavigation widget ---------------------------
            // Nhấn Left/Right để lựa chọn focus widget
            // Nhấn Enter để mở widget tương ứng
            Keys.onPressed: {
                // console.log("Nhấn: bỏ focus trước đó" )
                if(event.key === Qt.Key_Left || event.key === Qt.Key_Right || lvWidget.focus == true) {
                    iconWidget.item.focus = false
                }
                if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    console.log("Enter, open widget: " + model.type)
                    if(model.type === "map") {
                        homeScreen.openApplication("qrc:/App/Map/Map.qml")
                    }
                    if(model.type === "climate") {
                        homeScreen.openApplication("qrc:/App/Climate/Climate.qml")
                    }
                    if(model.type === "media"){
                        homeScreen.openApplication("qrc:/App/Media/Media.qml")
                    }
                }

                //Chuyển focus đến Application menu
                if(event.key === Qt.Key_Up ||event.key === Qt.Key_Down) {
                    applicationMenu.forceActiveFocus()
                    focusPosition = "AppMenu"
                }

                // Reorder hardkey: Nhấn giữ Shift + Left/Right để sắp xếp widget
                if((event.modifiers & Qt.ShiftModifier) && (event.key === Qt.Key_Left) && visualIndex > 0) {
                    console.log("Shift + move to left" )
                    widgetModel.move(visualIndex,visualIndex -1,1)
                    event.accepted = true
                }
                if((event.modifiers & Qt.ShiftModifier) && (event.key === Qt.Key_Right) && visualIndex < lvWidget.count-1) {
                    console.log("Shift + move to right" )
                    widgetModel.move(visualIndex,visualIndex +1,1)
                    event.accepted = true
                }
            }

            Keys.onReleased: {
                //  console.log("Nhả phím: focus button mới" )
                iconWidget.item.focus = true
                console.log("Select Widget: " + model.type)
            }

            //=====================================================
            Loader {
                id: iconWidget
                property int visualIndex: 0
                width: 635 * scaleRatio
                height: 570 * scaleRatio

                anchors {
                    horizontalCenter: parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter
                }

                sourceComponent: {
                    switch(model.type) {
                    case "map": return mapWidget
                    case "climate": return climateWidget
                    case "media": return mediaWidget
                    }
                }

                Drag.active: iconWidget.item.state === "Drag"
                Drag.keys: "widget"
                Drag.source: iconWidget

                Drag.hotSpot.x: delegateRootWidget.width*2/3
                Drag.hotSpot.y: delegateRootWidget.height*2/3

                states: [
                    State {
                        when: iconWidget.Drag.active
                        ParentChange {
                            target: iconWidget
                            parent: lvWidget
                        }
                        AnchorChanges {
                            target: iconWidget
                            anchors.horizontalCenter: undefined
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
            }
        }        
    }

//    function mFocus() {
//        if(MapWidget.activeFocus){
//            console.log("map focus")
//        }
//        if(climateWidget.activeFocus){
//            console.log("climate focus")
//        }
//        if(mediaWidget.activeFocus){
//            console.log("media focus")
//        }
//    }

    Component {
        id: mapWidget
        MapWidget{
            onClicked: homeScreen.openApplication("qrc:/App/Map/Map.qml")
            drag.target: parent
            drag.axis: Drag.XAxis
            onPressAndHold: {
                state = "Drag"
            }
        }
    }
    Component {
        id: climateWidget
        ClimateWidget {
            onClicked: homeScreen.openApplication("qrc:/App/Climate/Climate.qml")
            drag.target: parent
            drag.axis: Drag.XAxis
            onPressAndHold: state = "Drag"
        }
    }
    Component {
        id: mediaWidget
        MediaWidget{
            onClicked: homeScreen.openApplication("qrc:/App/Media/Media.qml")
            drag.target: parent
            drag.axis: Drag.XAxis
            onPressAndHold: state = "Drag"
        }
    }
}


