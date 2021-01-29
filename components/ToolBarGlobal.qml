import QtQuick 2.12
import QtQuick.Controls 2.12

import '../js/config.js' as CF

ToolBar {
    property alias title: labelName.text
    property alias toolButtonMenu: buttonLeft.toolButtonMenu

    id:toolBarApp
    height: 60
    background: Rectangle{
        id: toolBarBackground
        color: CF.backgroundColor
    }

    contentItem: Row{
        anchors.fill: parent
        anchors.margins: 5
        ToolButton {
            property bool toolButtonMenu
            property string iconName: toolButtonMenu ? 'home' : 'back'
            id: buttonLeft
            icon.source: 'qrc:/media/icons/' + iconName + '.svg'
            icon.color: 'white'
            height: parent.height

            background: Rectangle {
                opacity: (parent.pressed) ? 0.15 : 0
            }

            onClicked: {
                if (toolButtonMenu) {
                    stackViewPages.pop()
                    //Corrigir para voltar para a home ou pagina anterior em caso de roteiro
                }
            }
        }
        Label {
            id: labelName
            color: CF.titlePageColor
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            width: parent.width - (buttonLeft.width + buttonRigth.width)
            height: parent.height
            font.bold: true
            elide: Text.ElideRight
        }

        ToolButton {
            id: buttonRigth
            height: parent.height
            width: height
            visible: false
        }
    }
}
