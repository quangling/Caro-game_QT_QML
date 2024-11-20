#include "BotMode.h"

BotMode::BotMode(QObject *parent)
    : QObject{parent}
{}

int BotMode::easyBot(Board *board, int bot, int person, int position)
{
    int result;
    int check = true;
    // int score = 0;
    for (int i = 0; i<SIZE*SIZE; i++) {
        int row = i/SIZE;
        int col = i%SIZE;

        //check bot win
        if (checkCanWin(board, row, col, bot, 1, 0) == 3) {
            if (col >= 1 && board->getBoardDataElement(row*SIZE+col-1) == 0) {
                return row*SIZE+col-1;
            }
            if (col < SIZE -3 && board->getBoardDataElement(row*SIZE+col+3) == 0) {
                return row*SIZE+col+3;
            }
        }

        if(checkCanWin(board, row, col, bot, 0, 1) == 3) {
            if (row >= 1 && board->getBoardDataElement((row-1)*SIZE+col) == 0) {
                return (row-1)*SIZE+col;
            }
            if (row < SIZE-3 && board->getBoardDataElement((row+3)*SIZE+col) == 0) {
                return (row+3)*SIZE+col;
            }
        }

        if(checkCanWin(board, row, col, bot, 1, 1) == 3) {
            if (row >= 1 && col >= 1 && board->getBoardDataElement((row-1)*SIZE+(col-1)) == 0) {
                return (row-1)*SIZE+(col-1);
            }
            if (row < SIZE-3 && col < SIZE-3 && board->getBoardDataElement((row+3)*SIZE+(col+3))==0) {
                return (row+3)*SIZE+(col+3);
            }
        }

        if(checkCanWin(board, row, col , bot, -1, 1) == 3) {
            if (row >=1 && col < SIZE-1 && board->getBoardDataElement((row-1)*SIZE+(col+1)) == 0) {
                return (row-1)*SIZE+(col+1);
            }
            if (row < SIZE-3 && col >=3 && board->getBoardDataElement((row+3)*SIZE+(col-3)) == 0) {
                return (row+3)*SIZE+(col-3);
            }
        }

        // check person win
        if (checkCanWin(board, row, col, person, 1, 0) == 3) {
            if (col >= 1 && board->getBoardDataElement(row*SIZE+col-1) == 0) {
                return row*SIZE+col-1;
            }
            if (col < SIZE -3 && board->getBoardDataElement(row*SIZE+col+3) == 0) {
                return row*SIZE+col+3;
            }
        }

        if(checkCanWin(board, row, col, person, 0, 1) == 3) {
            if (row >= 1 && board->getBoardDataElement((row-1)*SIZE+col) == 0) {
                return (row-1)*SIZE+col;
            }
            if (row < SIZE-3 && board->getBoardDataElement((row+3)*SIZE+col) == 0) {
                return (row+3)*SIZE+col;
            }
        }

        if(checkCanWin(board, row, col, person, 1, 1) == 3) {
            if (row >= 1 && col >= 1 && board->getBoardDataElement((row-1)*SIZE+(col-1)) == 0) {
                return (row-1)*SIZE+(col-1);
            }
            if (row < SIZE-3 && col < SIZE-3 && board->getBoardDataElement((row+3)*SIZE+(col+3))==0) {
                return (row+3)*SIZE+(col+3);
            }
        }

        if(checkCanWin(board, row, col , person, -1, 1) == 3) {
            if (row >=1 && col < SIZE-1 && board->getBoardDataElement((row-1)*SIZE+(col+1)) == 0) {
                return (row-1)*SIZE+(col+1);
            }
            if (row < SIZE-3 && col >=3 && board->getBoardDataElement((row+3)*SIZE+(col-3)) == 0) {
                return (row+3)*SIZE+(col-3);
            }
        }
        // Check person can win
        if (checkCanWin(board, row, col, person, 1, 0) == 2) {
            if (col >= 1 && board->getBoardDataElement(row*SIZE+col-1) == 0) {
                result = row*SIZE+col-1;
                check = false;
            }
            if (col < SIZE -2 && board->getBoardDataElement(row*SIZE+col+2) == 0) {
                result = row*SIZE+col+2;
                check = false;
            }
        }

        if(checkCanWin(board, row, col, person, 0, 1) == 2) {
            if (row >= 1 && board->getBoardDataElement((row-1)*SIZE+col) == 0) {
                result = (row-1)*SIZE+col;
                check = false;
            }
            if (row < SIZE-2 && board->getBoardDataElement((row+2)*SIZE+col) == 0) {
                result = (row+2)*SIZE+col;
                check = false;
            }
        }

        if(checkCanWin(board, row, col, person, 1, 1) == 2) {
            if (row >= 1 && col >= 1 && board->getBoardDataElement((row-1)*SIZE+(col-1)) == 0) {
                result = (row-1)*SIZE+(col-1);
                check = false;
            }
            if (row < SIZE-2 && col < SIZE-2 && board->getBoardDataElement((row+2)*SIZE+(col+2))==0) {
                result = (row+2)*SIZE+(col+2);
                check = false;
            }
        }

        if(checkCanWin(board, row, col , person, -1, 1) == 2) {
            if (row >=1 && col < SIZE-1 && board->getBoardDataElement((row-1)*SIZE+(col+2)) == 0) {
                result = (row-1)*SIZE+(col+2);
                check = false;
            }
            if (row < SIZE-2 && col >=2 && board->getBoardDataElement((row+2)*SIZE+(col-2)) == 0) {
                result = (row+2)*SIZE+(col-2);
                check = false;
            }
        }

    }

    int rowPlayer = position/SIZE;
    int colPlayer = position%SIZE;
    if (check) {
        while(true) {
            srand(time(0));
            QVector<int> botPositionRow = {rowPlayer+1, rowPlayer, rowPlayer-1};
            QVector<int> botPositionCol = {colPlayer+1, colPlayer, colPlayer-1};
            int i = rand() % botPositionRow.size();
            int j = rand() % botPositionCol.size();
            if (board->getBoardDataElement(botPositionRow[i]*SIZE+botPositionCol[j]) == 0) {
                result = botPositionRow[i]*SIZE+botPositionCol[j];
                break;
            }
        }
    }
    return result;
}

