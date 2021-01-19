import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "../js/config.js" as CF
import '../components'
PageGlobal {
    id: selectRoteiroId
    ListModel{id:modelDescricao}
    ListModel{id:modelDetalhes}

    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", '../roteiros/listaroteiros.json');
        xhr.onreadystatechange = function() {
            if ( xhr.readyState === XMLHttpRequest.DONE ){
                var data = JSON.parse(xhr.responseText);
                modelDescricao.clear();
                for (var i in data){
                    modelDescricao.append({
                        tag: data[i]['tag']
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
                textRole: "tag"
                model: modelDescricao
                onActivated: {
                    console.log("Combobox selecionado " + currentText)
                    var xhr = new XMLHttpRequest;
                    xhr.open("GET", '../roteiros/listaroteiros.json');
                    xhr.onreadystatechange = function() {
                        if ( xhr.readyState === XMLHttpRequest.DONE ){
                            var data = JSON.parse(xhr.responseText);
                            modelDetalhes.clear();
//                            for (var i in data){
                                modelDetalhes.append({
                                    bairro: data[currentIndex]['bairro'],
                                    detalhes: data[currentIndex]['detalhes']
                                });
//                            }
                        }
                    }
                    xhr.send()
                }
            }
        }
        Row{
            width: parent.width
            height: 300
            ListView{
                anchors.fill: parent
                model: modelDetalhes
                delegate: Label{

                    text: "Nome do roteiro " + bairro + "
" + detalhes
                }
            }
        }
        Row{
            width: parent.width
            height: 30
            RoundButton{
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 7
                width: botaoStart.width + 20
                height: botaoStart.height + 20
                Text {
                    id: botaoStart
                    anchors.centerIn: parent
                    color: "white"
                    text: "Começar"
                    font.pointSize: 14
                }
                palette.button: CF.backgroundColor
             }
        }

    }
}
