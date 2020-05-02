#include "screensize.h"
#include <QRect>
#include <QGuiApplication>
#include <QScreen>

ScreenSize::ScreenSize(QObject *parent) : QObject(parent) {
//  appWidth = 1920;
//  appHeight = 1200;
  scaleRatio = 1;

  QScreen *screen = QGuiApplication::primaryScreen();
  QRect  screenGeometry = screen->geometry();
  appHeight = screenGeometry.height();
  appWidth = screenGeometry.width();
}

void ScreenSize::setScreenSize(qreal width, qreal height, qreal scale) {
  appWidth = width;
  appHeight = height;
  scaleRatio = scale;
}

qreal ScreenSize::getAppWidth() { return appWidth; }

qreal ScreenSize::getAppHeight() { return appHeight; }

qreal ScreenSize::getScaleRatio()
{
    return scaleRatio;
}
