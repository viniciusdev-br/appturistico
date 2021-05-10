#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlComponent>
#include <QtQml>
#include <QQuickStyle>
#include <QtWebView>
#include <QtSvg>
#include <QDir>
#include <QFileInfo>
#include <QQmlContext>
#include <QStandardPaths>
#include <QUrl>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QtWebView::initialize();
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    app.setOrganizationName("CCSL UFPA");
    app.setOrganizationDomain("ccsl.ufpa.br");
    app.setApplicationName("appturistico");
    app.setApplicationVersion("0.5");

    //Objeto para carregar aplicação a partir da main.qml
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
        engine.load(url);


        //Armazena na variável tmploc o diretório onde os arquivos temporários podem ser escritos
        QString tmploc = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
        //Fornece acesso ao diretório
        QDir tmpdir(tmploc + "/my_cache");

        //Itera nos subdiretórios
        QDirIterator it(":", QDirIterator::Subdirectories);
        while (it.hasNext()) {
            //Cria a variável que vai guardar o arquivo temporário
            QString tmpfile;
            tmpfile = it.next();
            if (QFileInfo(tmpfile).isFile()) {
                QFileInfo file = QFileInfo(tmpdir.absolutePath() + tmpfile.right(tmpfile.size()-1));
                file.dir().mkpath("."); // create full path if necessary
                QFile::remove(file.absoluteFilePath()); // remove previous file to make sure we have the latest version
                QFile::copy(tmpfile, file.absoluteFilePath());
            }
        }

        // if wanted, set the QML webview URL
        QQuickView context;
        context.rootContext()->setContextProperty(QStringLiteral("conteudo"), QFileInfo(tmpdir.absolutePath() + "/index.html").absoluteFilePath());
        context.setSource(QUrl::fromLocalFile("/pages/RoteiroMap.qml"));
    return app.exec();
}
