#include "screensize.h"

ScreenSize::ScreenSize(QObject *parent) : QObject(parent) {
  appWidth = 1920;
  appHeight = 1200;
  scaleRatio = 1;
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
