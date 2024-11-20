#ifndef BOARD_H
#define BOARD_H
#include <QObject>
#include <QDebug>

#define SIZE 10
#define WIN_CONDITION 4

class Board : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<int> board READ getBoard WRITE setBoard NOTIFY boardChanged FINAL)
    Q_PROPERTY(QVector<int> winArray READ getWinArray WRITE setWinArray NOTIFY winArrayChanged FINAL)
public:
    explicit Board(QObject *parent = nullptr);
    QVector<int> getBoard() const;
    void setBoard(const QVector<int> &newBoard);

    QVector<int> getWinArray() const;
    void setWinArray(const QVector<int> &newWinArray);

    int getBoardDataElement(int position);
    void setBoardDataElement(int position, int value);
    void resetBoardData();
    void resetWinArray();
    void appendWinArray(int value);

signals:
    void boardChanged();
    void winArrayChanged();

private:
    QVector<int> m_board;
    QVector<int> m_winArray;
};

#endif // BOARD_H
