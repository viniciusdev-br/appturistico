import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "../js/config.js" as CF
import '../components'
PageGlobal {
    id: selectRoteiroId
    property string roteiroTarget: "value"
    ListModel{id:modelDescricao}
    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", '../roteiros/Roteiro1.json');
        xhr.onreadystatechange = function() {
            if ( xhr.readyState === XMLHttpRequest.DONE ){
                var data = JSON.parse(xhr.responseText);
                modelDescricao.clear();
                for (var i in data){
                    modelDescricao.append({
                        latitude: data[i]['latitude'],
                        longitude: data[i]['longitude'],
                        titulo: data[i]['titulo'],
                        descricao: data[i]['descricao'],
                        bairro: data[i]['bairro'],
                        detalhes: data[i]['detalhes']
                    });
                }
            }
        }
        xhr.send()
    }
    Column{
        anchors.fill: parent
        spacing: 20
        Row{
            width: parent.width
            height: 30
            Label{
                topPadding: 15
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Selecione um roteiro "
                font.pointSize: 16
                font.bold: true
            }
        }
        Row{
            width: parent.width
            height: 30
            ComboBox{
                id: selecbox
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8
                currentIndex: 0
                displayText: "Roteiro: " + currentText
                model: ListModel {
                    id: modelCombobox
                    ListElement {text: "- - -"}
                    ListElement {text: "ICEN"}
                    ListElement {text: "Mirante"}
                    ListElement {text: "Capela"}
                }
                onActivated: {
                    roteiroTarget = currentText
                }
            }
        }
        Row{
            width: parent.width
            height: 300
            ListView{
                anchors.fill: parent
                model: modelDescricao
                visible: selecbox.currentIndex != 0
                delegate: Label{
                    text: "Nome do roteiro " + titulo
                }
            }
        }
        Row{
            width: parent.width
            height: 30
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                Text: {
                    text: "Começar"
                    background: "white"
                }

                palette.button: CF.backgroundColor
             }
        }

    }
}
