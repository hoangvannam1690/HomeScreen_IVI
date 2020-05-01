#ifndef SCREENSIZE_H
#define SCREENSIZE_H

#include <QObject>

class ScreenSize : public QObject
{
    Q_OBJECT
public:
    explicit ScreenSize(QObject *parent = nullptr);

public slots:
    void setScreenSize(qreal width, qreal height, qreal scale);
    qreal getAppWidth();
    qreal getAppHeight();
    qreal getScaleRatio();

signals:


private:
    qreal appWidth;
    qreal appHeight;
    qreal scaleRatio;

};

#endif // SCREENSIZE_H
