import QtQuick 2.12
import QtQuick.Controls 2.12

import "../js/config.js" as CF

Item {
    property bool isPortrait: this.width < this.height
    property bool toolButtonMenu: true
    property bool sairRoteiro: false
    property string title: CF.title
    property string targetRoteiro: ""
    anchors.left: parent ? parent.left : undefined

}
