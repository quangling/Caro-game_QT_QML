#include "Board.h"

Board::Board(QObject *parent)
    : QObject{parent}, m_board(SIZE*SIZE, 0)
{

}

QVector<int> Board::getBoard() const
{
    return m_board;
}

void Board::setBoard(const QVector<int> &newBoard)
{
    if (m_board == newBoard)
        return;
    m_board = newBoard;
    emit boardChanged();
}

int Board::getBoardDataElement(int position)
{
    return m_board[position];
}

void Board::setBoardDataElement(int position, int value)
{
    m_board[position] = value;
}

void Board::resetBoardData()
{
    m_board.fill(0);
}

void Board::resetWinArray()
{
    m_winArray.clear();
}

void Board::appendWinArray(int value)
{
    m_winArray.append(value);
}

QVector<int> Board::getWinArray() const
{
    return m_winArray;
}

void Board::setWinArray(const QVector<int> &newWinArray)
{
    if (m_winArray == newWinArray)
        return;
    m_winArray = newWinArray;
    emit winArrayChanged();
}
