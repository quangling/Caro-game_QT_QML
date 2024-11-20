#ifndef BOTMODE_H
#define BOTMODE_H

#include <QObject>
#include "Board.h"

const long scoreArray1[7] = {0, 3, 24, 192, 1536, 12288, 12288};
const long scoreArray2[7] = {0, 1, 9, 81, 729, 6561, 6561};

const  long Defend_Score1[6] = { 0, 8, 512, 32768, 2097152, 134217728 };
const  long Attack_Score1[6] = { 0, 64, 4096, 262144, 16777216, 1073741824 };

class BotMode : public QObject
{
    Q_OBJECT
public:
    explicit BotMode(QObject *parent = nullptr);
    // positon là vị trí người chơi vừa đánh
    int easyBot(Board* board, int bot, int person, int position);
    // Tập trung phòng ngự hơn
    int normalBot(Board* board, int bot, int person);
    // Tập trung tấn công hơn
    int hardBot(Board* board, int bot, int person);

signals:

private:
    int checkCanWin(Board *board, int row, int col, int player, int rowDir, int colDir);
    long AttackDirection(Board *board, int bot, int person, int position, int rowDir, int colDir, const long defendScore[], const long attackScore[]);
    long DefendDirection(Board *board, int bot, int person, int position, int rowDir, int colDir, const long defendScore[], const long attackScore[]);
};

#endif // BOTMODE_H
