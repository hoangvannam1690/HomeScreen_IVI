import QtQuick 2.11
import QtQuick.Controls 2.4
//import QtQuick.Controls 1.4     // MenuItem commponent
import QtGraphicalEffects 1.0
import QtQuick.Extras 1.4
import QtQuick.Window 2.0

import "./../Common/"
import "./../Phone/"
// Tham khảo các màn hình:
// http://webmanual.genesis.com/PREM_GEN5/AVNT/HI/KOR/English/index.html
// http://webmanual.kia.com/DA_GEN2_V/AV/KOR/English/010_Settings_general.html
// http://www.qnx.com/developers/docs/qnxcar2/index.jsp?topic=%2Fcom.qnx.doc.qnxcar2.gsg%2Ftopic%2Fsettings_screen.html
// https://www.coroflot.com/ZionHsieh/In-car-Infotainment-UI-design
// https://www.google.com.vn/imgres?imgurl=http%3A%2F%2Fwww.japanesesportcars.com%2Fphotos%2Fd%2F554492-1%2Fnissan-leaf-android-app.jpg&imgrefurl=http%3A%2F%2Fwww.japanesesportcars.com%2Fphotos%2Fdesktop-wallpapers%2Fnissan%2Fmiscellaneous%2Fnissan-leaf-blackberry-androi-app%2Fnissan-leaf-android-app.jpg.html&docid=0B9Pl0NLnQ9AzM&tbnid=X3Ftn-t6uN9gSM%3A&vet=1&w=404&h=720&itg=1&bih=625&biw=1366&ved=2ahUKEwjnqLir8Y_pAhVRA4gKHfyeBH4QxiAoA3oECAEQHw&iact=c&ictx=1
// http://linuxgizmos.com/harman-linux-ivi-system-supports-html5-apps/
// https://www.google.com.vn/imgres?imgurl=https%3A%2F%2Felectrek.co%2F2018%2F09%2F30%2Ftesla-mobile-app-update-more-control-phone%2Fscreen-shot-2018-09-30-at-9-37-20-am%2F&imgrefurl=https%3A%2F%2Felectrek.co%2F2018%2F09%2F30%2Ftesla-mobile-app-update-more-control-phone%2F&docid=LJ5BSikUZiMj4M&tbnid=N1QdLGxzcJM3mM%3A&vet=1&w=748&h=1593&itg=1&bih=625&biw=1366&ved=2ahUKEwjxi7S18Y_pAhVVfXAKHaV5BbIQxiAoBHoECAEQIg&iact=c&ictx=1
//
// Button Climate
// https://www.google.com.vn/imgres?imgurl=https%3A%2F%2Fbrisbanecitypeugeot.com.au%2Fsc%2Fnew-car-showroom%2Fgallery%2Fhb6krht1bgnuphuvuod2oekezzgxq5.jpeg&imgrefurl=https%3A%2F%2Fbrisbanecitypeugeot.com.au%2Fnew-car-showroom%2F308-touring&docid=_hFqknorUFO_-M&tbnid=zU2Ghu8GyLttdM%3A&vet=1&w=640&h=400&itg=1&bih=625&biw=1366&ved=2ahUKEwijv8WZ8Y_pAhUVA4gKHZtYAs0QxiAoBnoECAEQKQ&iact=c&ictx=1
// https://www.google.com.vn/imgres?imgurl=https%3A%2F%2Fdeveloper.apple.com%2Fdesign%2Fhuman-interface-guidelines%2Fcarplay%2Fimages%2FAutomakerApp_2x.png&imgrefurl=https%3A%2F%2Fdeveloper.apple.com%2Fdesign%2Fhuman-interface-guidelines%2Fcarplay%2Foverview%2Fautomaker-apps%2F&docid=279VKKtxBwMj5M&tbnid=CyNbIt2Ter32LM%3A&vet=1&w=1200&h=736&itg=1&bih=625&biw=1366&ved=2ahUKEwijv8WZ8Y_pAhUVA4gKHZtYAs0QxiAoBXoECAEQJg&iact=c&ictx=1
// https://techcrunch.com/2017/08/03/curious-about-teslas-unique-model-3-in-car-ui-check-out-this-mock-up/
// https://dribbble.com/shots/9073892-DAILY-UI-034-Car-Interface
// https://www.rightware.com/blog/is-kanzi-really-transforming-ui-design
// https://doc.qt.io/QtSafeRenderer/qtsaferenderer-saferenderer-qtcluster-example.html
//

