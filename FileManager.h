#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>
#include "Player.h"

class FileManager : public QObject
{
    Q_OBJECT
public:
    explicit FileManager(QObject *parent = nullptr);
    static void savePlayerInfor(QList<QObject*> playerData);
    static QList<Player*> loadPlayerInfor();

signals:
};

#endif // FILEMANAGER_H
