import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import '../components'

PageGlobal {
    PanelGlobal {
        headerText: qsTr('First section')
        width: parent.width
    }

    Label {
        anchors.centerIn: parent
        text: qsTr('Put something here')
    }

}
