#ifndef CHECKOUTITEMSMODEL_H
#define CHECKOUTITEMSMODEL_H

#include <QObject>
#include <QDebug>
#include <QAbstractListModel>
#include "src/checkoutitems.h"

class CheckoutItemsModel : public QAbstractListModel
{
    Q_OBJECT

    enum SellItemRoles{
        SellBarcodeRole = Qt::UserRole+1,
        SellItemNameRole,
        SellItemUnitRole,
        SellItemBpRole,
        SellItemSpRole,
        SellQtyRole
    };

public:
    explicit CheckoutItemsModel(QObject *parent = nullptr);

    // QAbstractListModel overrides
    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role) const;

    bool setData(const QModelIndex &index, const QVariant &value, int role);

    Qt::ItemFlags flags(const QModelIndex &index) const;

    QHash<int, QByteArray> roleNames() const;

    // Properties
    Q_PROPERTY(int sellTotals READ sellTotals WRITE setSellTotals NOTIFY sellTotalsChanged)

    Q_PROPERTY(int checkoutModelSize READ checkoutModelSize WRITE setCheckoutModelSize NOTIFY checkoutModelSizeChanged)

    // Invokables
    Q_INVOKABLE void removeSellItem(int index);

    Q_INVOKABLE void addSellItem(const QVariant sellBarcode, const QVariant  sellItemName, const QVariant  sellItemUnit, const QVariant  buyingPrice, const QVariant  sellingPrice, const QVariant sellQty);

    Q_INVOKABLE void changeSellStock(const QVariant &qty, const QVariant &barcode);

    Q_INVOKABLE void startANewSell();

    Q_INVOKABLE void findTotals();

    Q_INVOKABLE QString getBarcodeAt(int index);

    Q_INVOKABLE int getSellQtyAt(int index);

    // internals
    int checkoutModelSize() const;

    void addItem(CheckoutItems * checkout);

    int sellTotals() const;

    void setSellTotals(int sellTotals);

    int checkIfItemExistsInModel(const QString &barcode);

    void setCheckoutModelSize(int checkoutModelSize);

signals:

    void sellTotalsChanged(int sellTotals);
    void saleQtyChanged(bool state);
    void checkoutModelSizeChanged(int checkoutModelSize);
    void logDataChanged(QString level, QString info);

private:
    QList<CheckoutItems *> mCheckoutItem;

    int m_sellTotals = 0;

    int m_checkoutModelSize;
};

#endif // CHECKOUTITEMSMODEL_H
