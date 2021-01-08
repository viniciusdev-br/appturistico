import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtWebView 1.1
//Importando as configurações do arquivo .js
import "../js/config.js" as CF
ApplicationWindow {
    title: qsTr(CF.title)
    id: page
    width: CF.width
    height: CF.heigth
    minimumHeight: CF.heigth
    minimumWidth: CF.width
    Material.theme: Material.Light
    visible: true
    property url site: ""

    Plugin{id: mapUniversidade; name: "osm"}

    ListModel{ id: model }
    ListModel{ id: positionMapCircle}

    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", 'roteiros/Roteiro1.json');
        xhr.onreadystatechange = function() {
            if ( xhr.readyState === XMLHttpRequest.DONE ){
                var data = JSON.parse(xhr.responseText);
                model.clear();
                for (var i in data){
                    model.append({
                        latitude: data[i]['latitude'],
                        longitude: data[i]['longitude'],
                        titulo: data[i]['titulo'],
                        descricao: data[i]['descricao']
                    });
                }
            }
        }
        xhr.send()
    }

    Map{
        id: mapufpa
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
                property alias color: pontosTuristicos.color
                property alias center: pontosTuristicos.center
                property alias habilitar: pontosTuristicos.habilitar
                MapCircle {
                    id: pontosTuristicos
                    color: "gray"
                    opacity: 0.5
                    border.width: 0
                    center: QtPositioning.coordinate(model.latitude, model.longitude)
                    radius: 50
                    property alias habilitar: toqueTurismo.enabled
                    MouseArea{
                        id: toqueTurismo
                        enabled: false
                        anchors.fill: parent
                        onClicked: {
                            popup.open();
                            site = model.descricao;
                            console.log(site)
                        }
                    }
                }
            }
            onObjectAdded: mapufpa.addMapItemGroup(object)
            onObjectRemoved: mapufpa.removeMapItemGroup(object)
        }
        PositionSource{
            id: posicaoDispositivo
            active: true
            updateInterval: 1000
            onPositionChanged: {
                posicaoDispositivo.start()
                var coordenada = posicaoDispositivo.position.coordinate;
                console.log("Coordenadass: " + coordenada.latitude, coordenada.longitude);
                for( var i=0; i<mapufpa.mapItems.length; i++){
                    console.log("Cordenada mercator: " + mapufpa.mapItems[i].center);
                    if (coordenada.distanceTo(mapufpa.mapItems[i].center) > 100){
                        console.log("Esta distante");
                        mapufpa.mapItems[i].habilitar = true;
                        mapufpa.mapItems[i].color = "red";
                    }
                }

            }
        }
    }

    Popup{
        id: popup
        width: page.width*0.70; height: page.height*0.60
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        padding: 0
        anchors.centerIn: parent
        WebView{
            anchors.fill: parent
            id:pagweb
            url: site
        }
    }
}


