#ifndef PLAYERCONTROLLER_H
#define PLAYERCONTROLLER_H

#include <QObject>
#include "Player.h"
#include "FileManager.h"

class PlayerController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> playerData READ getPlayerData WRITE setPlayerData NOTIFY playerDataChanged FINAL)
public:
    explicit PlayerController(QObject *parent = nullptr);

    QList<QObject *> getPlayerData() const;
    void setPlayerData(const QList<QObject *> &newPlayerData);

    void insert(QString playername, int wins, int draws, int losses);
    bool checkPlayerExist(QString playername);
    void loadPlayertoFile();
    void savePlayertoFile();
    Player* searchPlayer(QString name);
    QList<Player*> searchPlayerSameLevel();
    void bubleSort();
    int getWin();
    int getDraw();
    int getLosses();

signals:
    void playerDataChanged();
private:
    QList<QObject *> m_playerData;
    int* wins;
    int* draws;
    int* losses;
    int* indexsearch;

    bool compareScore(const Player &a, const Player &b);
};

#endif // PLAYERCONTROLLER_H
