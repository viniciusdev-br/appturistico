import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQml 2.15

import "js/config.js" as CF

ApplicationWindow{
    height: CF.heigth
    width: CF.width
    minimumHeight: CF.heigth / 2
    minimumWidth: CF.width / 2

    title: qsTr(CF.title)
    visible: true

    Material.theme: Material.Light

    Loader{
        id: mainLoader
        asynchronous: true
        //Código para evitar que vejamos o objeto sendo carragado
        visible: status === Loader.Ready
        anchors.fill: parent
    }

    Loader{
        id: splashLoader
        anchors.fill: parent
        source: "qrc:/components/SplashScreenTurismo.qml"

        Timer{
            //Executará após 1.0s e depois não irá se repetir
            interval: 1000
            running: true
            repeat: false
            onTriggered: mainLoader.source = "qrc:/pages/StartCanvas.qml"
        }
        opacity: mainLoader.visible ? 0 : 1
        visible: opacity !== 0
        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
