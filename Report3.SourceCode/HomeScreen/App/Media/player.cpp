///****************************************************************************
//**
//** Copyright (C) 2017 The Qt Company Ltd.
//** Contact: https://www.qt.io/licensing/
//**
//** This file is part of the examples of the Qt Toolkit.
//**
//** $QT_BEGIN_LICENSE:BSD$
//** Commercial License Usage
//** Licensees holding valid commercial Qt licenses may use this file in
//** accordance with the commercial license agreement provided with the
//** Software or, alternatively, in accordance with the terms contained in
//** a written agreement between you and The Qt Company. For licensing terms
//** and conditions see https://www.qt.io/terms-conditions. For further
//** information use the contact form at https://www.qt.io/contact-us.
//**
//** BSD License Usage
//** Alternatively, you may use this file under the terms of the BSD license
//** as follows:
//**
//** "Redistribution and use in source and binary forms, with or without
//** modification, are permitted provided that the following conditions are
//** met:
//**   * Redistributions of source code must retain the above copyright
//**     notice, this list of conditions and the following disclaimer.
//**   * Redistributions in binary form must reproduce the above copyright
//**     notice, this list of conditions and the following disclaimer in
//**     the documentation and/or other materials provided with the
//**     distribution.
//**   * Neither the name of The Qt Company Ltd nor the names of its
//**     contributors may be used to endorse or promote products derived
//**     from this software without specific prior written permission.
//**
//**
//** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
//**
//** $QT_END_LICENSE$
//**
//****************************************************************************/

//#include "player.h"

//#include <QDir>
//#include <QFileInfo>
//#include <QMediaMetaData>
//#include <QMediaPlaylist>
//#include <QMediaService>
//#include <QObject>
//#include <QStandardPaths>
//#include <QTime>

//#include "playlistmodel.h"

//Player::Player(QObject *parent) : QObject(parent) {
//  m_player = new QMediaPlayer(this);
//  m_playlist = new QMediaPlaylist(this);
//  m_player->setPlaylist(m_playlist);
//  m_playlistModel = new PlaylistModel(this);

//  // Khai báo path của music là folder Music mặc định của OS
//  musicDir =
//      QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0];

//  open(musicDir);
//  if (!m_playlist->isEmpty()) {
//    m_playlist->setCurrentIndex(0);
//  }
//}

//// Thực hiện xóa ảnh JPG khi thoát ứng dụng
//Player::~Player() { clearJpg(); }

//void Player::open(QString path) {
//  QDir directory(path);
//  QFileInfoList musics =
//      directory.entryInfoList(QStringList() << "*.mp3", QDir::Files);
//  QList<QUrl> urls;
//  for (int i = 0; i < musics.length(); i++) {
//    urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
//  }
//  addToPlaylist(urls);
//}

//void Player::addToPlaylist(const QList<QUrl> &urls) {
//  for (auto &url : urls) {
//    m_playlist->addMedia(url);

//#if defined(Q_OS_WIN)
//    // Xoa ky tu "/"
//    QString fileName = url.path().toStdString().c_str();
//    if (fileName.at(0) == "/") {
//      fileName.remove(0, 1);
//    }

//    // Đoạn code này giúp đọc được các file có tên tiếng việt
//    // Nếu không convert -> utf8: chương trình crash khi có file tiếng việt
//    TagLib::String str(fileName.toUtf8().constData(), TagLib::String::UTF8);

//    TagLib::FileName fname(str.toCWString());
//    TagLib::FileRef f(fname, true, TagLib::AudioProperties::Accurate);

//    Tag *tag = f.tag();
//    Song song(QString::fromWCharArray(tag->title().toCWString()),
//              QString::fromWCharArray(tag->artist().toCWString()),
//              url.toDisplayString(),
//              getAlbumArt(dynamic_cast<TagLib::MPEG::File *>(f.file())));

//#elif defined(Q_OS_LINUX)
//    FileRef f(url.path().toStdString().c_str());
//    Tag *tag = f.tag();
//    Song song(QString::fromWCharArray(tag->title().toCWString()),
//              QString::fromWCharArray(tag->artist().toCWString()),
//              url.toDisplayString(), getAlbumArt(url));
//#endif
//    m_playlistModel->addSong(song);
//  }
//}

//QString Player::getTimeInfo(qint64 currentInfo) {
//  QString tStr = "00:00";
//  currentInfo = currentInfo / 1000;
//  qint64 durarion = m_player->duration() / 1000;
//  if (currentInfo || durarion) {
//    QTime currentTime((currentInfo / 3600) % 60, (currentInfo / 60) % 60,
//                      currentInfo % 60, (currentInfo * 1000) % 1000);
//    QTime totalTime((durarion / 3600) % 60, (m_player->duration() / 60) % 60,
//                    durarion % 60, (m_player->duration() * 1000) % 1000);
//    QString format = "mm:ss";
//    if (durarion > 3600)
//      format = "hh::mm:ss";
//    tStr = currentTime.toString(format);
//  }
//  return tStr;
//}

