import QtQuick 2.12

ListModel {
    id: modePageList

    ListElement{
        nameId: 'home'
        active: true
        title: qsTr('Start')
        source: 'qrc:/pages/Home.qml'
        sourceIcon: 'qrc:/media/home.svg'
    }
    ListElement{
        nameId: 'about'
        active: true
        title: qsTr('About')
        source: 'qrc:/pages/About.qml'
        sourceicon: 'qrc:/media/about.svg'
    }
    ListElement{
        nameId: 'configurantion'
        active: true
        title: qsTr('Configurações')
        source: 'qrc:/pages/Configuration.qml'
        sourceIcon: 'qrc:/media/configuration.svg'
    }
    ListElement{
        nameId: 'selectRoteiro'
        active: true
        title: qsTr('Selecione um Roteiro')
        source: 'qrc:/pages/SelectRoteiro.qml'
        sourceIcon: 'qrc:/media/map-explore.svg'
    }
//    ListElement{
//        nameId: 'roteiroMap'
//        active: true
//        title: qsTr('Roteiro')
//        source: 'qrc:/pages/RoteiroMap.qml'
//        sourceIcon: 'qrc:/media/map-explore.svg'
//    }
}
