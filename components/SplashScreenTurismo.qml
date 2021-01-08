import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.12
import "../js/config.js" as CF

BackgroundGlobal {
    ColumnLayout {
        anchors.centerIn: parent
        Item {
            width: 100
            height: 125
            Image {
                id: logo
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                source: CF.logoImage
                sourceSize.width: parent.width
            }
            ColorOverlay {
                anchors.fill: logo
                source: logo
                color: "#FFF"
            }
        }
        Label {
            id: label
            Layout.alignment: Qt.AlignHCenter
            color: 'white'
            text: CF.trademark
            Component.onCompleted: label.font.pointSize += 6
        }
    }
}
