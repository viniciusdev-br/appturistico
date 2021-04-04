import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

import '../components'

PageGlobal {
    property string objectName:  "Home"
    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        RowLayout{
            Layout.topMargin: 0
            Layout.topPadding: 0
            Layout.fillWidth: true
            Item{
                anchors.horizontalCenter: parent.horizontalCenter
                width: 480*0.7; height: 640*0.6
                Rectangle{
                    id: maskRound
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
                    maskSource: maskRound
                }
            }
        }
        RowLayout{
            Button {
                Layout.fillWidth: true
                icon.source: "../media/icons/compass-regular.svg"
                text: "Roteiros"
                Material.background: Material.Teal
                Material.foreground: "white"
                onClicked: {
                    stackViewPages.push("qrc:/pages/SelectRoteiro.qml")
                    root.currentItem.title = "Roteiros ativos"
                }
            }
        }
        RowLayout{
            Button {
                Layout.fillWidth: true
                icon.source: "../media/icons/configuration.svg"
                text: "Configurações"
                Material.background: Material.Teal
                Material.foreground: "white"
                onClicked: {
                    stackViewPages.push("qrc:/pages/Configuration.qml")
                    root.currentItem.title = "Configurações"
                }
            }
            Button{
                Layout.fillWidth: true
                icon.source: "../media/icons/about.svg"
                text: "Sobre"
                Material.background: Material.Teal
                Material.foreground: "white"
                onClicked: {
                    stackViewPages.push("qrc:/pages/About.qml")
                    root.currentItem.title = "Sobre"
                }
            }
        }


    }





//    ColumnLayout {
//        width: parent.width/2.5
//        anchors.centerIn: parent
//        Button {
//            Layout.fillWidth: true
//            icon.source: "../media/icons/compass-regular.svg"
//            text: "Roteiros"
//            Material.background: Material.Teal
//            Material.foreground: "white"
//            onClicked: {
//                stackViewPages.push("qrc:/pages/SelectRoteiro.qml")
//                root.currentItem.title = "Roteiros ativos"
//            }
//        }
//        Button {
//            Layout.fillWidth: true
//            icon.source: "../media/icons/configuration.svg"
//            text: "Configurações"
//            Material.background: Material.Teal
//            Material.foreground: "white"
//            onClicked: {
//                stackViewPages.push("qrc:/pages/Configuration.qml")
//            }
//        }
//        Button{
//            Layout.fillWidth: true
//            icon.source: "../media/icons/about.svg"
//            text: "Sobre"
//            Material.background: Material.Teal
//            Material.foreground: "white"
//            onClicked: {
//                stackViewPages.push("qrc:/pages/About.qml")
//            }
//        }
//    }
}
