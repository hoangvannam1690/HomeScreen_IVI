import QtQuick 2.0

// Dùng làm thanh header chung cho toàn bộ các app
// và hiển thị tên của app
Item {
    id: header
    property var appName: "Header"
    property real screenWidth: screenSize.getAppWidth()
    property real appScale: screenSize.getScaleRatio()

    width: screenWidth
    height: 141 *appScale

    Image {
        id: headerItem
        anchors.fill: parent
        source: "qrc:/App/Media/Image/title.png"
        Text {
            id: headerTitleText
            text: appName
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46 * appScale
        }
    }
}
