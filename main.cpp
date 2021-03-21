#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QtQml>
#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QtWebView>
#include <QtSvg>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    app.setOrganizationName("CCSL UFPA");
    app.setOrganizationDomain("ccsl.ufpa.br");
    app.setApplicationName("appturistico");
    app.setApplicationVersion("0.5");
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
        engine.load(url);

    return app.exec();
}
