import QtQuick 2.15
import QtQuick.Controls 2.15



Rectangle {
    width: 800
    height: 600
    color: "#f0f0f0"
    anchors.centerIn: parent

    Column {
        anchors.centerIn: parent
        spacing: 20
        width: 700

        Text {
            text: "How to Play Tic Toc Toe 10x10"
            font.bold: true
            font.pointSize: 20
            color: "#333"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Rectangle {
            width: parent.width - 40
            height: 2
            color: "#333"
        }

        Text {
            text: "Game Rules:"
            font.bold: true
            font.pointSize: 18
            color: "#555"
        }

        Text {
            text: "1. Caro 10x10 is played on a 10x10 grid."
            font.pointSize: 16
            color: "#333"
            wrapMode: Text.Wrap
            width: parent.width - 40
        }

        Text {
            text: "2. Players take turns placing 'X' or 'O' on the empty squares of the grid."
            font.pointSize: 16
            color: "#333"
            wrapMode: Text.Wrap
            width: parent.width - 40
        }

        Text {
            text: "3. A player wins by getting 4 of their marks ('X' or 'O') in a row, column, or diagonal."
            font.pointSize: 16
            color: "#333"
            wrapMode: Text.Wrap
            width: parent.width - 40
        }

        Text {
            text: "Objective:"
            font.bold: true
            font.pointSize: 18
            color: "#555"
        }

        Text {
            text: "Try to place 4 marks in a continuous line to win the game!"
            font.pointSize: 16
            color: "#333"
            wrapMode: Text.Wrap
            width: parent.width - 40
        }

        Button {
            text: "<-Home"
            font.pointSize: 18
            width: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                loader.source = "Menu.qml"
            }
        }
    }
}


