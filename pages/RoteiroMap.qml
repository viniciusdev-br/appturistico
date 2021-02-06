import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15
import QtQml 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtWebView 1.15
//Importando as configurações do arquivo .js
import "../js/config.js" as CF
import '../components'
PageGlobal {
    property string targetRoteiroLast: ""
    property url site: ""
    property double latitudeMaker
    property double lonigitudeMaker
    title: qsTr("Tour pelo mapa")
    Material.theme: Material.Light
    visible: true
    Plugin{id: mapUniversidade; name: "osm"}

    ListModel{ id: model }
    ListModel{ id: positionMapCircle}

    Component.onCompleted: {
        console.log(targetRoteiro)
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "../roteiros/"+targetRoteiroLast+".json");
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
        center: QtPositioning.coordinate(latitudeMaker, lonigitudeMaker)
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
                latitudeMaker = coordenada.latitude
                lonigitudeMaker = coordenada.longitude
                console.log("Coordenadass: " + coordenada.latitude, coordenada.longitude);
                for( var i=0; i<mapufpa.mapItems.length; i++){
                    console.log("Cordenada mercator: " + mapufpa.mapItems[i].center);
                    if (coordenada.distanceTo(mapufpa.mapItems[i].center) > 100){
                        console.log("Esta distante");
                        mapufpa.mapItems[i].habilitar = true;
                        mapufpa.mapItems[i].color = "#009688";
                    }
                }
            }
        }
        MapQuickItem{
            id: maker
            sourceItem: Image {
                width: 15; height: 25
                id: makerIcon
                source: "qrc:/media/icons/maker-user.svg"
            }
            coordinate: QtPositioning.coordinate(latitudeMaker, lonigitudeMaker)
            opacity: 0.7
            anchorPoint: Qt.point(makerIcon.width, makerIcon.height)
        }
    }

    RoundButton{
        id: checkList
        icon {
            source: "qrc:/media/icons/map-marker.svg"
        }
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 5
        radius: 5
        text: "0/20"
    }

    Popup{
        id: popup
        width: mapufpa.width*0.70; height: mapufpa.height*0.60
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


