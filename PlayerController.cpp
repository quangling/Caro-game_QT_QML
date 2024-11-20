#include "PlayerController.h"


PlayerController::PlayerController(QObject *parent)
    : QObject{parent}
{
    wins = new int(0);
    draws = new int(0);
    losses = new int(0);
    indexsearch = new int(0);
}

QList<QObject *> PlayerController::getPlayerData() const
{
    return m_playerData;
}

void PlayerController::setPlayerData(const QList<QObject *> &newPlayerData)
{
    if (m_playerData == newPlayerData)
        return;
    m_playerData = newPlayerData;
    emit playerDataChanged();
}

void PlayerController::insert(QString playername, int wins, int draws, int losses)
{
    m_playerData.append(new Player(playername, wins, draws, losses));
}

bool PlayerController::checkPlayerExist(QString playername)
{
    for(QObject* obj : m_playerData) {
        Player *player = qobject_cast<Player*>(obj);
        if (player->playerName() == playername) {
            *wins = player->wins();
            *draws = player->draws();
            *losses = player->losses();
            m_playerData.removeOne(player);
            return true;
        }
    }
    return false;
}

void PlayerController::loadPlayertoFile()
{
    QList<Player*> tmp = FileManager::loadPlayerInfor();
    for(Player *obj : tmp) {
        // Player* player = qobject_cast<Player*>(obj);
        m_playerData.append(obj);
    }
}

void PlayerController::savePlayertoFile()
{
    FileManager::savePlayerInfor(m_playerData);
}

Player *PlayerController::searchPlayer(QString name)
{
    int n = m_playerData.size();
    for (int i = 0; i < n - 1; i++) {
        Player *player = qobject_cast<Player*>(m_playerData[i]);
        if (player && player->playerName() == name) {
            *indexsearch = i;
            return player;
        }
    }
    *indexsearch = 0;
    return nullptr;
}

QList<Player *> PlayerController::searchPlayerSameLevel()
{
    QList<Player*> players;
    if(*indexsearch > 2){
        players.append(qobject_cast<Player*>(m_playerData[*indexsearch-1]));
        players.append(qobject_cast<Player*>(m_playerData[*indexsearch-2]));
    }

    if(*indexsearch < m_playerData.size()-2){
        players.append(qobject_cast<Player*>(m_playerData[*indexsearch+1]));
        players.append(qobject_cast<Player*>(m_playerData[*indexsearch+2]));
    }

    return players;
}

void PlayerController::bubleSort()
{
    int n = m_playerData.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            Player *playerA = qobject_cast<Player*>(m_playerData[j]);
            Player *playerB = qobject_cast<Player*>(m_playerData[j+1]);

            if (playerA && playerB && (playerA->wins()*3+playerA->draws()) < (playerB->wins()*3+playerB->draws())) {
                QObject* temp = m_playerData[j];
                m_playerData[j] = m_playerData[j + 1];
                m_playerData[j + 1] = temp;
            }
        }
    }
}

int PlayerController::getWin()
{
    return *wins;
}

int PlayerController::getDraw()
{
    return *draws;
}

int PlayerController::getLosses()
{
    return *losses;
}

bool PlayerController::compareScore(const Player &a, const Player &b)
{
    return (a.wins()*3+a.draws()) > (b.wins()*3+b.draws());
}
