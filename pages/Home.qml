import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

import '../components'
import "../js/config.js" as CF
PageGlobal {
    property string objectName:  "Home"
    id:pageHome
    Column{
        anchors.fill: parent
        spacing: 10
        Item{
            width: 1
            height: 5
        }
        Item{
            anchors.horizontalCenter: parent.horizontalCenter
            width: CF.width*0.7; height: CF.heigth*0.7
            Rectangle{
                id: maskRoundImage
                width: parent.width
                height: parent.height
                radius: 14
                visible: false
            }
            Image {
                id: imagemHome
                width: parent.width
                height: parent.height
                source: "../media/images/home-page-2.png"
                visible: false
            }
            OpacityMask{
                anchors.fill: imagemHome
                source: imagemHome
                maskSource: maskRoundImage
            }
        }
        Row{
            width: parent.width
            height: iniciarRoteiroButton.height
            Button {
                id: iniciarRoteiroButton
                anchors.horizontalCenter: parent.horizontalCenter
                icon.source: "../media/icons/compass-regular.svg"
                text: "Iniciar um Roteiro"
                Material.background: Material.Teal
                Material.foreground: "white"
                onClicked: {
                    stackViewPages.push("qrc:/pages/SelectRoteiro.qml")
                    root.currentItem.title = "Roteiros ativos"
                }
            }
        }
        RowLayout{
            width: parent.width
            height: parent.height*0.2
            spacing: 30
            Item {
                Layout.fillWidth: implicitWidth > 0 ? false : true
            }
            Button{
                id: configurationButton
                Layout.preferredWidth: parent.height
                Layout.preferredHeight: parent.height
                Image {
                    id: configurationIcon
                    source: "../media/images/outros.png"
                    height: parent.height
                    width: parent.width
                }
                Rectangle{
                    color: CF.backgroundColor
                    width: parent.width
                    height: parent.height*0.2
                    anchors.bottom: parent.bottom
                    radius: 4
                    Text{
                        text: "Configurações"
                        color: "White"
                        anchors.centerIn: parent
                    }
                }
                onClicked:{
                    stackViewPages.push("qrc:/pages/Configuration.qml")
                    root.currentItem.title = "Configurações"
                }
            }
            Button{
                id: aboutButton
                Layout.preferredWidth: parent.height
                Layout.preferredHeight: parent.height
                Image {
                    id: aboutIcon
                    source: "../media/images/ufpa.png"
                    fillMode: Image.PreserveAspectFit
                    height: parent.height
                    width: parent.width
                }
                Rectangle{
                    color: CF.backgroundColor
                    width: parent.width
                    height: parent.height*0.2
                    anchors.bottom: parent.bottom
                    radius: 4
                    Text{
                        text: "Sobre"
                        color: "White"
                        anchors.centerIn: parent
                    }
                }
                onClicked:{
                    stackViewPages.push("qrc:/pages/About.qml")
                    root.currentItem.title = "Sobre"
                }
            }
            Item {
                Layout.fillWidth: implicitWidth > 0 ? false : true
            }
        }
    }
}