int BotMode::normalBot(Board *board, int bot, int person)
{
    int row =0; int col = 0;
    long scoreTotal = 0;
    long AttackScore = 0;
    long DefendScore = 0;
    for (int i = 0; i< SIZE; i++) {
        for (int j=0; j<SIZE; j++) {
            if (board->getBoardDataElement(i*SIZE+j) == 0) {
                // Tấn công hàng ngang
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 1, 0, scoreArray1, scoreArray2);
                //Tấn công hàng dọc
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 0, 1, scoreArray1, scoreArray2);
                // Tấn công đường chéo 1
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 1, 1, scoreArray1, scoreArray2);
                 // Tấn công đường chéo 2
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 1, -1, scoreArray1, scoreArray2);
                // Phòng ngự hàng ngang
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 1, 0, scoreArray1, scoreArray2);
                //Phòng ngự hàng dọc
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 0, 1, scoreArray1, scoreArray2);
                // Phòng ngự đường chéo 1
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 1, 1, scoreArray1, scoreArray2);
                // Phòng ngự đường chéo 2
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 1, -1, scoreArray1, scoreArray2);

                if (AttackScore > DefendScore) {
                    if (scoreTotal < AttackScore) {
                        scoreTotal = AttackScore;
                        row = i;
                        col = j;
                    }
                }
                else {
                    if (scoreTotal < DefendScore) {
                        scoreTotal = DefendScore;
                        row =i;
                        col =j;
                    }
                }
            }
        }
    }

    return row*SIZE+col;
}

