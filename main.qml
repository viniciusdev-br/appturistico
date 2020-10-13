import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQml 2.12
import QtQuick.Layouts 1.12
Window {
    id: page
    width: 640
    height: 480
    visible: true
    title: qsTr("Aplicativo Geoturístico")
    ListView{
        id: listmap
        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: 75
        Layout.preferredHeight: 200
        model: ListModel{ id: model }
        delegate: Text {
            id: name
            text: "Nome: " + model.latitude * model.longitude
        }
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
    }
}

