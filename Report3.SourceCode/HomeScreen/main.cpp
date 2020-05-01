#include <QDebug>
#include <QGuiApplication>
#include <QMediaPlaylist>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "App/Climate/climatemodel.h"
#include "App/Map/myMap.h"
#include "App/Media/player.h"
#include "App/Media/playlistmodel.h"
#include "applicationsmodel.h"
#include "xmlreader.h"
#include "xmlwriter.h"
#include "screensize.h"

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  qRegisterMetaType<QMediaPlaylist *>("QMediaPlaylist*");
  QGuiApplication app(argc, argv);

  QGuiApplication::setOrganizationName("OrganizationName");
  QGuiApplication::setOrganizationDomain("OrganizationDomain.com");
  QGuiApplication::setApplicationName("HomeScreen");

  QQmlApplicationEngine engine;

  ApplicationsModel appsModel;
  QString xmlPath = "applications.xml";
  XmlReader xmlReader(xmlPath, appsModel);

  engine.rootContext()->setContextProperty("appsModel", &appsModel);

  QQmlContext *context = engine.rootContext();
  xmlwriter xmlwriter;
  context->setContextProperty("xmlwriter", &xmlwriter);

  Player player;
  engine.rootContext()->setContextProperty("myModel", player.m_playlistModel);
  engine.rootContext()->setContextProperty("myRowCount",
                                           player.m_playlistModel->rowCount());
  engine.rootContext()->setContextProperty("player", player.m_player);
  engine.rootContext()->setContextProperty("playlist", player.m_playlist);
  engine.rootContext()->setContextProperty("playlistCurrentIndex",
                                           player.m_playlist->currentIndex());
  engine.rootContext()->setContextProperty("utility", &player);

  ClimateModel climate;
  engine.rootContext()->setContextProperty("climateModel", &climate);

  // Chứa thông tin vị trí map
  MyMap myMap;
  engine.rootContext()->setContextProperty("MyMap", &myMap);


  ScreenSize screenSize;
  engine.rootContext()->setContextProperty("screenSize", &screenSize);


  const QUrl url(QStringLiteral("qrc:/Qml/main.qml"));
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);
  // notify signal to QML read data from dbus
  emit climate.dataChanged();

  return app.exec();
}
