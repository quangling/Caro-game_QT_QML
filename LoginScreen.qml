import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    id: rootItm_Login
    anchors.centerIn: parent
    width:1000
    height:600

    property bool hideElement: false
    property string mode_bot: ""
    signal namePlayer_bot(string Player1, int wins1, int draws1, int losses1, string mode)
    // signal namePlayer_Player(string Player1, string Player2)
    signal playerInfo(string Player1, int win1, int draw1, int loss1, string Player2, int win2, int draw2, int loss2)
    // signal playerInfo2(string Player2, int wins2, int draws2, int losses2)
    property int win1: 0
    property int draw1: 0
    property int loss1: 0
    property int win2: 0
    property int draw2: 0
    property int loss2: 0

    Button {
        id: btn_returnMenu
        text: qsTr("Home")
        font.pixelSize: 15
        font.bold: true
        anchors.top: parent.top
        anchors.left: parent.left

        contentItem: Text {
            text: btn_returnMenu.text
            font: btn_returnMenu.font
            opacity: enabled ? 1.0 : 0.3
            color: btn_returnMenu.down ? "#1C1C1C" : "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 30
            opacity: enabled ? 1 : 0.5
            color: btn_returnMenu.down ? "#1E90FF" : "#1E90FF"
            border.width: 1
            radius: 10
        }

        onClicked: {
            loader.source = "Menu.qml"
        }
    }
    Rectangle{
        anchors.centerIn: parent
        // Text {
        //     id: txt_titleLogin
        //     text: "Game XO"
        //     font.pixelSize: 50
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     anchors.bottom: row_player1.top
        //     anchors.bottomMargin: 50
        // }
        Text{
            id: txt_titleLogin
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Tic Toc Toe"
            font.family: "Comic Sans MS"
            anchors.bottom: row_player1.top
            font.pixelSize: 50
            anchors.bottomMargin: 50
        }
        Row {
            id: row_player1
            height: 50
            width: rootItm_Login.width/2
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: txt_player1
                text: qsTr("First Player:")
                font.family: "Ubuntu"
                font.pixelSize: 30
                color: "Black"
                rightPadding: 60
            }

            Rectangle {
                id: rect_inputPlayer1
                width: 300
                height: parent.height-10
                border.width: 2
                border.color: "black"
                radius: 3
                anchors.rightMargin: 20
                TextInput {
                    id: txtinput_player1
                    height: parent.height
                    anchors.fill: parent
                    font.pixelSize: 30
                    cursorVisible: true
                    text: ""
                    leftPadding: 4
                    clip: true
                }
            }
        }
        Row {
            id: row_player2
            height: 50
            width: rootItm_Login.width/2
            anchors.top: row_player1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !hideElement
            Text {
                id: txt_player2
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Second Player:")
                font.family: "Ubuntu"
                font.pixelSize: 30
                color: "Black"
                rightPadding: 20
            }

            Rectangle {
                id: rect_inputPlayer2
                width: 300
                height: parent.height-10
                border.width: 2
                border.color: "black"
                radius: 3
                anchors.rightMargin: 20

                TextInput {
                    id: txtinput_player2
                    height: parent.height
                    anchors.fill: parent
                    font.pixelSize: 30
                    cursorVisible: true
                    text: ""
                    leftPadding: 4
                    clip: true
                }
            }
        }

        Button {
            id: btn_submitLogin
            text: qsTr("Submit")
            font.pixelSize: 32
            font.bold: true
            anchors.top: row_player2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30

            contentItem: Text {
                text: btn_submitLogin.text
                font: btn_submitLogin.font
                opacity: enabled ? 1.0 : 0.3
                color: btn_submitLogin.down ? "#1C1C1C" : "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                opacity: enabled ? 1 : 0.5
                color: btn_submitLogin.down ? "#1E90FF" : "#1E90FF"
                border.width: 1
                radius: 2
            }

            onClicked: {
                if (row_player2.visible === false) {
                    if (txtinput_player1.text === "") {
                        console.log("invalid")
                        invalidText.text = "Invalid Iput"
                        invalidAni.start()
                    }
                    else {
                        if(CaroGame.checkPlayerExist(txtinput_player1.text)) {
                            win1 = CaroGame.getWins()
                            draw1 = CaroGame.getDraws()
                            loss1 = CaroGame.getLosses()
                            invalidText.text = "Account existed"
                            invalidAni.start()
                            invalidTimer.start()
                        }
                        else {
                            invalidText.text = "Account doesn't exist. Created account"
                            invalidAni.start()
                            invalidTimer.start()
                        }

                    }
                }
                else {
                    if (txtinput_player1.text === "" || txtinput_player2.text === ""){
                        console.log("invalid")
                        invalidText.text = "Invalid Iput"
                        invalidAni.start()
                    }
                    else {
                        var text = ""
                        if(CaroGame.checkPlayerExist(txtinput_player1.text)) {
                            win1 = CaroGame.getWins()
                            draw1 = CaroGame.getDraws()
                            loss1 = CaroGame.getLosses()
                            text = "Account 1 existed"
                        }
                        else {
                            text = "Account 1 doesn't exist. Created account"
                            win1 =0; draw1 = 0; loss1 =0;
                        }
                        if (CaroGame.checkPlayerExist(txtinput_player2.text)) {
                            win2 = CaroGame.getWins()
                            draw2 = CaroGame.getDraws()
                            loss2 = CaroGame.getLosses()
                            text += "\nAccount 2 existed"
                        }
                        else {
                            text += "\nAccount 2 doesn't exist. Created account"
                            win2 =0; draw2 = 0; loss2 =0;
                        }
                        invalidText.text = text
                        invalidAni.start()
                        invalidTimer.start()

                    }
                }

            }
        }

        Rectangle {
            id: invalidRect
            width: rootRect.width/2 - 100
            height: 50
            anchors.horizontalCenter: btn_submitLogin.horizontalCenter
            anchors.top: btn_submitLogin.bottom
            anchors.topMargin: 20
            radius: 3
            opacity: 0
            Text {
                id: invalidText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "Invalid Input"
                font.bold: true
                color: "brown"

            }
        }
        Timer {
            id: invalidTimer
            interval: 200
            running: false
            repeat: false
            onTriggered: {
                if (row_player2.visible === false){
                    rootItm_Login.namePlayer_bot(txtinput_player1.text, win1, draw1, loss1, mode_bot)
                }
                else {
                    rootItm_Login.playerInfo(txtinput_player1.text, win1, draw1, loss1, txtinput_player2.text, win2, draw2, loss2)
                }
            }
        }

        SequentialAnimation {
            id: invalidAni
            PropertyAnimation {
                target: invalidRect
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }

            PauseAnimation {
                duration: 3000  // 3 giây
            }

            PropertyAnimation {
                target: invalidRect
                property: "opacity"
                from: 1
                to: 0
                duration: 500
            }
        }
    }
}