//void Player::clearJpg() {
//  QDir dir(musicDir);
//  dir.setNameFilters(QStringList() << "*.jpg"
//                                   << "*.png");
//  dir.setFilter(QDir::Files);
//  for (const QString &dirFile : dir.entryList()) {
//    dir.remove(dirFile);
//  }
//}

//#if defined(Q_OS_WIN)
//QString Player::getAlbumArt(MPEG::File *mpegFile) {
//  static const char *IdPicture = "APIC";
//  TagLib::ID3v2::Tag *id3v2tag = mpegFile->ID3v2Tag();
//  TagLib::ID3v2::FrameList Frame;
//  TagLib::ID3v2::AttachedPictureFrame *PicFrame;
//  void *SrcImage;
//  unsigned long Size;
//  auto name = mpegFile->name().toString() + ".jpg";

//  FILE *jpegFile;
//  jpegFile = fopen(name.toCString(), "wb");

//  if (id3v2tag) {
//    Frame = id3v2tag->frameListMap()[IdPicture];
//    if (!Frame.isEmpty()) {
//      for (TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin();
//           it != Frame.end(); ++it) {
//        PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame *>(*it);
//        {
//          // extract image (in it’s compressed form)
//          Size = PicFrame->picture().size();
//          SrcImage = malloc(Size);
//          if (SrcImage) {
//            memcpy(SrcImage, PicFrame->picture().data(), Size);
//            fwrite(SrcImage, Size, 1, jpegFile);
//            fclose(jpegFile);
//            free(SrcImage);
//            return QUrl::fromLocalFile(name.toCString()).toDisplayString();
//          }
//        }
//      }
//    }
//  } else {
//    qDebug() << "id3v2 not present";
//    fclose(jpegFile);
//    return "qrc:/App/Media/Image/album_art.png";
//  }
//  fclose(jpegFile);
//  return "qrc:/App/Media/Image/album_art.png";
//}

//#elif defined(Q_OS_LINUX)
//QString Player::getAlbumArt(QUrl url) {
//  static const char *IdPicture = "APIC";
//  TagLib::MPEG::File mpegFile(url.path().toStdString().c_str());
//  TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
//  TagLib::ID3v2::FrameList Frame;
//  TagLib::ID3v2::AttachedPictureFrame *PicFrame;
//  void *SrcImage;
//  unsigned long Size;

//  FILE *jpegFile;
//  jpegFile =
//      fopen(QString(url.fileName() + ".jpg").toStdString().c_str(), "wb");

//  if (id3v2tag) {
//    // picture frame
//    Frame = id3v2tag->frameListMap()[IdPicture];
//    if (!Frame.isEmpty()) {
//      for (TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin();
//           it != Frame.end(); ++it) {
//        PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame *>(*it);
//        //  if ( PicFrame->type() ==
//        // TagLib::ID3v2::AttachedPictureFrame::FrontCover)
//        {
//          // extract image (in it’s compressed form)
//          Size = PicFrame->picture().size();
//          SrcImage = malloc(Size);
//          if (SrcImage) {
//            memcpy(SrcImage, PicFrame->picture().data(), Size);
//            fwrite(SrcImage, Size, 1, jpegFile);
//            fclose(jpegFile);
//            free(SrcImage);
//            return QUrl::fromLocalFile(url.fileName() + ".jpg")
//                .toDisplayString();
//          }
//        }
//      }
//    }
//  } else {
//    qDebug() << "id3v2 not present";
//    return "qrc:/Image/album_art.png";
//  }
//  return "qrc:/Image/album_art.png";
//}

//#else
//#endif


// ====================================================================================================

/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "player.h"

#include <QDir>
#include <QFileInfo>
#include <QMediaMetaData>
#include <QMediaPlaylist>
#include <QMediaService>
#include <QObject>
#include <QStandardPaths>
#include <QTime>

#include "playlistmodel.h"

Player::Player(QObject *parent) : QObject(parent) {
    m_player = new QMediaPlayer(this);
    m_playlist = new QMediaPlaylist(this);
    m_player->setPlaylist(m_playlist);
    m_playlistModel = new PlaylistModel(this);

    // Khai báo path của music là folder Music mặc định của OS
    musicDir =
        QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0];

    open(musicDir);
    if (!m_playlist->isEmpty()) {
        m_playlist->setCurrentIndex(0);
    }
}

// Thực hiện xóa ảnh JPG khi thoát ứng dụng
Player::~Player() { clearJpg(); }

void Player::open(QString path) {
    QDir directory(path);
    QFileInfoList musics =
        directory.entryInfoList(QStringList() << "*.mp3", QDir::Files);
    QList<QUrl> urls;
    for (int i = 0; i < musics.length(); i++) {
        urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
    }
    addToPlaylist(urls);
}

