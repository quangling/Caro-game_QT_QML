#ifndef BOARDCONTROLLER_H
#define BOARDCONTROLLER_H

#include <QObject>
#include "Board.h"

class BoardController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Board* boardData READ getBoardData WRITE setBoardData NOTIFY boardDataChanged FINAL)
public:
    explicit BoardController(QObject *parent = nullptr);
    Board *getBoardData() const;
    void setBoardData(Board *newBoardData);
    QVector<int> getBoard();
    void resetBoardData();
    void updateBoardData(int position, int player);
    bool checkWin(int position, int player);

    QVector<int> getWinArray();

signals:
    void boardDataChanged();

private:

    Board *m_boardData = nullptr;
    bool checkDirection(int row, int col, int player, int rowDir, int colDir);
};

#endif // BOARDCONTROLLER_H
