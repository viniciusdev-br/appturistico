import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "../js/config.js" as CF
import '../components'
import '.'
PageGlobal {
    id: paginaGlobal
    ListModel{id:modelDescricao}
    ListModel{id:modelDetalhes}
    property string targetRoteiro: ""
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
                topPadding: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Selecione um roteiro"
                font.pointSize: 20
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
                                    roteiro: data[currentIndex]['roteiro'],
                                    bairro: data[currentIndex]['bairro'],
                                    detalhes: data[currentIndex]['detalhes'],
                                    imagemApoio: data[currentIndex]['imagemApoio']
                                });
//                            }
                        }
                    }
                    xhr.send()
                }
            }
        }
        Row{
            id: rowConteudo
            width: parent.width; height: parent.height * 0.6
            ListView{
                width: rowConteudo.width
                height: 300
                model: modelDetalhes
                delegate: Label{
                    Column{
                        id: colunaConteudo
                        anchors.fill: rowConteudo
                        spacing: 10
                        Rectangle {
                            anchors.horizontalCenter: colunaConteudo.horizontalCenter
                            color: "#6ed36e";
                            radius: 10
                            width: textBairro.width + 20; height: 50
                            Text {
                                id: textBairro
                                anchors.centerIn: parent
                                color: "white"
                                font.pointSize: 18;
                                text: "Bairro " + bairro
                            }
                        }
                        Image {
                            anchors.horizontalCenter: colunaConteudo.horizontalCenter
                            id: imagemRoteiro
                            height: rowConteudo.height * 0.6
                            fillMode: Image.PreserveAspectFit
                            source: imagemApoio
                        }
                        Text {
                            anchors.horizontalCenter: colunaConteudo.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            width: rowConteudo.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 14
                            text: qsTr(detalhes)
                        }
                        RoundButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 5
                            width: botaoStart.width + 20
                            height: botaoStart.height + 20
                            palette.button: CF.backgroundColor
                            Text {
                                id: botaoStart
                                anchors.centerIn: parent
                                color: "white"
                                text: "Iniciar roteiro!"
                                font.pointSize: 14
                            }
                            onClicked: {
                                root.currentItem.title = "Pontos Turísticos"
                                stackViewPages.push("qrc:/pages/RoteiroMap.qml")
                            }
                         }
                    }
                }
            }
        }
    }

}
