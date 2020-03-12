#ifndef GRAFTPOSHANDLERV3_H
#define GRAFTPOSHANDLERV3_H

#include "../graftposhandler.h"

class GraftPOSAPIv3;


class GraftPOSHandlerV3 : public GraftPOSHandler
{
    Q_OBJECT
public:
    // payment data to be scanned as qr-code by wallet;
    struct PaymentRequest
    {
        QString posWallet; // destination address for payment;
        QString posPubKey;
        QString walletEncryptionKey;
        QString blockHash;
        int blockHeight = 0;
        QString paymentId;
        QJsonObject toJson() const;
    };
    
    explicit GraftPOSHandlerV3(const QString &dapiVersion, const QStringList addresses,
                               QObject *parent = nullptr);

    void changeAddresses(const QStringList &addresses,
                         const QStringList &internalAddresses = QStringList()) override;

    void setAccountData(const QByteArray &accountData, const QString &password) override;
    void setNetworkManager(QNetworkAccessManager *networkManager) override;
    QByteArray accountData() const override;
    QString password() const override;

    void resetData() override;
    
    PaymentRequest paymentRequest() const;

public slots:
    void createAccount(const QString &password) override;
    void restoreAccount(const QString &seed, const QString &password) override;
    void updateBalance() override;
    void transferFee(const QString &address, const QString &amount,
                     const QString &paymentID = QString()) override;
    void transfer(const QString &address, const QString &amount,
                  const QString &paymentID = QString()) override;

    void sale(const QString &address, double amount,
              const QString &saleDetails = QString()) override;
    void rejectSale(const QString &pid) override;
    void saleStatus(const QString &pid, int blockNumber) override;
    void updateTransactionHistory() override;

private slots:
    void receiveSale(const QString &pid, int blockNumber);
    void receiveRejectSale(int result);
    void receiveSaleStatus(int status);
    void receiveBalance(double balance, double unlockedBalance);
    void receiveTransferFee(int result, double fee);
    void receiveTransfer(int result);

private:
    GraftPOSAPIv3 *mApi;
    QString mLastPID;
};

#endif // GRAFTPOSHANDLERV3_H
