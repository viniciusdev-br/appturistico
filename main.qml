import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQml 2.12

ApplicationWindow {
    id: page
    width: 640
    height: 480
    visible: true
    title: qsTr("Aplicativo Geoturístico")
    property string local: ""

    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open('GET', 'Dados.json');
        xhr.onreadystatechange = function() {
            if ( xhr.resadyState === XMLHttpRequest.DONE ){
                var data = JSON.parse(xhr.responseText);

            }
        }
    }

    Plugin {
        id: mapUniversidade
        name: "osm"
        }

     Map {
        anchors.fill: parent
        plugin: mapUniversidade
        center: QtPositioning.coordinate(-1.475107, -48.456111) // UFPA
        color: "lightgreen"
        zoomLevel: 16
        Pontos {
            id: icen; center { latitude: -1.475107; longitude: -48.456111 }
            property string monumento: "icen"
        }
        Pontos {
            id: mirante; center { latitude: -1.4772138; longitude: -48.4564629 }
            property string monumento: "mirante"
        }
        Pontos {
            id: capela; center { latitude: -1.4773023; longitude: -48.4554115 }
            property string monumento: "capela"
        }
     }

     Popup {
         id: popitem
         margins: 60
         width: conteudoPop.width; height: conteudoPop.height
         modal: true
         focus: true
         closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
         padding: 0
         StackView{
            id: popPilha
            initialItem: mainView
            anchors.fill: parent
            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }
         }
     }
     Component{
         id: mainView
         Column{
             id: conteudoPop
             Image {
                 id: imageConteudo
                 source: "./media/"+local
                 anchors.centerIn: popitem
                 width: 273; height: 184
             }
             Rectangle{
                 width: imageConteudo.width; height: textoConteudo.height + nextStack.height + 20
                 Text {
                     id: textoConteudo
                     text: (conteudoText(local))
                 }
                 Button{
                     id: nextStack
                     text: "Mais imagens"
                     anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                     onClicked: {
                         popPilha.push(secondView)
                     }
                 }
             }
         }
     }
     Component{
         id: secondView
         Column{
             id: conteudoPopSecond
             Image {
                 id: imageConteudoSecond
                 source: "./media/"+local+"2"
                 anchors.centerIn: popitem
                 width: 273; height: 184
             }
             Rectangle{
                 width: imageConteudoSecond.width; height: backStack.height + 30
                 Button{
                     id: backStack
                     anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                     text: "Voltar"
                     onClicked: {
                         popPilha.pop()
                     }
                 }
             }
         }
     }
}
