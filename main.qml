import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1200
    height: 800
    maximumHeight: 800
    minimumHeight: 800
    maximumWidth: 1200
    minimumWidth: 1200
    visible: true
    title: qsTr("Hello World")

    Loader{
        anchors.centerIn: parent
        id: loader
        source: "Menu.qml"
    }

    Connections {
        target: loader.item

        onModeBot: {
            loader.setSource("LoginScreen.qml", {hideElement: hideElement, mode_bot: bot})
        }

        onNamePlayer_bot: {
            loader.setSource("BoardCaro.qml", {namePlayer1: Player1, wins1: wins1,  draws1: draws1,
                                 losses1: losses1 ,namePlayer2: mode ,bot: mode})
        }
        onPlayerInfo: {
            loader.setSource("BoardCaro.qml", {namePlayer1: Player1 ,wins1: win1,  draw1: draw1,
                                 losses1: loss1 , namePlayer2: Player2, wins2: win2,  draws2: draw2,
                                 losses2: loss2 })
        }

        onPlayerInfo1: {
            loader.setSource("BoardCaro.qml", {namePlayer1: Player1, wins1: win1, draws1: draw1, losses1: loss1})
        }

    }
}
