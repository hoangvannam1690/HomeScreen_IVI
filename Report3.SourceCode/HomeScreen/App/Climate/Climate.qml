import QtQuick 2.11
import "./../Common/"

Item {
    id: mroot
//    width: 1920; height: 570 + 526
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: (570 + 526) * appScale

    //Header
    AppHeader{
        id: headerItem
        appName: "Climate"
    }

    Rectangle {
        id: climateDisplay
        width: parent.width
        height: parent.height - headerItem.height - (200 * appScale)
        anchors.top: headerItem.bottom
        color: "transparent"

        Rectangle {
            id: root
            width: 635
            height: 570
            color: "transparent"
            anchors.centerIn: parent
            scale: 1.5 * appScale

            //Driver
            Text {
                x: 43
                y: 135
                width: 184
                text: "DRIVER"
                color: "white"
                font.pixelSize: 34
                horizontalAlignment: Text.AlignHCenter
            }
            Image {
                x:43
                y: (135+41)
                width: 184
                source: "qrc:/Img/HomeScreen/widget_climate_line.png"
            }
            Image {
                x: (55+25+26)
                y:205
                width: 110
                height: 120
                source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
            }
            Image {
                x: (55+25)
                y:(205+34)
                width: 70
                height: 50
                source: climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
            }
            Image {
                x: 55
                y:(205+34+26)
                width: 70
                height: 50
                source: climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
            }
            Text {
                id: driver_temp
                x: 43
                y: (248 + 107)
                width: 184
                color: "white"
                font.pixelSize: 46
                horizontalAlignment: Text.AlignHCenter

                text: {
                    if (climateModel.driver_temp == 16.5) {
                        return "LOW"
                    } else if (climateModel.driver_temp == 31.5) {
                        return "HIGH"
                    } else {
                        return climateModel.driver_temp+"°C"
                    }
                }
            }

            //Passenger
            Text {
                x: (43+184+182)
                y: 135
                width: 184
                text: "PASSENGER"
                color: "white"
                font.pixelSize: 34
                horizontalAlignment: Text.AlignHCenter
            }
            Image {
                x: (43+184+182)
                y: (135+41)
                width: 184
                source: "qrc:/Img/HomeScreen/widget_climate_line.png"
            }
            Image {
                x: (55+25+26+314+25+26)
                y:205
                width: 110
                height: 120
                source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
            }
            Image {
                x: (55+25+26+314+25)
                y: (205+34)
                width: 70
                height: 50
                source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
            }
            Image {
                x: (55+25+26+314)
                y: (205+34+26)
                width: 70
                height: 50
                source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
            }
            Text {
                id: passenger_temp
                x: (43+184+182)
                y: (248 + 107)
                width: 184
                color: "white"
                font.pixelSize: 46
                horizontalAlignment: Text.AlignHCenter
                text: {

                    if (climateModel.passenger_temp == 16.5) {
                        return "LOW"
                    } else if (climateModel.passenger_temp == 31.5) {
                        return "HIGH"
                    } else {
                        return climateModel.passenger_temp+"°C"
                    }
                }
            }
            //Wind level
            Image {
                x: 172
                y: 248
                width: 290
                height: 100
                source: "qrc:/Img/HomeScreen/widget_climate_wind_level_bg.png"
            }
            Image {
                id: fan_level
                x: 172
                y: 248
                width: 290
                height: 100
                source: {"qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
                    if (climateModel.fan_level < 1) {
                        return  "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
                    }
                    else if (climateModel.fan_level < 10) {
                        return "qrc:/Img/HomeScreen/widget_climate_wind_level_0"+climateModel.fan_level+".png"
                    } else {
                        return "qrc:/Img/HomeScreen/widget_climate_wind_level_"+climateModel.fan_level+".png"
                    }
                }
            }
            Connections{
                target: climateModel
                onDataChanged: {
                    //set data for fan level
                    if (climateModel.fan_level < 1) {
                        fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
                    }
                    else if (climateModel.fan_level < 10) {
                        fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_0"+climateModel.fan_level+".png"
                    } else {
                        fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_"+climateModel.fan_level+".png"
                    }
                    //set data for driver temp
                    if (climateModel.driver_temp == 16.5) {
                        driver_temp.text = "LOW"
                    } else if (climateModel.driver_temp == 31.5) {
                        driver_temp.text = "HIGH"
                    } else {
                        driver_temp.text = climateModel.driver_temp+"°C"
                    }

                    //set data for passenger temp
                    if (climateModel.passenger_temp == 16.5) {
                        passenger_temp.text = "LOW"
                    } else if (climateModel.passenger_temp == 31.5) {
                        passenger_temp.text = "HIGH"
                    } else {
                        passenger_temp.text = climateModel.passenger_temp+"°C"
                    }
                }
            }
            //Fan
            Image {
                x: (172 + 115)
                y: (248 + 107)
                width: 60
                height: 60
                source: "qrc:/Img/HomeScreen/widget_climate_ico_wind.png"
            }
            //Bottom
            Text {
                x:30
                y:(466 + 18)
                width: 172
                horizontalAlignment: Text.AlignHCenter
                text: "AUTO"
                color: !climateModel.auto_mode ? "white" : "gray"
                font.pixelSize: 46
            }
            Text {
                x:(30+172+30)
                y:466
                width: 171
                horizontalAlignment: Text.AlignHCenter
                text: "OUTSIDE"
                color: "white"
                font.pixelSize: 26
            }
            Text {
                x:(30+172+30)
                y:(466 + 18 + 21)
                width: 171
                horizontalAlignment: Text.AlignHCenter
                text: "27.5°C"
                color: "white"
                font.pixelSize: 38
            }
            Text {
        //        id: mSyncmode
                x:(30+172+30+171+30)
                y:(466 + 18)
                width: 171
                horizontalAlignment: Text.AlignHCenter
                text: "SYNC"
                color: !climateModel.sync_mode ? "white" : "gray"    //sync_mode.currentIndex ? "white" : "gray"
                font.pixelSize: 46
            }
        }
    }

}
