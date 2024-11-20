import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    id: rect_Game
    anchors.centerIn: parent
    width:1200
    height:600
    property int boardSize: 10
    property int currentPlayer: 1
    property bool botTurn: false
    property string namePlayer1: "Player 1"
    property string namePlayer2: "Player 2"
    property int wins1: 0
    property int draws1: 0
    property int losses1: 0
    property int wins2: 0
    property int draws2: 0
    property int losses2: 0
    property string winner: ""
    property string bot: ""
    property int index: 0

    Connections {
        target: Qt.application

        onAboutToQuit: {
            CaroGame.insertPlayer(namePlayer1, wins1, draws1, losses1)
            if (bot == ""){
                CaroGame.insertPlayer(namePlayer2, wins2, draws2, losses2)
            }
            CaroGame.savePlayertoFile()
        }
    }

    ListModel {
        id: isSkateboardhistory
    }

    ListModel {
        id: boardModel
        Component.onCompleted: {
            resetModel()
        }
        function resetModel() {
            clear()
            for (var i = 0; i < boardSize * boardSize; i++) {
                append({index: i, player: 0, isWinning: false})
            }
        }
    }
    Row {
        Rectangle {
            id: rect_scoreBoard1
            width:350
            height: rect_Game.height-200

            Column {
                width: parent.width
                anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    id: txt_PlayerName1
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: namePlayer1
                    color: "blue"
                    font.bold: true
                    font.pixelSize: 40
                }

                Text{
                    id: text_PlayerWin1
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Wins: " + wins1
                    color: "black"
                    font.bold: true
                    font.pixelSize: 30
                }

                Text{
                    id: text_PlayerDraw1
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Draws: " + draws1
                    color: "black"
                    font.bold: true
                    font.pixelSize: 30
                }

                Text{
                    id: text_PlayerLose1
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Losses: " + losses1
                    color: "black"
                    font.bold: true
                    font.pixelSize: 30
                }
            }
        }

        Rectangle {
            id: rect_boardGame
            width:500
            height: rect_Game.height
            anchors.left: rect_scoreBoard1.right

            GridView {
                id: gridview_board
                width: parent.width
                height:parent.height-200
                cellWidth: width/10
                cellHeight: height/10
                interactive: false

                model: boardModel
                delegate: Rectangle {
                    width: gridview_board.cellWidth
                    height: gridview_board.cellHeight
                    border.color: "black"
                    color: isWinning ? "yellow" : "white"

                    Text {
                        id: txt_XO
                        anchors.centerIn: parent
                        text: model.player === 1 ? "X" : (model.player === 2 ? "O" : "")
                        font.pixelSize: 20
                        font.family: "Ubuntu"
                        font.bold: true
                        color: model.player === 1 ? "blue" : (model.player === 2 ? "red" : "")
                    }

                    MouseArea {
                        id: cick_turn
                        anchors.fill: parent
                        onClicked: {
                            if (bot == ""){
                                if (model.player === 0) {
                                    boardModel.set(model.index, {index: model.index, player:currentPlayer})
                                    var positonPlayer = model.index
                                    isSkateboardhistory.append({position: model.index, player: currentPlayer});
                                    CaroGame.updateBoardData(positonPlayer, currentPlayer);
                                    if (CaroGame.checkWin(positonPlayer, currentPlayer)) {
                                        if (currentPlayer == 1) {
                                            wins1 +=1
                                            losses2+=1
                                        }
                                        if (currentPlayer == 2) {
                                            wins2 +=1
                                            losses1 +=1
                                        }
                                        var cellWinning = CaroGame.winArray()
                                        boardModel.set(cellWinning[0], {isWinning:true})
                                        boardModel.set(cellWinning[1], {isWinning:true})
                                        boardModel.set(cellWinning[2], {isWinning:true})
                                        boardModel.set(cellWinning[3], {isWinning:true})
                                        winner = currentPlayer == 1 ? namePlayer1 : namePlayer2
                                        // stopTimer.start()
                                        popupPlayerWin.open()
                                    }
                                    currentPlayer = currentPlayer == 1 ? 2:1
                                }
                            }

                            else {
                                if (model.player === 0) {
                                    boardModel.set(model.index, {index: model.index, player:currentPlayer})
                                    positonPlayer = model.index
                                    isSkateboardhistory.append({position: model.index, player: currentPlayer});
                                    CaroGame.updateBoardData(positonPlayer, currentPlayer);
                                    if (CaroGame.checkWin(positonPlayer, currentPlayer)) {
                                        if (currentPlayer == 1) {
                                            wins1 +=1
                                            losses2+=1
                                        }
                                        if (currentPlayer == 2) {
                                            wins2 +=1
                                            losses1 +=1
                                        }
                                        cellWinning = CaroGame.winArray()
                                        boardModel.set(cellWinning[0], {isWinning:true})
                                        boardModel.set(cellWinning[1], {isWinning:true})
                                        boardModel.set(cellWinning[2], {isWinning:true})
                                        boardModel.set(cellWinning[3], {isWinning:true})
                                        winner = currentPlayer == 1 ? namePlayer1 : namePlayer2
                                        // stopTimer.start()
                                        popupPlayerWin.open()

                                    }
                                    // bot play
                                    currentPlayer = currentPlayer == 1 ? 2:1
                                    if (bot === "Easy Bot" && !CaroGame.checkWin(positonPlayer, currentPlayer)){
                                        var botMove = CaroGame.easyBot(2, 1, positonPlayer)
                                        CaroGame.updateBoardData(botMove, currentPlayer);
                                        console.log("bot move: " + botMove)
                                        boardModel.set(botMove, {index: botMove, player:currentPlayer})
                                    }
                                    if (bot === "Normal Bot" && !CaroGame.checkWin(positonPlayer, currentPlayer))
                                    {
                                        botMove = CaroGame.normalBot(2, 1)
                                        CaroGame.updateBoardData(botMove, currentPlayer);
                                        console.log("bot move: " + botMove)
                                        boardModel.set(botMove, {index: botMove, player:currentPlayer})
                                    }

                                    if (bot === "Hard Bot" && !CaroGame.checkWin(positonPlayer, currentPlayer))
                                    {
                                        botMove = CaroGame.hardBot(2, 1)
                                        CaroGame.updateBoardData(botMove, currentPlayer);
                                        console.log("bot move: " + botMove)
                                        boardModel.set(botMove, {index: botMove, player:currentPlayer})
                                    }

                                    isSkateboardhistory.append({position: botMove, player: currentPlayer});
                                    if (CaroGame.checkWin(botMove, currentPlayer)) {
                                        if (currentPlayer == 1) {
                                            wins1 +=1
                                            losses2+=1
                                        }
                                        if (currentPlayer == 2) {
                                            wins2 +=1
                                            losses1 +=1
                                        }
                                        cellWinning = CaroGame.winArray()
                                        boardModel.set(cellWinning[0], {isWinning:true})
                                        boardModel.set(cellWinning[1], {isWinning:true})
                                        boardModel.set(cellWinning[2], {isWinning:true})
                                        boardModel.set(cellWinning[3], {isWinning:true})
                                        winner = currentPlayer == 1 ? namePlayer1 : namePlayer2
                                        // stopTimer.start()
                                        popupPlayerWin.open()
                                    }
                                    currentPlayer = currentPlayer == 1 ? 2:1
                                }

                            }
                        }
                    }
                }

            }

            Timer {
                id: stopTimer
                interval: 5000 // 3 giây
                running: false
                repeat: false
                onTriggered:  {
                    messageDialog.open()
                }
            }

            MessageDialog {
                id: messageDialog
                text: "Player " + winner + " is winner"
                informativeText: "Do you want to continue playing"
                buttons: MessageDialog.Ok | MessageDialog.Cancel
                onButtonClicked: function (button, role) {
                    switch (button) {
                    case MessageDialog.Ok:
                        boardModel.resetModel()
                        CaroGame.resetBoardData()
                        break;
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: gridview_board.bottom
                anchors.topMargin: 50
                spacing: 45
                Button {
                   width: 100
                   height: 50
                   text: "Concede"
                   onClicked: {
                       winner = currentPlayer == 1 ? namePlayer2 : namePlayer1
                       if (currentPlayer == 1){
                           wins2 +=1
                           losses1+=1
                           popupPlayerWin.open()
                       }
                       if (currentPlayer == 2){
                           wins1 +=1
                           losses2+=1
                           popupPlayerWin.open()
                       }
                   }
                }

                Button {
                   width: 100
                   height: 50
                   text: "Undo"
                   onClicked: {
                       if (bot == ""){
                           boardModel.set(isSkateboardhistory.get(isSkateboardhistory.count-1).position, {player: 0})
                           CaroGame.updateBoardData(isSkateboardhistory.get(isSkateboardhistory.count-1).position, 0);
                           console.log(isSkateboardhistory.get(isSkateboardhistory.count-1).position)
                           isSkateboardhistory.remove(isSkateboardhistory.count-1)
                           currentPlayer = currentPlayer == 1 ? 2:1
                       }
                       else {
                           boardModel.set(isSkateboardhistory.get(isSkateboardhistory.count-1).position, {player: 0})
                           CaroGame.updateBoardData(isSkateboardhistory.get(isSkateboardhistory.count-1).position, 0);
                           console.log(isSkateboardhistory.get(isSkateboardhistory.count-1).position)
                           isSkateboardhistory.remove(isSkateboardhistory.count-1)
                           // currentPlayer = currentPlayer == 1 ? 2:1
                           boardModel.set(isSkateboardhistory.get(isSkateboardhistory.count-1).position, {player: 0})
                           CaroGame.updateBoardData(isSkateboardhistory.get(isSkateboardhistory.count-1).position, 0);
                           console.log(isSkateboardhistory.get(isSkateboardhistory.count-1).position)
                           isSkateboardhistory.remove(isSkateboardhistory.count-1)
                           // currentPlayer = currentPlayer == 1 ? 2:1
                       }
                   }
                }

                Button {
                   width: 100
                   height: 50
                   text: "New Game"
                   onClicked: {
                       gridview_board.enabled = true
                       CaroGame.resetBoardData()
                       boardModel.resetModel()
                       isSkateboardhistory.clear()
                   }
                }

                Button {
                   width: 100
                   height: 50
                   text: "Quit Match"
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

        Rectangle {
            id: rect_scoreBoard2
            width:350
            height: rect_Game.height - 200
            anchors.left: rect_boardGame.right

            Column {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    id: txt_PlayerName2
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: namePlayer2
                    color: "red"
                    font.bold: true
                    font.pixelSize: 40
                }

                Text{
                    id: text_PlayerWin2
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Wins: " + wins2
                    color: "black"
                    font.bold: true
                    font.pixelSize: 30
                }

                Text{
                    id: text_PlayerDraw2
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Draws: " + draws2
                    color: "black"
                    font.bold: true
                    font.pixelSize: 30
                }

                Text{
                    id: text_PlayerLose2
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Losses: " + losses2
                    color: "black"
                    font.bold: true
                    font.pixelSize: 30
                }
            }
        }
    }

    PlayerWinPopUp {
        id: popupPlayerWin
    }
}
