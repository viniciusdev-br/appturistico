import QtQuick 2.0
import QtLocation 5.12

MapCircle {
    radius: 50  //em metros
    color: "lightgreen"
    opacity: 0.5
    border.width: 0
    MouseArea{
        anchors.fill: parent
        onClicked: {
            parent.color = "black"
            local = monumento
            console.log(local)
            popitem.open()
        }
    }
}
