import QtQuick 2.11
import QtQuick.Extras 1.4
//import QtQuick.Controls 2.2
//import Qt.labs.platform 1.1
import QtQuick.Controls 1.4
import "./../Common/"

Item {
    id: root
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    property string area_select: "driverArea"

    width: screenWidth
    height: screenHeight - 104*appScale  // screenHeight - statusBar.height

    //Header
    AppHeader{
        id: headerItem
        appName: "Climate"
    }

    Rectangle {
        id: climateDisplay
        width: parent.width
        height: parent.height - headerItem.height /*- (200 * appScale)*/
        anchors.top: headerItem.bottom
        color: "transparent"

        Image {
            id: glass_
            source: "qrc:/App/Climate/Image/ico_asd_l.png"
            width: 192 *appScale
            height: width
            anchors.top: parent.top
        }

        Image {
            id: air_co2
            source: "qrc:/App/Climate/Image/ico_air_co2.png"
            width: 224 *appScale
            height: 110 *appScale
            anchors.top: parent.top
            anchors.right: parent.right
        }


        // Driver area, hiển thị thông tin driver
        // Điều khiển gió, nhiệt độ cho driver
        Item {
            id: driverArea
            width: parent.width/2
            height: parent.height
            anchors.left: parent.left

            property string img_face: "qrc:/App/Climate/Image/Climate_02_gr.png"
            property string img_foot: "qrc:/App/Climate/Image/Climate_03_gr.png"
            property string img_heater_: ""
            property bool heaterOn: false

            Rectangle {
                id: driver_label
                width: 400 *appScale
                height: 100*appScale
                anchors.horizontalCenter: parent.horizontalCenter
                y: 120 *appScale
                color: "transparent"     // "orange"
                // opacity: 0.3

                Text {
                    text: qsTr("<b>Driver</b>")
                    font.pixelSize: 48 *appScale
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            WindDirection {
                id: driver_origin
                anchors.centerIn: parent
                scale: 1.1    //1.5
                allow_scale: false
                set_transform: true

                img_face_wind: parent.img_face
                img_foot_wind: parent.img_foot
                img_heater: parent.img_heater_
                heater_on: parent.heaterOn

                onClicked: {
                    area_select = "driverArea"
                    wind_select.setTransform = true
                    wind_select.visible = !wind_select.visible
                }
            }
        }

        Text {
            id: driver_temp
            text: "22°C"
            x: 260
            y: 212
            font.pixelSize: 30
            color: "orange"
        }

        Text {
            id: passeger_temp
            text: "18°C"
            x: 832
            y: 212
            font.pixelSize: 28
            color: "orange"
        }


        // Passenger area, hiển thị thông tin Passenger
        // Điều khiển gió, nhiệt độ cho Passenger
        Item {
            id: passengerArea
            width: parent.width/2
            height: parent.height

            anchors.left: driverArea.right
            property string img_face: "qrc:/App/Climate/Image/Climate_02_gr.png"
            property string img_foot: "qrc:/App/Climate/Image/Climate_03_gr.png"
            property string img_heater_: ""
            property bool heaterOn: false

            Rectangle {
                id: passenger_label
                width: 400 *appScale
                height: 100*appScale
                anchors.horizontalCenter: parent.horizontalCenter
                y: 120 *appScale
                color: "transparent"     // "orange"
                // opacity: 0.3

                Text {
                    text: qsTr("<b>Passenger</b>")
                    font.pixelSize: 48 *appScale
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            WindDirection {
                id: passenger_origin
                anchors.centerIn: parent
                scale: 1.1  //1
                allow_scale: false
                set_transform: false

                img_face_wind: parent.img_face
                img_foot_wind: parent.img_foot
                img_heater: parent.img_heater_
                heater_on: parent.heaterOn

                onClicked: {
                    area_select = "passengerArea"
                    wind_select.setTransform = false
                    wind_select.visible = !wind_select.visible
                }
            }
        }


        // AC
        Item {
            id: acArea
            width: 192 *appScale
            height: width
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            property bool ac_state: false

            Rectangle {
                id: backgroundAC
                anchors.fill: parent
                color: "pink"
                opacity: 0.25
            }

            Text {
                id: ac_Label
                parent: acArea
                text: "AC OFF"
                font.pixelSize: 48
                color: "white"
//                anchors.verticalCenter: Text.verticalAlignment
                x: 35
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    acArea.ac_state = !acArea.ac_state
                    if(acArea.ac_state) ac_Label.text = "AC ON"
                    else    ac_Label.text = "AC OFF"
                }

            }
        }

        // Fan level
        Item {
            id: fanArea
            width: 192 *appScale
            height: width
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: backgroundFan
                anchors.fill: parent
                color: "transparent"    //"orange"
                opacity: 0.25
            }

            Image {
                id: fan_img
                source: "qrc:/App/Climate/Image/ico_wind_level.png"
                width: 128 *appScale
                height: width
                anchors.centerIn: parent
            }
        }

        // SYNC
        Item {
            id: syncArea
            width: 192 *appScale
            height: width
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            property bool sync_state: false

            Rectangle {
                id: backgroundSync
                anchors.fill: parent
                color: "transparent"     //"pink"
                opacity: 0.25
            }

            Text {
                id: sync_Label
                parent: syncArea
                text: "SYNC OFF"
                font.pixelSize: 48
                color: "white"

                anchors.right: parent.right
                anchors.rightMargin: 25
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    syncArea.sync_state = !syncArea.sync_state
                    if(syncArea.sync_state) sync_Label.text = "SYNC ON"
                    else    sync_Label.text = "SYNC OFF"
                }

            }
        }



        // Menu lựa chọn hướng gió
        Item {
            id: wind_select
            parent: area_select === "driverArea" ? driverArea : passengerArea
            property bool setTransform: false
            anchors.fill: parent

            visible: false

            // Menu lựa chọn hướng gió driver
            WindDirection {
                id: driver_wind_off
                scale: 0.5
                set_transform: parent.setTransform
                x: 50
                y: 230
                img_face_wind: "qrc:/App/Climate/Image/Climate_02_gr.png"
                img_foot_wind: "qrc:/App/Climate/Image/Climate_03_gr.png"

                onClicked: {
                    parent.parent.img_face = img_face_wind
                    parent.parent.img_foot = img_foot_wind
                    parent.visible = !parent.visible
                    parent.parent.heaterOn = false
                }
            }
            WindDirection {
                id: driver_wind_foot
                scale: 0.5
                set_transform: parent.setTransform
                x: 90
                y: 110
                img_face_wind: "qrc:/App/Climate/Image/Climate_02_gr.png"
                img_foot_wind: "qrc:/App/Climate/Image/Climate_03_b.png"

                onClicked: {
                    parent.parent.img_face = img_face_wind
                    parent.parent.img_foot = img_foot_wind
                    parent.visible = !parent.visible
                    parent.parent.heaterOn = false
                }
            }

            WindDirection {
                id: driver_wind_face
                scale: 0.5
                set_transform: parent.setTransform
                y: 65
                anchors.horizontalCenter: parent.horizontalCenter
                img_face_wind: "qrc:/App/Climate/Image/Climate_02_b.png"
                img_foot_wind: "qrc:/App/Climate/Image/Climate_03_gr.png"
                onClicked: {
                    parent.parent.img_face = img_face_wind
                    parent.parent.img_foot = img_foot_wind
                    parent.visible = !parent.visible
                    parent.parent.heaterOn = false
                }
            }
            WindDirection {
                id: driver_wind_full
                scale: 0.5
                set_transform: parent.setTransform
                x: 305
                y: 110
                img_face_wind: "qrc:/App/Climate/Image/Climate_02_b.png"
                img_foot_wind: "qrc:/App/Climate/Image/Climate_03_b.png"
                onClicked: {
                    parent.parent.img_face = img_face_wind
                    parent.parent.img_foot = img_foot_wind
                    parent.visible = !parent.visible
                    parent.parent.heaterOn = false
                }
            }
            WindDirection {
                id: driver_seat_heating
                scale: 0.5
                allow_scale: false
                set_transform: parent.setTransform
                heater_on: true
                x: 345
                y: 230
                img_face_wind: "qrc:/App/Climate/Image/Climate_02_gr.png"
                img_foot_wind: "qrc:/App/Climate/Image/Climate_03_gr.png"
                img_heater: "qrc:/App/Climate/Image/heating_00.png"
                onClicked: {
                    parent.parent.img_face = img_face_wind
                    parent.parent.img_foot = img_foot_wind
                    parent.parent.img_heater_ = img_heater
                    parent.parent.heaterOn = true
                    parent.visible = !parent.visible
                }
            }
        }
    }    
}
