import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import '../components'

PageGlobal {
    property string objectName:  "Home"

    ColumnLayout {
        width: parent.width/2.5
        anchors.centerIn: parent
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
        Button {
            Layout.fillWidth: true
            icon.source: "../media/icons/configuration.svg"
            text: "Configurações"
            Material.background: Material.Teal
            Material.foreground: "white"
            onClicked: {
                stackViewPages.push("qrc:/pages/Configuration.qml")
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
            }
        }
    }
}
