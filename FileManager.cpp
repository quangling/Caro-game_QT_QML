#include "FileManager.h"
#include "QFile"
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

FileManager::FileManager(QObject *parent)
    : QObject{parent}
{}

void FileManager::savePlayerInfor(QList<QObject*> playerData)
{
    QJsonArray playerJson;
    for (QObject *obj : playerData){
        Player* player = qobject_cast<Player*>(obj);
        if (player) {
            QJsonObject playerJSObject;
            playerJSObject["name"] = player->playerName();
            playerJSObject["wins"] = player->wins();
            playerJSObject["draws"] = player->draws();
            playerJSObject["losses"] = player->losses();

            playerJson.append(playerJSObject);
         }
    }


    QJsonDocument jsDoc(playerJson);
    QFile file("playerInfo.json");
    if(file.open(QIODevice::WriteOnly)) {
        file.write(jsDoc.toJson());
        qDebug() << "Write to file sucessfully";
        file.close();
    }
    else {
        qDebug() << "Failed to open file to write";
    }
}

QList<Player *> FileManager::loadPlayerInfor()
{
    QList<Player *> playerData;
    QFile file("playerInfo.json");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open file to read";
        return playerData;
    }

    QByteArray allData = file.readAll();
    file.close();

    QJsonDocument jsDoc(QJsonDocument::fromJson(allData));
    if (!jsDoc.isArray()) {
        qWarning() << "Invalid JSON format";
    }

    QJsonArray playerArray = jsDoc.array();
    for (const QJsonValue &value : playerArray) {
        if (value.isObject()) {
            QJsonObject playerJSObject = value.toObject();

            Player *player = new Player();
            player->setPlayerName(playerJSObject["name"].toString());
            player->setWins(playerJSObject["wins"].toInt());
            player->setDraws(playerJSObject["draws"].toInt());
            player->setLosses(playerJSObject["losses"].toInt());

            playerData.append(player);
        }
    }
    return playerData;
}
