import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQml 2.12
import QtQuick.Layouts 1.12
ApplicationWindow {
    id: page
    width: 640
    height: 480
    visible: true
    title: qsTr("Aplicativo Geoturístico")
    property string local: ""
    property string image: ""
    property string sobre: ""

    function exibir(localidade, midia){
        local = localidade;
        image = midia;
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
                        nome: data[i]['nome'],
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
                        onClicked: {popup.open(); exibir(model.nome, model.imagem)}
                    }
                }
            }
            onObjectAdded: map.addMapItemGroup(object)
            onObjectRemoved: map.removeMapItemGroup(object)
        }
    }

    Popup{
        id: popup
        width: 273; height: 300
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        padding: 0
        anchors.centerIn: parent
        Column{
            Image {
                source: image
            }
            Text {
                text: local
            }
        }
    }
}


