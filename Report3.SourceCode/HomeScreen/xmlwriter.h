#ifndef XMLWRITER_H
#define XMLWRITER_H
#include <QDebug>
#include <QFile>
#include <QObject>
#include <QtXml>

class xmlwriter : public QObject {
  Q_OBJECT
 public:
  xmlwriter();

 public slots:
  void setData(QString index, QString title, QString url, QString icon);
  // Trước khi lưu dữ liệu mới vào QDomDocument, cần xóa dữ liệu trước đó
  void clearData();
  void saveData();
  void writeToFile(QString filePath);
  void appendApp();

 private:
  QString app_index;
  QString app_title;
  QString app_url;
  QString icon_path;

  // Khởi tạo document chứa thông tin các app để ghi ra XML
  QDomDocument document;
  QDomElement APPLICATIONS = document.createElement("APPLICATIONS");

 protected:
};

#endif  // XMLWRITER_H
