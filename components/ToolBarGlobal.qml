import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Qt.labs.platform 1.0
import '../js/config.js' as CF
import '../pages'
ToolBar {
    property alias title: labelName.text
    property alias toolButtonMenu: buttonLeft.toolButtonMenu
    property alias sairRoteiro: buttonLeft.sairRoteiro
    id:toolBarApp
    height: 60
    background: Rectangle{
        id: toolBarBackground
        color: CF.backgroundColor
    }
    MessageDialog {
        id: confirmExit
        title: "Sair?"
        informativeText: "Você quer sair do Roteiro?"
        buttons: MessageDialog.Ok | MessageDialog.Cancel
        onAccepted: {
            stackViewPages.pop()
            sairRoteiro = false
        }
    }
    contentItem: Row{
        anchors.fill: parent
        anchors.margins: 5
        ToolButton {
            property bool toolButtonMenu
            property bool sairRoteiro: false
            property string iconName: toolButtonMenu ? 'home' : 'back'
            id: buttonLeft
            icon.source: stackViewPages.currentItem.objectName == "Home" ? 'qrc:/media/icons/home.svg' : 'qrc:/media/icons/back.svg'
            icon.color: 'white'
            height: parent.height

            background: Rectangle {
                opacity: (parent.pressed) ? 0.15 : 0
            }

            onClicked: {
                if (stackViewPages.currentItem.objectName == "RoteiroMap"){
                    confirmExit.open()
                }else{
                    stackViewPages.pop()
                }
            }
        }
        Label {
            font.pointSize: 14
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