// OK
Item {
    id: root
    property real screenWidth: screenSize.getAppWidth()
    property real screenHeight: screenSize.getAppHeight()
    property real appScale: screenSize.getScaleRatio()

    property string popupTile: "Title"

    width: screenWidth
    height: screenHeight - (70 * appScale)

    function openApplication(url){
        parent.push(url)
    }

    XAnimator{
        target: root
        from: screenWidth
        to: 0
        duration: 200
        running: true
    }

    //Header
    AppHeader{
        id: headerItem
        appName: "Setting"
    }

    // Danh sách menu setting
    ListModel {
        id: settingListModel
        ListElement { name: "General";  url_icon : "qrc:/App/Setting/ico/General.png";  url: ""}
        ListElement { name: "Sound";    url_icon : "qrc:/App/Setting/ico/Sound.png";    url: ""}
        ListElement { name: "Display";  url_icon : "qrc:/App/Setting/ico/Video.png";    url: ""}
        ListElement { name: "Wifi";     url_icon : "qrc:/App/Setting/ico/Wifi.png";     url: ""}
        ListElement { name: "Vehicle";  url_icon : "qrc:/App/Setting/ico/Control.png";  url: ""}
        ListElement { name: "Date/Time"; url_icon : "qrc:/App/Setting/ico/Clock.png";   url: ""}
        ListElement { name: "Info";     url_icon : "qrc:/App/Setting/ico/Info.png";     url: ""}
        ListElement { name: "Language"; url_icon : "qrc:/App/Setting/ico/Language.png"; url: ""}
    }

    onFocusChanged:  settingMenu.forceActiveFocus()

    // Khu vực hiển thị danh sách icon setting
    Rectangle{
        id: iconListArea
        width: root.width
        height: root.height - headerItem.height
        anchors.top: headerItem.bottom
        color: "transparent"

        // List icon
        GridView {
            id: settingMenu
            interactive: false
            opacity: 1
            anchors.fill: iconListArea

            cellWidth: 480 *appScale
            cellHeight: cellWidth
            focus: true
            model: settingListModel

            highlight: Rectangle {
                color: "transparent"
                Image {
                    id: highlightItem
                    width: 275 *appScale
                    height: width
                    anchors.centerIn: parent
                    source: "qrc:/App/Setting/ico/focus_256.png"
                }
            }
            highlightMoveDuration: 10
            keyNavigationEnabled : true

            delegate: Item {
                width: 480 *appScale
                height: width
                Rectangle {
                    width: parent.width; height: parent.height
                    color: "transparent"
                    Image {
                        id: myIcon
                        width: 256 *appScale
                        height: width
                        anchors.centerIn: parent
                        source: url_icon
                    }
                    Text {
                        anchors {
                            top: myIcon.bottom
                            topMargin: 10 *appScale
                            horizontalCenter: parent.horizontalCenter
                        }
                        color: "white"
                        font.pointSize: 36 *appScale
                        text: name
                    }
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        parent.GridView.view.currentIndex = index
                        popupTile = settingListModel.get(index).name

                        settingMenuBlur.start()
                        popupWindow.open()
                    }
                }

                Keys.onPressed: {
                    if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                        popupTile = settingListModel.get(index).name
                        settingMenuBlur.start()
                        popupWindow.open()
                        event.accepted = true
                    }
                }
            }
        }

        PopupWindows {
            id: popupWindow
            popupGeneralName: root.popupTile

            Loader {
                id: iconWidget
                width: parent.width
                height: parent.height
                sourceComponent: {
                    switch(root.popupTile) {
                    case "General": return genSet
                    case "Sound": return soundSet
                    case "Display": return displaySet
                    case "Wifi": return wifiSet
                    case "Vehicle": return vehicleSet
                    case "Date/Time": return dateSet
                    case "Info": return infoSet
                    case "Language": return langSet
                    default:
                    }
                }
            }
        }
    }

    // Hiệu ứng làm mờ list icon
    NumberAnimation { id: settingMenuBlur; target: settingMenu; property: "opacity"; from: 1.0; to: 0.4; duration: 200 }
    NumberAnimation { id: settingMenuUnblur; target: settingMenu; property: "opacity"; from: 0.4; to: 1.0; duration: 200 }

    // Khai báo các Component, sử dụng cho Loader
    Component { id: genSet; SetGeneral {} }
    Component { id: soundSet; SetSound {} }
    Component { id: displaySet; SetDisplay {} }
    Component { id: wifiSet; SetWifi {} }
    Component { id: vehicleSet; SetVehicle {} }
    Component { id: dateSet; SetDateTime {} }
    Component { id: infoSet; SetInfo {} }
    Component { id: langSet; SetLanguage {} }
}


