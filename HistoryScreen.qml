import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
Rectangle {
    id: itm_HistoryScreen
    anchors.centerIn: parent
    width:700
    height:700
    color: "lightyellow"
    ListModel {
        id: emptyModel
    }


    Rectangle {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        id: rect_titleHistoryGame
        width: parent.width
        height: 100

        Text {
            anchors.centerIn: parent
            id: txt_titleHistoryGame
            font.bold: true
            font.pixelSize: 50
            text: "Game History"
        }

    }
    Row {
        id: row_search
        spacing: 30
        height: 50
        anchors.top: rect_titleHistoryGame.bottom

        // anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: "Player List"
            font.bold: true
            font.pixelSize: 30
        }

        Rectangle {
            width: 200
            height: parent.height
            border.width: 2
            border.color: "black"
            radius: 3
            // anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            TextInput {
                id: txt_idInput
                height: parent.height
                anchors.fill: parent
                font.pixelSize: 30
                cursorVisible: true
                text: ""
                leftPadding: 4

                onTextChanged: {
                    if (txt_idInput.text === "") {
                        listviewHistoryData.visible = true
                        rect_search.visible = false
                    }
                    else {
                        listviewHistoryData.visible = false
                        rect_search.visible = true
                    }
                }
            }
        }

        Rectangle {
            anchors.top: parent.top
            // anchors.horizontalCenter: parent.horizontalCenter
            id: btn_search
            width: 150
            height: 50
            color: "blue"
            radius: 10
            Text {
                anchors.centerIn: parent
                id: txt_buttonSearch
                font.bold: true
                font.pixelSize: 30
                text: "Search"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(CaroGame.searchPlayer(txt_idInput.text)){
                        listviewSearch.model = CaroGame.searchPlayer(txt_idInput.text)
                        listviewSameLevel.model = CaroGame.searchPlayerSameLevel()
                    }
                    else {
                        listviewSearch.model = emptyModel
                        listviewSameLevel.model = emptyModel
                        invalidAniSearch.start()
                    }

                }
            }

        }
    }


    ListView {
        id: listviewHistoryData
        // anchors.horizontalCenter: rect_titleHistoryGame.horizontalCenter
        anchors.top: row_search.bottom
        anchors.topMargin: 30
        headerPositioning: ListView.OverlayHeader
        displayMarginBeginning: -31
        width: 720
        height: 400
        clip: true
        // visible: false
        header: Row {
            spacing: 0
            id: row_table
            width: 700
            height: 50
            z: 2
            Rectangle {
                width: row_table.width*1/2
                height: 50
                border.color: "black"
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: "Player's Name"
                }
            }
            Rectangle {
                width: row_table.width*1/6
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: "Wins"
                }
            }
            Rectangle {
                width: row_table.width*1/6
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: "Draws"
                }
            }
            Rectangle {
                width: row_table.width*1/6
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: "Losses"
                }
            }
        }
        model: CaroGame.getPlayerData()
        delegate: Row {
            // spacing: 0
            // id: row_tableInfo
            width: 700
            height: 50
            Rectangle {
                width: parent.width*1/2
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: modelData.playerName
                }
            }
            Rectangle {
                width: parent.width*1/6
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: modelData.wins
                }
            }
            Rectangle {
                width: parent.width*1/6
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: modelData.draws
                }
            }
            Rectangle {
                width: parent.width*1/6
                height: 50
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 30
                    text: modelData.losses
                }
            }
        }
    }

    Button {
        id: btn_returnMenu
        text: qsTr("<-Home")
        font.pixelSize: 20
        font.bold: true
        anchors.top: listviewHistoryData.bottom
        anchors.horizontalCenter: listviewHistoryData.horizontalCenter
        anchors.topMargin: 20

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
            implicitWidth: 150
            implicitHeight: 50
            opacity: enabled ? 1 : 0.5
            color: btn_returnMenu.down ? "#1E90FF" : "#1E90FF"
            border.width: 1
            radius: 10
        }

        onClicked: {
            loader.source = "Menu.qml"
        }
    }

    Rectangle {
        id: rect_search
        anchors.top: row_search.bottom
        anchors.topMargin: 30
        visible: false
        ListView {
            id: listviewSearch
            // anchors.horizontalCenter: rect_titleHistoryGame.horizontalCenter
            headerPositioning: ListView.OverlayHeader
            displayMarginBeginning: -31
            width: 720
            height: 100
            clip: true
            // visible: true
            header: Row {
                spacing: 0
                id: row_tableSearch
                width: 700
                height: 50
                z: 2
                Rectangle {
                    width: row_tableSearch.width*1/2
                    height: 50
                    border.color: "black"
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: "Player's Name"
                    }
                }
                Rectangle {
                    width: row_tableSearch.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: "Wins"
                    }
                }
                Rectangle {
                    width: row_tableSearch.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: "Draws"
                    }
                }
                Rectangle {
                    width: row_tableSearch.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: "Losses"
                    }
                }
            }
            delegate: Row {
                // spacing: 0
                // id: row_tableInfo
                width: 700
                height: 50
                Rectangle {
                    width: parent.width*1/2
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.playerName
                    }
                }
                Rectangle {
                    width: parent.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.wins
                    }
                }
                Rectangle {
                    width: parent.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.draws
                    }
                }
                Rectangle {
                    width: parent.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.losses
                    }
                }
            }
        }


        Rectangle {
            id: rect_invalidSearch
            width: 720
            height: 50
            // anchors.horizontalCenter: parent.horizontalCenter
            // anchors.top: btn_submitLogin.bottom
            anchors.topMargin: 20
            radius: 3
            opacity: 0
            Text {
                id: txt_invalidSearch
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "No player information available"
                font.bold: true
                color: "brown"

            }
        }

        SequentialAnimation {
            id: invalidAniSearch
            PropertyAnimation {
                target: rect_invalidSearch
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }

            PauseAnimation {
                duration: 3000  // 3 giây
            }

            PropertyAnimation {
                target: rect_invalidSearch
                property: "opacity"
                from: 1
                to: 0
                duration: 500
            }
        }

        Rectangle {
            id: rect_sameLevel
            width: 720
            height: 50
            visible: parent.visible
            anchors.top:listviewSearch.bottom
            color: "lightyellow"
            Text {
                // anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 30
                text: "The same level:"
            }
        }

        ListView {
            id: listviewSameLevel
            // anchors.horizontalCenter: rect_titleHistoryGame.horizontalCenter
            headerPositioning: ListView.OverlayHeader
            anchors.top: rect_sameLevel.bottom
            anchors.topMargin: 20
            displayMarginBeginning: -31
            width: 720
            height: 200
            clip: true

            delegate: Row {
                // spacing: 0
                // id: row_tableInfo
                width: 700
                height: 50
                Rectangle {
                    width: parent.width*1/2
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.playerName
                    }
                }
                Rectangle {
                    width: parent.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.wins
                    }
                }
                Rectangle {
                    width: parent.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.draws
                    }
                }
                Rectangle {
                    width: parent.width*1/6
                    height: 50
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 30
                        text: modelData.losses
                    }
                }
            }
        }

    }

}
