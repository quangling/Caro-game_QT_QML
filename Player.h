#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>

class Player : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString playerName READ playerName WRITE setPlayerName NOTIFY playerNameChanged FINAL)
    Q_PROPERTY(int wins READ wins WRITE setWins NOTIFY winsChanged FINAL)
    Q_PROPERTY(int draws READ draws WRITE setDraws NOTIFY drawsChanged FINAL)
    Q_PROPERTY(int losses READ losses WRITE setLosses NOTIFY lossesChanged FINAL)
public:
    explicit Player(QObject *parent = nullptr);
    Player(QString playerName, int wins, int draws, int losses);

    QString playerName() const;
    void setPlayerName(const QString &newPlayerName);

    int wins() const;
    void setWins(int newWins);

    int draws() const;
    void setDraws(int newDraws);

    int losses() const;
    void setLosses(int newLosses);

signals:
    void playerNameChanged();
    void winsChanged();

    void drawsChanged();

    void lossesChanged();

private:
    QString m_playerName;
    int m_wins;
    int m_draws;
    int m_losses;
};

#endif // PLAYER_H
