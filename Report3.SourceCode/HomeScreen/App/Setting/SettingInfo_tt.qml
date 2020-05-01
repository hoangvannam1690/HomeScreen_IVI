import QtQuick 2.0

Item {
    id: root
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: screenHeight - (70 * appScale)
    Rectangle {
        id: infoWindown
        anchors.fill: parent
        color: "blue"
        opacity: 0.1
    }
}
