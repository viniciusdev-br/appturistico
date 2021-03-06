QT += quick
QT += quickcontrols2
QT += webview
QT += qml
QT += svg
QT += core

OPENSSL_LIBS='-L/opt/ssl/lib -lssl -lcrypto' ./configure -openssl-linked
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /usr/lib/qt/qml/QtWebView
#Impossoivel usar webengine no android por ser pesado
#QML_IMPORT_PATH = /usr/lib/qt/qml/QtWebEngine

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

contains(ANDROID_TARGET_ARCH,) {
    ANDROID_ABIS = \
        armeabi-v7a
}

ANDROID_ABIS = armeabi-v7a
android: include(/home/viniciuss/Android/Sdk/android_openssl/openssl.pri)
