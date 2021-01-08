import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import '../js/config.js' as CF

Column {
    property alias headerText: title.text

    BackgroundCCSL {
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
