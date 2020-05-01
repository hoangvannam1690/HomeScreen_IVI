#ifndef MAP_H
#define MAP_H
#include <QObject>

class MyMap : public QObject {
  Q_OBJECT
 public:
  MyMap();

 public slots:
  void setLongitude(qreal setLongitude);
  void setLatitude(qreal setLatitude);
  void setMapPlugin(QString setMapPlugin);
  qreal getLongitude();
  qreal getLatitude();
  QString getMapPlugin();
  Q_INVOKABLE void setCoordinate(qreal longitude_val, qreal latitude_val);

 signals:
  void dataChanged(qreal &mLongitude, qreal &mLatitude);

 private:
  qreal longitude;
  qreal latitude;
  QString mapPlugin;
};

#endif  // MAP_H

