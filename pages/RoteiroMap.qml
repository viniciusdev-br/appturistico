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
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.15
import "../js/config.js" as CF
import '../components'

PageGlobal {
    property string objectName: "RoteiroMap"
    property string targetRoteiroLast: ""
    property url site: ""
    property double latitudeMaker
    property double lonigitudeMaker
    property int visitado: 0
    property bool primeiroFeito: false
    property double initialLatitude
    property double initialLongitude
    property int  totalPontos: 0
    title: qsTr('Roteiro')
    Material.theme: Material.Light
    visible: true
    Plugin{
        id: mapUniversidade;
        name: "osm"
    }
    ListModel{ id: model }
    ListModel{ id: positionMapCircle}

    Component.onCompleted: {
        console.log(targetRoteiro)
        var xhr = new XMLHttpRequest;
        var pathRoteiro = "../roteiros/" + targetRoteiroLast;
        xhr.open("GET", pathRoteiro + "/points.json");
        xhr.onreadystatechange = function() {
            if ( xhr.readyState === XMLHttpRequest.DONE ){
                var data = JSON.parse(xhr.responseText);
                model.clear();
                for (var i in data){
                    model.append({
                        latitude: data[i]['latitude'],
                        longitude: data[i]['longitude'],
                        titulo: data[i]['titulo'],
                        descricao: pathRoteiro + "/content/" + data[i]['descricao']
                    });
                    if ( primeiroFeito == false ){
                        initialLatitude = data[i]['latitude'];
                        initialLongitude = data[i]['longitude'];
                        primeiroFeito = true;
                    }
                    totalPontos += 1
                }
            }
        }
        xhr.send()
    }

    Map{
        id: mapufpa
        anchors.fill: parent
        plugin: mapUniversidade
        center: QtPositioning.coordinate(initialLatitude, initialLongitude)
        copyrightsVisible: false

        zoomLevel: isPortrait ? 17 : 16
        maximumZoomLevel: 19
        minimumZoomLevel: 15
        gesture.enabled: true
        gesture.acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.FlickGesture
                                  | MapGestureArea.PanGesture | MapGestureArea.RotationGesture

        Behavior on center {
            CoordinateAnimation {
                duration: 1000
                easing.overshoot: 0.5
                easing.type: Easing.InOutBack
            }
        }

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
                    radius: 20
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
                latitudeMaker = coordenada.latitude; lonigitudeMaker = coordenada.longitude;
                for( var i=0; i<mapufpa.mapItems.length; i++){
                    if (coordenada.distanceTo(mapufpa.mapItems[i].center) > 100){
                        mapufpa.mapItems[i].habilitar = true;
                        mapufpa.mapItems[i].color = "#009688";
                        visitado = visitado + 1
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
        id: centralizador
        padding: 16
        anchors.margins: 5
        anchors.right: parent.right
        anchors.bottom: checkList.top
        Material.background: "white"
        icon {
            source: 'qrc:/media/icons/gps-location.svg'
            color: CF.backgroundColor
        }
        onClicked: {
            var coordenada = posicaoDispositivo.position.coordinate
            mapufpa.center = coordenada
        }
    }

    Rectangle{
        id:checkList
        width: textCheckList.width + iconeContador.width; height: textCheckList.height
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 5
        radius: 5
        RowLayout {
            spacing: 0
            Rectangle {
                id: iconeContador
                width: checkListImage.width; height: checkListImage.height + 5
                anchors.centerIn: parent/2
                Image {
                    id: checkListImage
                    width: textCheckList.width * 0.7; height: checkList.height * 0.8
                    source: 'qrc:/media/icons/map-marker.svg'
                    smooth: true
                    visible: false
                }
                ColorOverlay {
                    anchors.fill: checkListImage
                    source: checkListImage
                    color: CF.backgroundColor
                }
            }

            Text {
                id: textCheckList
                color: CF.backgroundColor
                text: visitado + '/' + totalPontos
                font.pixelSize: 14
                font.bold: true
                padding: 8
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mapufpa.center = QtPositioning.coordinate(initialLatitude, initialLongitude)
            }
        }
    }


    Popup{
        id: popup
        width: mapufpa.width*0.80; height: mapufpa.height*0.75
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        padding: 0
        anchors.centerIn: parent
        WebView{
            anchors.fill: parent
            id:pagweb
            url: Qt.resolvedUrl(site)
        }
    }
    Label {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 1
        text: qsTr('© Contribuidores do OpenStreetMap')
        font {
            pixelSize: 12
        }
    }
}


