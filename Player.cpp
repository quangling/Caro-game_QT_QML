#include "Player.h"

Player::Player(QObject *parent)
    : QObject{parent}
{}

Player::Player(QString playerName, int wins, int draws, int losses)
{
    m_playerName = playerName;
    m_wins = wins;
    m_draws = draws;
    m_losses = losses;
}

QString Player::playerName() const
{
    return m_playerName;
}

void Player::setPlayerName(const QString &newPlayerName)
{
    if (m_playerName == newPlayerName)
        return;
    m_playerName = newPlayerName;
    emit playerNameChanged();
}

int Player::wins() const
{
    return m_wins;
}

void Player::setWins(int newWins)
{
    if (m_wins == newWins)
        return;
    m_wins = newWins;
    emit winsChanged();
}

int Player::draws() const
{
    return m_draws;
}

void Player::setDraws(int newDraws)
{
    if (m_draws == newDraws)
        return;
    m_draws = newDraws;
    emit drawsChanged();
}

int Player::losses() const
{
    return m_losses;
}

void Player::setLosses(int newLosses)
{
    if (m_losses == newLosses)
        return;
    m_losses = newLosses;
    emit lossesChanged();
}
