import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
ApplicationWindow {
    Material.theme: Material.System
    id: page
    width: Qt.platform.os == "android" ? Screen.width : 720
    height: Qt.platform.os == "android" ? Screen.height : 1280
    visible: true
    title: qsTr("Aplicativo Geoturístico")
    property string local: ""
    property string image: ""
    property string nome: ""

    function exibir(localidade, midia, nomes){
        local = localidade;
        image = midia;
        nome = nomes
    }
    Plugin{id: mapUniversidade; name: "osm"}
    ListModel{ id: model }

    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", 'Dados.json');
        xhr.onreadystatechange = function() {
            if ( xhr.readyState === XMLHttpRequest.DONE ){
                var data = JSON.parse(xhr.responseText);
                model.clear();
                for (var i in data){
                    model.append({
                        latitude: data[i]['latitude'],
                        longitude: data[i]['longitude'],
                        titulo: data[i]['titulo'],
                        descricao: data[i]['descricao'],
                        imagem: data[i]['imagem']
                    });
                }
            }
        }
        xhr.send()
    }

    Map{
        id: map
        anchors.fill: parent
        plugin: mapUniversidade
        center: QtPositioning.coordinate(-1.475107, -48.456111)
        zoomLevel: 16
        Instantiator {
            //Cria os mapCircles a partir do model
            model: model
            delegate:
            MapItemGroup {
                id: delegateGroup
                MapCircle {
                    color: "lightgreen"
                    opacity: 0.5
                    border.width: 0
                    center: QtPositioning.coordinate(model.latitude, model.longitude)
                    radius: 50
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {popup.open(); exibir(model.descricao, model.imagem, model.titulo)}
                    }
                }
            }
            onObjectAdded: map.addMapItemGroup(object)
            onObjectRemoved: map.removeMapItemGroup(object)
        }
    }

    Popup{
        id: popup
        width: page.width*0.70; height: page.height*0.60
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        padding: 0
        anchors.centerIn: parent
        Column{
            Text {
                color: "#c2723c"
                font.family: "Dyuthi"
                font.pointSize: 30
                width: popup.width
                bottomPadding: 20; topPadding: 20
                horizontalAlignment: Text.AlignHCenter
                text: nome
            }
            Rectangle{
                color: "red"
                width: popup.width
                height: 300
                Image {
                    width: popup.width;
                    height: parent.height
                    horizontalAlignment: Image.horizontalHCenter
                    id:imagempopup
                    source: image
                }
            }
            ScrollView{
                Text{
                    topPadding: 5
                    leftPadding: 10
                    width: popup.width
                    height: imagempopup.height*1.5
                    wrapMode: Text.WordWrap
                    text: local
                }
            }
        }
    }
}


