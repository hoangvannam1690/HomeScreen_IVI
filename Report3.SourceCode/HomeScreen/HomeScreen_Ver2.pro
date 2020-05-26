QT += quick multimedia dbus xml core  network positioning location   #quickcontrols2

#QT += qml quick network positioning location

CONFIG += c++11
CONFIG+=qml_debug

DBUS_INTERFACES += Dbus/climate.xml
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

TEMPLATE = app
TARGET = HomeScreen
VERSION = 1.0.0

SOURCES += \
        App/Climate/climatemodel.cpp \
        App/Map/myMap.cpp \
        App/Media/player.cpp \
        App/Media/playlistmodel.cpp \
        applicationsmodel.cpp \
        main.cpp \
        screensize.cpp \
        xmlreader.cpp \
        xmlwriter.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    App/Climate/climatemodel.h \
    App/Map/myMap.h \
    App/Media/player.h \
    App/Media/playlistmodel.h \
    applicationsmodel.h \
    screensize.h \
    xmlreader.h \
    xmlwriter.h

DISTFILES +=

# Icon application
RC_FILE = appIcon.rc

### kit: MinGW 64bit
win32: {
    LIBS += -L$$PWD/mTaglib/bin/ -ltag
}
else:unix: {
    LIBS += -L$$PWD/mTaglib/lib/ -ltag
}
INCLUDEPATH += $$PWD/mTaglib/include
DEPENDPATH += $$PWD/mTaglib/include

