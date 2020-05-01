#include "xmlwriter.h"

// Khởi tạo giá trị ban đầu cho class
xmlwriter::xmlwriter() {
  app_index = "";
  app_title = "";
  app_url = "";
  icon_path = "";
}

// Dữ liệu gửi từ QML
void xmlwriter::setData(QString index, QString title, QString url,
                        QString icon) {
  app_index = index;
  app_title = title;
  app_url = url;
  icon_path = icon;

  saveData();  // Thông tin từng app được thêm vào QDomElement
}

void xmlwriter::clearData() {
  document.clear();
  APPLICATIONS.clear();
  APPLICATIONS = document.createElement("APPLICATIONS");
}

// danh sách các app được thêm vào theo thứ tự
void xmlwriter::saveData() {
  QDomElement APP = document.createElement("APP");
  APP.setAttribute("ID", "00" + app_index);
  APPLICATIONS.appendChild(APP);

  QDomElement TITLE = document.createElement("TITLE");
  TITLE.appendChild(document.createTextNode(app_title));
  APP.appendChild(TITLE);

  QDomElement URL = document.createElement("URL");
  URL.appendChild(document.createTextNode(app_url));
  APP.appendChild(URL);

  QDomElement ICON_PATH = document.createElement("ICON_PATH");
  ICON_PATH.appendChild(document.createTextNode(icon_path));
  APP.appendChild(ICON_PATH);
}

void xmlwriter::writeToFile(QString filePath) {
  QFile file(filePath);
  if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate | QIODevice::Text))
  {
    qDebug() << "can't write....";
    return;
  }

  QTextStream out(&file);
  out << document.toString();
//  qDebug() << "Write to file....";
  file.close();
}

void xmlwriter::appendApp() { document.appendChild(APPLICATIONS); }
