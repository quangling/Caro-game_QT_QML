import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls

Popup {
    id: popupWinScreen
    width: 700
    height: 300
    anchors.centerIn: parent
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    Rectangle {
        width: parent.width
        height: parent.height
        color: "lightgray"
        border.color: "black"
        radius: 10
        Rectangle {
            id: txt_playerWin
            width: parent.width/3*2
            height: parent.height/2
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            Text {
                anchors.centerIn: parent
                text: winner + " Win"
                font.bold: true
                font.pixelSize: 50
                opacity: 1
            }
        }

        Row {
            spacing: 100
            anchors.horizontalCenter:txt_playerWin.horizontalCenter
            anchors.top: txt_playerWin.bottom
            Rectangle {
                width: 120
                height: 50
                color: "blue"
                // border.color: "black"
                radius: 10
                Text {
                    anchors.centerIn: parent
                    text: "Replay"
                    font.bold: true
                    font.pixelSize: 20
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        gridview_board.enabled = false
                        popupWinScreen.close()
                        boardModel.resetModel()
                        timer_replay.start()
                    }
                }
            }
            Timer {
                id: timer_replay
                interval: 1000
                running: false
                repeat: isSkateboardhistory.count
                onTriggered: {
                    boardModel.set(isSkateboardhistory.get(index).position, {player: isSkateboardhistory.get(index).player})
                    index +=1
                    if (index === isSkateboardhistory.count){
                        index=0
                    }
                    console.log("test")
                }
            }

            Rectangle {
                width: 120
                height: 50
                color: "blue"
                // border.color: "black"
                radius: 10
                Text {
                    anchors.centerIn: parent
                    text: "New Game"
                    font.bold: true
                    font.pixelSize: 20
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        popupWinScreen.close()
                        CaroGame.resetBoardData()
                        boardModel.resetModel()
                        isSkateboardhistory.clear()
                    }
                }
            }

            Rectangle {
                width: 120
                height: 50
                color: "blue"
                // border.color: "black"
                radius: 10
                Text {
                    anchors.centerIn: parent
                    text: "Quit"
                    font.bold: true
                    font.pixelSize: 20
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        loader.source = "Menu.qml"
                        CaroGame.insertPlayer(namePlayer1, wins1, draws1, losses1)
                        if (bot == ""){
                            CaroGame.insertPlayer(namePlayer2, wins2, draws2, losses2)
                        }
                        CaroGame.savePlayertoFile()
                        CaroGame.resetBoardData()
                    }
                }
            }
        }
    }

}
