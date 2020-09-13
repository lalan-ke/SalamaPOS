#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "qmlinterface.h"
#include "models/stockitemsmodel.h"
#include "models/checkoutitemsmodel.h"
#include "models/useraccountsmodel.h"
#include "models/completermodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Singletons
    QmlInterface qmlInterface;
    StockItemsModel m_stockModel;
    CheckoutItemsModel m_checkoutItems;
    UserAccountsModel m_userAccounts;
    CompleterModel m_completer;

    engine.rootContext()->setContextProperty("QmlInterface", &qmlInterface);
    engine.rootContext()->setContextProperty("StockItemModel", &m_stockModel);
    engine.rootContext()->setContextProperty("CheckoutModel", &m_checkoutItems);
    engine.rootContext()->setContextProperty("AccountsModel", &m_userAccounts);
    engine.rootContext()->setContextProperty("CompleterModel", &m_completer);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
