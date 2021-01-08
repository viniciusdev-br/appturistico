import QtQuick 2.12
import QtQuick.Controls.Material 2.12

import '../js/config.js' as CF

Rectangle{
    color: CF.backgroundColor
    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: CF.backgroundImage
        opacity: 0.6
    }
}
