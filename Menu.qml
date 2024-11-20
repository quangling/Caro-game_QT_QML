import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls

Item {
    id: rootItm_menu
    anchors.centerIn: parent
    signal modeBot(bool hideElement, string bot)

    Column {
        anchors.centerIn: parent
        spacing: 30
        Text{
            id: txt_titleMenu
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Tic Toc Toe"
            font.family: "Comic Sans MS"
            font.pixelSize: 50
        }

        Button {
            id: btn_playermMode
            text: qsTr("Player vs Player")
            font.pixelSize: 32
            font.bold: true

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30


            contentItem: Text {
                text: btn_playermMode.text
                font: btn_playermMode.font
                opacity: enabled ? 1.0 : 0.3
                color: btn_playermMode.down ? "#1C1C1C" : "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 300
                implicitHeight: 50
                opacity: enabled ? 1 : 0.5
                color: btn_playermMode.down ? "#1E90FF" : "#1E90FF"
                border.width: 1
                radius: 10
            }

            onClicked: {
                loader.source = "LoginScreen.qml"
            }
        }

        Button {

            id: btn_botMode
            text: qsTr("Player vs Bot")
            font.pixelSize: 32
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30
            font.bold: true

            contentItem: Text {
                text: btn_botMode.text
                font: btn_botMode.font
                opacity: enabled ? 1.0 : 0.3
                color: btn_botMode.down ? "#1C1C1C" : "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 300
                implicitHeight: 50
                opacity: enabled ? 1 : 0.5
                color: btn_botMode.down ? "#1E90FF" : "#1E90FF"
                border.width: 1
                radius: 10
            }
            onClicked: {
                popupBotMode.open()
            }
        }

        Button {
            id: btn_historyGame
            text: qsTr("Game History")
            font.pixelSize: 32
            font.bold: true
            // anchors.top: row_player2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30
            // anchors.horizontalCenter: row_player2.horizontalCenter

            contentItem: Text {
                text: btn_historyGame.text
                font: btn_historyGame.font
                opacity: enabled ? 1.0 : 0.3
                color: btn_historyGame.down ? "#1C1C1C" : "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 300
                implicitHeight: 50
                opacity: enabled ? 1 : 0.5
                color: btn_historyGame.down ? "#1E90FF" : "#1E90FF"
                border.width: 1
                radius: 10
            }

            onClicked: {
                loader.source = "HistoryScreen.qml"
            }
        }

        Button {
            id: btn_HelpMode
            text: qsTr("Guide")
            font.pixelSize: 32
            font.bold: true
            // anchors.top: row_player2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30
            // anchors.horizontalCenter: row_player2.horizontalCenter

            contentItem: Text {
                text: btn_HelpMode.text
                font: btn_HelpMode.font
                opacity: enabled ? 1.0 : 0.3
                color: btn_HelpMode.down ? "#1C1C1C" : "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 300
                implicitHeight: 50
                opacity: enabled ? 1 : 0.5
                color: btn_HelpMode.down ? "#1E90FF" : "#1E90FF"
                border.width: 1
                radius: 10
            }

            onClicked: {
                loader.source = "Guide.qml"
            }
        }
    }

    BotModePopUp {
        id: popupBotMode
        // Center the popup on the screen
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }
}


