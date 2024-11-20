import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls

Popup {
    id: popupBotMode
    width: 500
    height: 500
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    // signal modeBot(bool hideElement, string bot)
    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
        border.color: "black"
        radius: 10

        Column {
            spacing: 50
            anchors.centerIn: parent

            Button {
                id: btn_easyMode
                text: qsTr("Easy Mode")
                font.pixelSize: 32
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 30


                contentItem: Text {
                    text: btn_easyMode.text
                    font: btn_easyMode.font
                    opacity: enabled ? 1.0 : 0.3
                    color: btn_easyMode.down ? "#1C1C1C" : "#000000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 50
                    opacity: enabled ? 1 : 0.5
                    color: btn_easyMode.down ? "#1E90FF" : "#1E90FF"
                    border.width: 1
                    radius: 10
                }

                onClicked: {
                    modeBot(true, "Easy Bot")
                }
            }

            Button {
                id: btn_normalMode
                text: qsTr("Normal Mode")
                font.pixelSize: 32
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 30


                contentItem: Text {
                    text: btn_normalMode.text
                    font: btn_normalMode.font
                    opacity: enabled ? 1.0 : 0.3
                    color: btn_normalMode.down ? "#1C1C1C" : "#000000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 50
                    opacity: enabled ? 1 : 0.5
                    color: btn_normalMode.down ? "#1E90FF" : "#1E90FF"
                    border.width: 1
                    radius: 10
                }

                onClicked: {
                    modeBot(true, "Normal Bot")
                }
            }
            Button {
                id: btn_hardMode
                text: qsTr("Hard Mode")
                font.pixelSize: 32
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 30

                contentItem: Text {
                    text: btn_hardMode.text
                    font: btn_hardMode.font
                    opacity: enabled ? 1.0 : 0.3
                    color: btn_hardMode.down ? "#1C1C1C" : "#000000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 50
                    opacity: enabled ? 1 : 0.5
                    color: btn_hardMode.down ? "#1E90FF" : "#1E90FF"
                    border.width: 1
                    radius: 10
                }

                onClicked: {
                    modeBot(true, "Hard Bot")
                }
            }
        }
    }
}
