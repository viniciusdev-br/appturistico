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
ApplicationWindow {
    Material.theme: Material.System
    id: page
    width: Qt.platform.os == "android" ? Screen.width : 720
    height: Qt.platform.os == "android" ? Screen.height : 1280
    visible: true
    title: qsTr("Aplicativo Geoturístico")
    property url site: ""

    Plugin{id: mapUniversidade; name: "osm"}

    ListModel{ id: model }
    ListModel{ id: positionMapCircle}

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
//            id: mapInstatiator
            model: model
            delegate:
            MapItemGroup {
                id: delegateGroup
                MapCircle {
                    id: pontosTuristicos
                    color: "gray"
                    opacity: 0.5
                    border.width: 0
                    center: QtPositioning.coordinate(model.latitude, model.longitude)
                    radius: 50
                    MouseArea{
                        enabled: true
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
                var raio = 0
                var coordenada = posicaoDispositivo.position.coordinate;
                console.log("Coordenadas: " + coordenada.latitude, coordenada.longitude);

                //posicaoDispositivo.distanceTo(QtPositioning.coordinate(model.latitude, model.longitude))
                for(var child = 0; child < model.rowCount(); child++){
//                    console.log(coordenada.distanceTo(QtPositioning.coordinate(monumentos.get(child).center)));
                    console.log(coordenada.distanceTo(QtPositioning.coordinate(model.get(child).latitude, model.get(child).longitude)));
                    console.log(model.get(child).titulo);
                    if (coordenada.distanceTo(QtPositioning.coordinate(model.get(child).latitude, model.get(child).longitude)) < 100){
                        console.log('O raio entre o dispositivo está dentro do alcance, enable mouseArea...');

                    }
                }
                for(var i=0; i < delegateGroup.count(); i++){
                    console.log(pontosTuristicos.center);
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