void Player::addToPlaylist(const QList<QUrl> &urls) {
    for (auto &url : urls) {
        m_playlist->addMedia(url);

#if defined(Q_OS_WIN)
        // Xoa ky tu "/"
        QString fileName = url.path().toStdString().c_str();
        if (fileName.at(0) == "/") {
            fileName.remove(0, 1);
        }

        // Đoạn code này giúp đọc được các file có tên tiếng việt
        // Nếu không convert -> utf8: chương trình crash khi có file tiếng việt
        TagLib::String str(fileName.toUtf8().constData(), TagLib::String::UTF8);

        TagLib::FileName fname(str.toCWString());
        TagLib::FileRef f(fname, true, TagLib::AudioProperties::Accurate);

        Tag *tag = f.tag();
        Song song(QString::fromWCharArray(tag->title().toCWString()),
                  QString::fromWCharArray(tag->artist().toCWString()),
                  url.toDisplayString(),
                  getAlbumArt(dynamic_cast<TagLib::MPEG::File *>(f.file())));

#elif defined(Q_OS_LINUX)

        //    qDebug() << url.path().toStdString().c_str(); // Print test
    FileRef f(url.path().toStdString().c_str());  // chỉ taplib 1.9

        Tag *tag = f.tag();
        Song song(QString::fromWCharArray(tag->title().toCWString()),
                  QString::fromWCharArray(tag->artist().toCWString()),
                  url.toDisplayString(), getAlbumArt(url));
#endif
        m_playlistModel->addSong(song);
    }
}

QString Player::getTimeInfo(qint64 currentInfo) {
    QString tStr = "00:00";
    currentInfo = currentInfo / 1000;
    qint64 durarion = m_player->duration() / 1000;
    if (currentInfo || durarion) {
        QTime currentTime((currentInfo / 3600) % 60, (currentInfo / 60) % 60,
                          currentInfo % 60, (currentInfo * 1000) % 1000);
        QTime totalTime((durarion / 3600) % 60, (m_player->duration() / 60) % 60,
                        durarion % 60, (m_player->duration() * 1000) % 1000);
        QString format = "mm:ss";
        if (durarion > 3600)
            format = "hh::mm:ss";
        tStr = currentTime.toString(format);
    }
    return tStr;
}

void Player::clearJpg() {
    QDir dir(musicDir);
    dir.setNameFilters(QStringList() << "*.jpg"
                                     << "*.png");
    dir.setFilter(QDir::Files);
    for (const QString &dirFile : dir.entryList()) {
        dir.remove(dirFile);
    }
}

#if defined(Q_OS_WIN)
QString Player::getAlbumArt(MPEG::File *mpegFile) {
    static const char *IdPicture = "APIC";
    TagLib::ID3v2::Tag *id3v2tag = mpegFile->ID3v2Tag();
    TagLib::ID3v2::FrameList Frame;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame;
    void *SrcImage;
    unsigned long Size;
    auto name = mpegFile->name().toString() + ".jpg";

    FILE *jpegFile;
    jpegFile = fopen(name.toCString(), "wb");

    if (id3v2tag) {
        Frame = id3v2tag->frameListMap()[IdPicture];
        if (!Frame.isEmpty()) {
            for (TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin();
                 it != Frame.end(); ++it) {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame *>(*it);
                {
                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size();
                    SrcImage = malloc(Size);
                    if (SrcImage) {
                        memcpy(SrcImage, PicFrame->picture().data(), Size);
                        fwrite(SrcImage, Size, 1, jpegFile);
                        fclose(jpegFile);
                        free(SrcImage);
                        return QUrl::fromLocalFile(name.toCString()).toDisplayString();
                    }
                }
            }
        }
    } else {
        qDebug() << "id3v2 not present";
        fclose(jpegFile);
        return "qrc:/App/Media/Image/album_art.png";
    }
    fclose(jpegFile);
    return "qrc:/App/Media/Image/album_art.png";
}

#elif defined(Q_OS_LINUX)
QString Player::getAlbumArt(QUrl url) {
    static const char *IdPicture = "APIC";
    TagLib::MPEG::File mpegFile(url.path().toStdString().c_str());
    TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
    TagLib::ID3v2::FrameList Frame;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame;
    void *SrcImage;
    unsigned long Size;

    FILE *jpegFile;
    jpegFile =
        fopen(QString(url.fileName() + ".jpg").toStdString().c_str(), "wb");

    if (id3v2tag) {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture];
        if (!Frame.isEmpty()) {
            for (TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin();
                 it != Frame.end(); ++it) {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame *>(*it);
                //  if ( PicFrame->type() ==
                // TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                {
                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size();
                    SrcImage = malloc(Size);
                    if (SrcImage) {
                        memcpy(SrcImage, PicFrame->picture().data(), Size);
                        fwrite(SrcImage, Size, 1, jpegFile);
                        fclose(jpegFile);
                        free(SrcImage);
                        return QUrl::fromLocalFile(url.fileName() + ".jpg")
                            .toDisplayString();
                    }
                }
            }
        }
    } else {
        qDebug() << "id3v2 not present";
        return "qrc:/Image/album_art.png";
    }
    return "qrc:/Image/album_art.png";
}

#else
#endif

