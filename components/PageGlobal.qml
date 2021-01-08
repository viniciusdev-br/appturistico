import QtQuick 2.12
import QtQuick.Controls 2.12

import "../js/config.js" as CF

Item {
    property bool isPortrait: this.width < this.height
    property bool ToolButtonMenu: true
    property string title: CF.title

    anchors.left: parent ? parent.left : undefined
}
