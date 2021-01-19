import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import '../js/config.js' as CF

Column {
    property alias headertext: title.text

    BackgroundGlobal {
        width: parent.width
        height: 30
        Text {
            id: title
            anchors.centerIn: parent
            font.bold: true
            color: CF.titlePageColor
        }
    }
}