int BotMode::hardBot(Board *board, int bot, int person)
{
    int row =0; int col = 0;
    long scoreTotal = 0;
    long AttackScore = 0;
    long DefendScore = 0;
    for (int i = 0; i< SIZE; i++) {
        for (int j=0; j<SIZE; j++) {
            if (board->getBoardDataElement(i*SIZE+j) == 0) {

                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 1, 0, Defend_Score1, Attack_Score1);
                //Tấn công hàng dọc
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 0, 1, Defend_Score1, Attack_Score1);
                // Tấn công đường chéo 1
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 1, 1, Defend_Score1, Attack_Score1);
                    // Tấn công đường chéo 2
                AttackScore += AttackDirection(board, bot, person, i*SIZE+j, 1, -1, Defend_Score1, Attack_Score1);
                // Phòng ngự hàng ngang
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 1, 0, Defend_Score1, Attack_Score1);
                //Phòng ngự hàng dọc
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 0, 1, Defend_Score1, Attack_Score1);
                // Phòng ngự đường chéo 1
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 1, 1, Defend_Score1, Attack_Score1);
                // Phòng ngự đường chéo 2
                DefendScore += DefendDirection(board, bot, person, i*SIZE+j, 1, -1, Defend_Score1, Attack_Score1);

                if (AttackScore > DefendScore) {
                    if (scoreTotal < AttackScore) {
                        scoreTotal = AttackScore;
                        row = i;
                        col = j;
                    }
                }
                else {
                    if (scoreTotal < DefendScore) {
                        scoreTotal = DefendScore;
                        row =i;
                        col =j;
                    }
                }
            }
        }
    }

    return row*SIZE+col;
}

int BotMode::checkCanWin(Board *board, int row, int col, int player, int rowDir, int colDir)
{
    int count =0;
    for (int i = 0; i<WIN_CONDITION -1; ++i) {
        int r = row + colDir *i;
        int c = col + rowDir *i;
        if (r < 0 || r >= SIZE || c < 0 || c >= SIZE || board->getBoardDataElement(r*SIZE+c) != player)
            break;
        count ++;
    }

    return count;
}

long BotMode::AttackDirection(Board *board, int bot, int person, int position, int rowDir, int colDir, const long defendScore[], const long attackScore[])
{
    long scoreTotal = 0;
    int botChess = 0;
    int personChess = 0;
    int row = position/SIZE;
    int col = position%SIZE;
    for (int i = 1; i < 4 && (row + colDir*i<SIZE) && (col + rowDir*i) <SIZE && (row + colDir*i >= 0) && (col + rowDir*i>=0); i++) {
        if (board->getBoardDataElement((row + colDir*i)*SIZE + col + rowDir*i) == bot) {
            botChess ++;
        }
        else if(board->getBoardDataElement((row + colDir*i)*SIZE + col + rowDir*i) == person) {
            personChess ++;
            break;
        }
        else {
            break;
        }
    }

    for (int i = 1; i < 4 && (row - colDir*i<SIZE) && (col - rowDir*i <SIZE) && (row - colDir*i >= 0) && (col - rowDir*i>=0); i++) {
        if (board->getBoardDataElement((row - colDir*i)*SIZE + col - rowDir*i) == bot) {
            botChess ++;
        }
        else if(board->getBoardDataElement((row - colDir*i)*SIZE + col - rowDir*i) == person) {
            personChess ++;
            break;
        }
        else {
            break;
        }
    }

    if (personChess == 2) {
        return 0;
    }
    scoreTotal += attackScore[botChess];
    scoreTotal += defendScore[personChess];
    return scoreTotal;
}

long BotMode::DefendDirection(Board *board, int bot, int person, int position, int rowDir, int colDir, const long defendScore[], const long attackScore[])
{
    long scoreTotal = 0;
    int botChess = 0;
    int personChess = 0;
    int row = position/SIZE;
    int col = position%SIZE;
    for (int i = 1; i < 4 && (row + colDir*i<SIZE) && (col + rowDir*i <SIZE) && (row + colDir*i>=0) && (col + rowDir*i>=0); i++) {
        if (board->getBoardDataElement((row + colDir*i)*SIZE + col + rowDir*i) == person) {
            personChess ++;
        }
        else if(board->getBoardDataElement((row + colDir*i)*SIZE + col + rowDir*i) == bot) {
            botChess ++;
            break;
        }
        else {
            break;
        }
    }

    for (int i = 1; i < 4 && (row - colDir*i<SIZE) && (col - rowDir*i <SIZE) && (row - colDir*i >=0) && (col - rowDir*i>=0); i++) {
        if (board->getBoardDataElement((row - colDir*i)*SIZE + col - rowDir*i) == person) {
            personChess ++;
        }
        else if(board->getBoardDataElement((row - colDir*i)*SIZE + col - rowDir*i) == bot) {
            botChess ++;
            break;
        }
        else {
            break;
        }
    }

    if (botChess == 2) {
        return 0;
    }

    scoreTotal += defendScore[personChess];
    scoreTotal += attackScore[botChess];
    return scoreTotal;
}
