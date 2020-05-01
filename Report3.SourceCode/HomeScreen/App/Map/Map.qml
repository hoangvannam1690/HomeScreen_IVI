import QtQuick 2.11
import QtQuick.Controls 2.4
import QtLocation 5.6
import QtPositioning 5.6
import "./../Common/"

Item {
    id: root
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    property string longitude: MyMap.getLongitude()
    property string latitude: MyMap.getLatitude()

    width: screenWidth
    height: screenHeight - (70 * appScale)

    Item {
        id: startAnimation
        XAnimator{
            target: root
            from: screenWidth
            to: 0
            duration: 200
            running: true
        }
    }

    //Header
    AppHeader{
        id: headerItem
        appName: "Map"
    }

    Plugin {
        id: mapPlugin
        name: MyMap.getMapPlugin()
    }
    MapQuickItem {
        id: marker
        anchorPoint.x: image.width/4
        anchorPoint.y: image.height
        coordinate: QtPositioning.coordinate(longitude, latitude)

        sourceItem: Image {
            id: image
            source: "qrc:/Img/Map/car_icon.png"
        }
    }

    Map {
        id: map
        width: parent.width
        height: parent.height - headerItem.height
        anchors.top: headerItem.bottom
        plugin: mapPlugin
        center: QtPositioning.coordinate(longitude, latitude)

        zoomLevel: 14
        copyrightsVisible: false
        Component.onCompleted: {
            map.addMapItem(marker)
        }
    }

    //! Map's mouse area for implementation of panning in the map and zoom on double click
    MouseArea {
        id: mousearea

        //! Property used to indicate if panning the map
        property bool __isPanning: false

        //! Last pressed X and Y position
        property int __lastX: -1
        property int __lastY: -1

        anchors.fill : parent

        //! When pressed, indicate that panning has been started and update saved X and Y values
        onPressed: {
            __isPanning = true
            __lastX = mouse.x
            __lastY = mouse.y
        }

        //! When released, indicate that panning has finished
        onReleased: {
            __isPanning = false
        }

        //! Move the map when panning
        onPositionChanged: {
            if (__isPanning) {
                var dx = mouse.x - __lastX
                var dy = mouse.y - __lastY
                map.pan(-dx, -dy)
                __lastX = mouse.x
                __lastY = mouse.y
            }
        }

        //! When canceled, indicate that panning has finished
        onCanceled: {
            __isPanning = false;
        }

        //! Zoom one level when double clicked

        property var pickCoordinate: map.toCoordinate(Qt.point(mouseX, mouseY))
        onDoubleClicked: {
            map.center = map.toCoordinate(Qt.point(__lastX,__lastY))
            MyMap.setCoordinate(pickCoordinate.latitude, pickCoordinate.longitude)
            map.addMapItem(marker)
//            map.zoomLevel += 1
        }
    }

    Connections {
        target: MyMap
        onDataChanged: {
            longitude = MyMap.getLongitude()
            latitude  = MyMap.getLatitude()
        }
    }
}
