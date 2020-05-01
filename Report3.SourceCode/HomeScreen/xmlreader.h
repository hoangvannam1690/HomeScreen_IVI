#ifndef XMLREADER_H
#define XMLREADER_H
#include <QFile>
#include <QtXml>

#include "applicationsmodel.h"

class XmlReader {
 public:
  XmlReader(QString filePath, ApplicationsModel &model);
//  XmlReader(QString filePath, QString userFilePath, ApplicationsModel &model);

 private:
  QDomDocument m_xmlDoc;  // The QDomDocument class represents an XML document.
  bool ReadXmlFile(QString filePath);
  void PaserXml(ApplicationsModel &model);
};

#endif  // XMLREADER_H
