import QtQuick 2.0
import QtQml 2.12
import QtMultimedia 5.12

Item {
    property Component filesmirante: mediamirante
    Component {
        id: mediamirante
        Video {
            id: video
            width : parent.width; height : parent.height
            source: "./media/mirante-do-rio.mp4"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    video.play()
                }
            }
            focus: true
        }
    }
    property Component filesicen: mediaicen
    Component {
        id: mediaicen
        Image {
            id: icen
            source: "media/icen.jpeg"
        }
    }
    property Component filescapela: mediacapela
    Component {
        id: mediacapela
        Component{
            id: mediacapela
            Text {
                text: qsTr("Texto bonito sobre a capela")
            }
        }
    }
}
