#include "BoardController.h"
#include <QDebug>
BoardController::BoardController(QObject *parent)
    : QObject{parent}
{
    m_boardData = new Board();
}


Board *BoardController::getBoardData() const
{
    return m_boardData;
}

void BoardController::setBoardData(Board *newBoardData)
{
    if (m_boardData == newBoardData)
        return;
    m_boardData = newBoardData;
    emit boardDataChanged();
}

QVector<int> BoardController::getBoard()
{
    return m_boardData->getBoard();
}

void BoardController::resetBoardData()
{
    m_boardData->resetBoardData();
}

void BoardController::updateBoardData(int position, int player)
{
    if (m_boardData->getBoardDataElement(position) == player) {
        return;
    }
    m_boardData->setBoardDataElement(position, player);
}

bool BoardController::checkWin(int position, int player)
{
    int row = position/SIZE;
    int col = position%SIZE;
    if(checkDirection(row, col, player, 1, 0)){
        qDebug() << m_boardData->getWinArray();
        return true;// Hàng ngang
    }
    if(checkDirection(row, col, player, 0, 1)) {
        qDebug() << m_boardData->getWinArray();
        return true;
    }
    if(checkDirection(row, col, player, 1, 1)) {
        qDebug() << m_boardData->getWinArray();
        return true;
    }
    if (checkDirection(row, col, player, 1, -1)) {
        qDebug() << m_boardData->getWinArray();
        return true;
    }
    return false;
}

QVector<int> BoardController::getWinArray()
{
    return m_boardData->getWinArray();
}

bool BoardController::checkDirection(int row, int col, int player, int rowDir, int colDir)
{
    int count = 1;
    m_boardData->resetWinArray();
    m_boardData->appendWinArray(row*SIZE+col);
    // Kiểm tra hướng đầu tiên
    for (int i = 1; i < WIN_CONDITION; ++i)
    {
        int r = row + colDir * i;
        int c = col + rowDir * i;
        if (r < 0 || r >= SIZE || c < 0 || c >= SIZE || m_boardData->getBoardDataElement(r * SIZE + c) != player)
            break;
        m_boardData->appendWinArray(r*SIZE+c);
        count++;
    }

    // Kiểm tra hướng ngược lại
    for (int j = 1; j < WIN_CONDITION; ++j)
    {
        int r = row - colDir * j;
        int c = col - rowDir * j;
        if (r < 0 || r >= SIZE || c < 0 || c >= SIZE || m_boardData->getBoardDataElement(r * SIZE + c) != player)
            break;
        m_boardData->appendWinArray(r*SIZE+c);
        count++;
    }

    return count >= WIN_CONDITION;
}


