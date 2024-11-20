#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include "BoardController.h"
#include "PlayerController.h"
#include "BotMode.h"

class GameController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(BoardController* boardController READ getBoardController WRITE setBoardController NOTIFY boardControllerChanged FINAL)
    Q_PROPERTY(PlayerController* playerController READ getPlayerController WRITE setPlayerController NOTIFY playerControllerChanged FINAL)
    Q_PROPERTY(BotMode* botMode READ botMode WRITE setBotMode NOTIFY botModeChanged FINAL)
public:
    explicit GameController(QObject* parent = nullptr);
    BoardController *getBoardController() const;
    void setBoardController(BoardController *newBoardController);
    PlayerController *getPlayerController() const;
    void setPlayerController(PlayerController *newPlayerController);
    BotMode *botMode() const;
    void setBotMode(BotMode *newBotMode);

    Q_INVOKABLE void resetBoardData();
    Q_INVOKABLE void updateBoardData(int position, int player);
    Q_INVOKABLE bool checkWin(int position, int player);

    Q_INVOKABLE bool checkPlayerExist(QString playername);
    Q_INVOKABLE void insertPlayer(QString playername, int wins, int draws, int losses);
    void loadPlayertoFile();
    void bubleSort();
    Q_INVOKABLE void savePlayertoFile();
    Q_INVOKABLE int easyBot(int bot, int person, int position);
    Q_INVOKABLE int normalBot(int bot, int person);
    Q_INVOKABLE int hardBot(int bot, int person);
    Q_INVOKABLE QList<QObject*> getPlayerData();

    Q_INVOKABLE Player* searchPlayer(QString name);
    Q_INVOKABLE QList<Player*> searchPlayerSameLevel();

public slots:
    QVector<int> winArray();
    int getWins();
    int getDraws();
    int getLosses();

signals:
    void boardControllerChanged();
    void playerControllerChanged();

    void botModeChanged();

private:
    BoardController *m_boardController = nullptr;
    PlayerController *m_playerController = nullptr;
    BotMode *m_botMode = nullptr;
};

#endif // GAMECONTROLLER_H
