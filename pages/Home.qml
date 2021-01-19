import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import '../components'
import '../pages'

PageGlobal {
    ColumnLayout {
        width: parent.width/4
        anchors.centerIn: parent
        Button {
            Layout.fillWidth: true
            icon.source: "../media/compass-regular.svg"
            text: "Roteiros"
            onClicked: {
                stackViewPages.push("qrc:/pages/SelectRoteiro.qml")
                root.currentItem.title = "Roteiros"
            }
        }
        Button {
            Layout.fillWidth: true
            icon.source: "../media/configuration.svg"
            text: "Configurações"
            onClicked: {
                stackViewPages.push("qrc:/pages/Configuration.qml")
            }
        }
        Button{
            Layout.fillWidth: true
            icon.source: "../media/about.svg"
            text: "Sobre"
            onClicked: {
                stackViewPages.push("qrc:/pages/About.qml")
            }
        }
    }
}
