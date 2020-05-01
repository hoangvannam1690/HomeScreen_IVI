#include "myMap.h"

MyMap::MyMap() {
  longitude = 10.851;
  latitude = 106.798;
  mapPlugin = "esri";    // "mapboxgl" //"osm" // , "esri", ...
}

void MyMap::setLongitude(qreal setLongitude) { longitude = setLongitude; }

void MyMap::setLatitude(qreal setLatitude) { latitude = setLatitude; }

void MyMap::setMapPlugin(QString setMapPlugin)
{
    mapPlugin = setMapPlugin;
}

qreal MyMap::getLongitude() { return longitude; }

qreal MyMap::getLatitude() { return latitude; }

QString MyMap::getMapPlugin()
{
    return mapPlugin;
}

void MyMap::setCoordinate(qreal longitude_val, qreal latitude_val) {
  longitude = longitude_val;
  latitude = latitude_val;
  emit dataChanged(longitude, latitude);
}
