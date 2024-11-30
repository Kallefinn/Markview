#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QDebug>
#include <QQmlContext>
#include <QObject>
#include <QPalette>


int createAplication(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QPalette palette;
    palette.setColor(QPalette::Link,"#9a9ef9");
    app.setPalette(palette);
    QUrl filename(argv[argc-1]);
    QQmlApplicationEngine engine;
    QUrl appPath(QString("%1").arg(QDir::currentPath() + "/"));
    auto filePath = QString("%1").arg(QDir::currentPath() + "/" + filename.toString());
    engine.rootContext()->setContextProperty("appPath", appPath);

    QFile textfile(filePath);
    QString filetext;
    if(!textfile.open(QIODevice::ReadOnly)){qDebug() << "didnt open";}
    else {
        QTextStream in(&textfile);
        filetext += in.readAll();
    }

    engine.rootContext()->setContextProperty("fileText",filetext);
    engine.rootContext()->setContextProperty("fileName",filename.fileName());


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("markview", "Main");
    return app.exec();
}

int main(int argc, char *argv[])
{
    createAplication(argc,argv);
}
