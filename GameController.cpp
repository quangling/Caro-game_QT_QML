#include "GameController.h"

GameController::GameController(QObject *parent)
    :QObject{parent}
{
    m_boardController = new BoardController();
    m_playerController = new PlayerController();
    loadPlayertoFile();

}

BoardController *GameController::getBoardController() const
{
    return m_boardController;
}

void GameController::setBoardController(BoardController *newBoardController)
{
    if (m_boardController == newBoardController)
        return;
    m_boardController = newBoardController;
    emit boardControllerChanged();
}

void GameController::resetBoardData()
{
    m_boardController->resetBoardData();
}

void GameController::updateBoardData(int position, int player)
{
    m_boardController->updateBoardData(position, player);
}

bool GameController::checkWin(int position, int player)
{
    return m_boardController->checkWin(position, player);
}

bool GameController::checkPlayerExist(QString playername)
{
    return m_playerController->checkPlayerExist(playername);
}

void GameController::insertPlayer(QString playername, int wins, int draws, int losses)
{
    m_playerController->insert(playername, wins, draws, losses);
}

void GameController::loadPlayertoFile()
{
    m_playerController->loadPlayertoFile();
}

void GameController::bubleSort()
{
    m_playerController->bubleSort();
}

void GameController::savePlayertoFile()
{
    m_playerController->savePlayertoFile();
}

int GameController::easyBot(int bot, int person, int position)
{
    int result = m_botMode->easyBot(m_boardController->getBoardData(), bot, person, position);
    updateBoardData(result, bot);
    return result;
}

int GameController::normalBot(int bot, int person)
{
    int result = m_botMode->normalBot(m_boardController->getBoardData(), bot, person);
    updateBoardData(result, bot);
    return result;
}

int GameController::hardBot(int bot, int person)
{
    int result = m_botMode->hardBot(m_boardController->getBoardData(), bot, person);
    updateBoardData(result, bot);
    return result;
}

QList<QObject *> GameController::getPlayerData()
{
    return m_playerController->getPlayerData();
}

Player *GameController::searchPlayer(QString name)
{
    bubleSort();
    return m_playerController->searchPlayer(name);
}

QList<Player *> GameController::searchPlayerSameLevel()
{
    return m_playerController->searchPlayerSameLevel();
}

QVector<int> GameController::winArray()
{
    return m_boardController->getWinArray();
}

int GameController::getWins()
{
    return m_playerController->getWin();
}

int GameController::getDraws()
{
    return m_playerController->getDraw();
}

int GameController::getLosses()
{
    return m_playerController->getLosses();
}

PlayerController *GameController::getPlayerController() const
{
    return m_playerController;
}

void GameController::setPlayerController(PlayerController *newPlayerController)
{
    if (m_playerController == newPlayerController)
        return;
    m_playerController = newPlayerController;
    emit playerControllerChanged();
}

BotMode *GameController::botMode() const
{
    return m_botMode;
}

void GameController::setBotMode(BotMode *newBotMode)
{
    if (m_botMode == newBotMode)
        return;
    m_botMode = newBotMode;
    emit botModeChanged();
}
