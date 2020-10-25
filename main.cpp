#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQuickStyle>
int main(int argc, char *argv[])
{
//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

//    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QQuickView view;

    view.setSource(QUrl("qrc:/main.qml"));
    view.setMinimumSize(QSize(1280,720));

    return app.exec();
}
