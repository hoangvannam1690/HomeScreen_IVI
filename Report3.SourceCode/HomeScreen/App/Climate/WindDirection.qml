import QtQuick 2.0

//Item {
MouseArea {
    id: root
    implicitWidth: border.width
    implicitHeight: border.height
//    anchors.fill: border
    hoverEnabled: true

    property string img_border: "qrc:/App/Climate/Image/Climate_bg_n_b.png"
    property string img_border_enter: "qrc:/App/Climate/Image/Climate_bg_n_g.png"
    property string img_seat: "qrc:/App/Climate/Image/Climate_00.png"
    property string img_heater: "qrc:/App/Climate/Image/heating_00.png"
    property string img_face_wind: "qrc:/App/Climate/Image/Climate_03_b.png"
    property string img_foot_wind: "qrc:/App/Climate/Image/Climate_02_b.png"
    property bool allow_scale: true
    property bool set_transform: false
    property bool heater_on: false

    Image {
        id: border
        source: img_border
        width: img_origin.width *1.2
        height: width
        anchors.centerIn: parent

        // Hình Ghế ngồi
        Image {
            id: img_origin
            source: img_seat
            width: 250 *appScale
            height: width
            anchors.centerIn: parent
        }
        Image {
            id: face_wind
            source: img_face_wind
            width: img_origin.width
            height: width
            anchors.centerIn: parent
        }
        Image {
            id: foot_wind
            source: img_foot_wind
            width: img_origin.width
            height: width
            anchors.centerIn: parent
        }
        Image {
            id: foot_heater
            source: img_heater
            width: img_origin.width
            height: width
            anchors.centerIn: parent
            visible: heater_on
        }
    }

    onEntered: {
        if(allow_scale) border.scale = 1.2
        border.source = img_border_enter
    }

    onExited: {
        border.scale = 1.0
        border.source = img_border
    }

    Component.onCompleted: {

    }

    transform: [
        Scale{ xScale: set_transform ? -1 : 1 },
        Translate { x: set_transform ? root.width : 0 }
    ]
}
