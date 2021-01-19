import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "../js/config.js" as CF
import "../components"
import "../models"
import "../pages"

Page{
    property PageGlobal currentItem

    id: root
    visible: true

    header: ToolBarGlobal {
        id: toolBar
        Material.foreground: "white"
        title: root.currentItem ? root.currentItem.title : ""
        toolButtonMenu: root.currentItem ? root.currentItem.toolButtonMenu : true
    }


    StackView{
        id: stackViewPages
        anchors.fill: parent
        initialItem: Home {
            title: qsTr("Home")
        }
        onCurrentItemChanged: {
            root.currentItem = currentItem
        }
    }
}
