import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.15
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
                color: CF.backgroundColor
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
                property bool padraoComboBox: true
                id: selectBox
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8
                currentIndex: 0
                displayText: padraoComboBox ?  "Selecione: " : currentText
                textRole: "tag"
                model: modelDescricao
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: maskSelectBox
                }
                onActivated: {
                    console.log("Combobox selecionado " + currentText)
                    var xhr = new XMLHttpRequest;
                    xhr.open("GET", '../roteiros/listaroteiros.json');
                    xhr.onreadystatechange = function() {
                        if ( xhr.readyState === XMLHttpRequest.DONE ){
                            var data = JSON.parse(xhr.responseText);
                            modelDetalhes.clear();
                                modelDetalhes.append({
                                    roteiro: data[currentIndex]['roteiro'],
                                    bairro: data[currentIndex]['bairro'],
                                    detalhes: data[currentIndex]['detalhes'],
                                    imagemApoio: data[currentIndex]['imagemApoio']
                                });
                        }
                    }
                    xhr.send()
                    padraoComboBox = false;
                }
            }
            Rectangle {
                id: maskSelectBox
                width: selectBox.width; height: selectBox.height
                radius: 10
                visible: false
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
                        Image {
                            anchors.horizontalCenter: colunaConteudo.horizontalCenter
                            id: imagemRoteiro
                            height: rowConteudo.height * 0.6
                            fillMode: Image.PreserveAspectFit
                            source: imagemApoio
                            layer.enabled: true
                            layer.effect: OpacityMask{
                                maskSource: maskImage
                            }
                        }
                        Rectangle {
                            id: maskImage
                            width: imagemRoteiro.width
                            height: imagemRoteiro.height
                            radius: 30
                            visible: false
                        }
                        Rectangle {
                            anchors.horizontalCenter: colunaConteudo.horizontalCenter
                            radius: 10
                            width: textBairro.width + 20; height: 40
                            Text {
                                id: textBairro
                                anchors.centerIn: parent
                                color: CF.backgroundColor
                                font.pointSize: 18;
                                font.bold: true
                                text: "Bairro " + bairro
                            }
                        }
                        Text {
                            anchors.horizontalCenter: colunaConteudo.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            width: rowConteudo.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 14
                            text: qsTr(detalhes)
                            color: '#565B5B'
                        }
                        RoundButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 5
                            width: botaoStart.width + 20
                            height: botaoStart.height + 20
                            Material.background: CF.backgroundColor
                            Text {
                                id: botaoStart
                                anchors.centerIn: parent
                                color: "white"
                                text: "Iniciar roteiro!"
                                font.pointSize: 14
                            }
                            onClicked: {
                                root.currentItem.title = "Pontos Turísticos"
                                stackViewPages.push("qrc:/pages/RoteiroMap.qml", {"targetRoteiroLast": roteiro})
                            }
                         }
                    }
                }
            }
        }
    }

}
