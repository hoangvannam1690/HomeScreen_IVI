import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6

MouseArea {
    id: root
    preventStealing: true
    propagateComposedEvents: true
    implicitWidth: 635  * scaleRatio
    implicitHeight: 570 * scaleRatio
    Rectangle {
        anchors{
            fill: parent
            margins: 10  *scaleRatio
        }
        opacity: 0.7
        color: "#111419"
    }
    Item {
        id: map
        x: 10 * scaleRatio
        y: 10 *scaleRatio
        width: 615 *scaleRatio
        height: 550 *scaleRatio
        Plugin {
            id: mapPlugin
            name: MyMap.getMapPlugin()
        }
        MapQuickItem {
            id: marker
            anchorPoint.x: image.width/4
            anchorPoint.y: image.height
            coordinate: QtPositioning.coordinate(MyMap.getLongitude(), MyMap.getLatitude())
            sourceItem: Image {
                id: image
                source: "qrc:/Img/Map/car_icon.png"
            }
        }
        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(MyMap.getLongitude(), MyMap.getLatitude())
            zoomLevel: 14
            copyrightsVisible: false
            enabled: false
            Component.onCompleted: {
                mapView.addMapItem(marker)
            }
        }
    }
    Image {
        id: idBackgroud
        width: root.width
        height: root.height
        source: ""
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

    Connections {
        target: MyMap
        onDataChanged: {
            mapView.center = QtPositioning.coordinate(MyMap.getLongitude(), MyMap.getLatitude())
            marker.coordinate = QtPositioning.coordinate(MyMap.getLongitude(), MyMap.getLatitude())
        }
    }
}

