import QtQuick 2.0

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
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40 *scaleRatio
        text: "Climate"
        color: "white"
        font.pixelSize: 34 *scaleRatio
    }
    //Driver
    Text {
        x: 43 *scaleRatio
        y: 135 *scaleRatio
        width: 184 *scaleRatio
        text: "DRIVER"
        color: "white"
        font.pixelSize: 34 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        x:43 *scaleRatio
        y: (135+41) *scaleRatio
        width: 184 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_line.png"
    }
    Image {
        x: (55+25+26) *scaleRatio
        y:205 *scaleRatio
        width: 110 *scaleRatio
        height: 120 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }
    Image {
        x: (55+25) *scaleRatio
        y:(205+34) *scaleRatio
        width: 70 *scaleRatio
        height: 50 *scaleRatio
        source: climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"

    }
    Image {
        x: 55 *scaleRatio
        y:(205+34+26) *scaleRatio
        width: 70 *scaleRatio
        height: 50 *scaleRatio
        source: climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }
    Text {
        id: driver_temp
        x: 43 *scaleRatio
        y: (248 + 107) *scaleRatio
        width: 184 *scaleRatio
        text: "18.5°C"
        color: "white"
        font.pixelSize: 46 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
    }

    //Passenger
    Text {
        x: (43+184+182) *scaleRatio
        y: 135 *scaleRatio
        width: 184 *scaleRatio
        text: "PASSENGER"
        color: "white"
        font.pixelSize: 34 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        x: (43+184+182) *scaleRatio
        y: (135+41) *scaleRatio
        width: 184 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_line.png"
    }
    Image {
        x: (55+25+26+314+25+26) *scaleRatio
        y:205 *scaleRatio
        width: 110 *scaleRatio
        height: 120 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }
    Image {
        x: (55+25+26+314+25) *scaleRatio
        y: (205+34) *scaleRatio
        width: 70 *scaleRatio
        height: 50 *scaleRatio
        source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
    }
    Image {
        x: (55+25+26+314) *scaleRatio
        y: (205+34+26) *scaleRatio
        width: 70 *scaleRatio
        height: 50 *scaleRatio
        source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }
    Text {
        id: passenger_temp
        x: (43+184+182) *scaleRatio
        y: (248 + 107) *scaleRatio
        width: 184 *scaleRatio
        text: "22°C"
        color: "white"
        font.pixelSize: 46 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
    }
    //Wind level
    Image {
        x: 172 *scaleRatio
        y: 248 *scaleRatio
        width: 290 *scaleRatio
        height: 100 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_bg.png"
    }
    Image {
        id: fan_level
        x: 172 *scaleRatio
        y: 248 *scaleRatio
        width: 290 *scaleRatio
        height: 100 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
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
        x: (172 + 115) *scaleRatio
        y: (248 + 107) *scaleRatio
        width: 60 *scaleRatio
        height: 60 *scaleRatio
        source: "qrc:/Img/HomeScreen/widget_climate_ico_wind.png"
    }
    //Bottom
    Text {
        x:30 *scaleRatio
        y:(466 + 18) *scaleRatio
        width: 172 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
        text: "AUTO"
        color: !climateModel.auto_mode ? "white" : "gray"
        font.pixelSize: 46 *scaleRatio
    }
    Text {
        x:(30+172+30) *scaleRatio
        y:466 *scaleRatio
        width: 171 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
        text: "OUTSIDE"
        color: "white"
        font.pixelSize: 26 *scaleRatio
    }
    Text {
        x:(30+172+30) *scaleRatio
        y:(466 + 18 + 21) *scaleRatio
        width: 171 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
        text: "27.5°C"
        color: "white"
        font.pixelSize: 38 *scaleRatio
    }
    Text {
        x:(30+172+30+171+30) *scaleRatio
        y:(466 + 18) *scaleRatio
        width: 171 *scaleRatio
        horizontalAlignment: Text.AlignHCenter
        text: "SYNC"
        color: !climateModel.sync_mode ? "white" : "gray"
        font.pixelSize: 46 *scaleRatio
    }
    //
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
//        root.state = "Focus"
        root.state = "Normal"
    }
    onFocusChanged: {
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
}
