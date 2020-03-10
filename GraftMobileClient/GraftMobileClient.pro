QT += qml quick network webview

win32|macx {
QT += widgets
}

CONFIG += c++11
CONFIG -= qtquickcompiler

DEFINES += MAJOR_VERSION=1
DEFINES += MINOR_VERSION=16
DEFINES += BUILD_VERSION=0

win32|macx|unix {
DEFINES += RES_IOS

DESTDIR = ./bin
}

contains(DEFINES, POS_BUILD) {
TARGET = GraftPointOfSale
}
contains(DEFINES, WALLET_BUILD) {
TARGET = GraftWallet
}

include($$PWD/3rdparty/openssl/openSSL.pri)

ios {
include(ios/ios.pri)
}

android {
include(android/android.pri)
}

include(qzxing/QZXing.pri)
include(QRCodeGenerator.pri)
include(libwallet/libwallet.pri)
ios|macx {
include(core/api/v2/graftapiv2.pri)
}

contains(DEFINES, POS_BUILD) {
ios|android {
include(imagepicker/ImagePickerLibrary.pri)
}

SOURCES += \
    #core/api/v1/graftposapiv1.cpp \
    #core/api/v1/graftposhandlerv1.cpp \
    core/graftposclient.cpp

HEADERS += \
    #core/api/v1/graftposapiv1.h \
    #core/api/v1/graftposhandlerv1.h \
    core/api/graftposhandler.h \
    core/graftposclient.h \
    core/defines.h

DISTFILES += $$PWD/pos_update.xml
}

contains(DEFINES, WALLET_BUILD) {
SOURCES += \
    #core/api/v1/graftwalletapiv1.cpp \
    #core/api/v1/graftwallethandlerv1.cpp \
    core/graftwalletclient.cpp

HEADERS += \
    #core/api/v1/graftwalletapiv1.h \
    #core/api/v1/graftwallethandlerv1.h \
    core/api/graftwallethandler.h \
    core/graftwalletclient.h

DISTFILES += $$PWD/wallet_update.xml
}

include(core/api/v3/graftapiv3.pri)


win32|macx {
!contains(DEFINES, DISABLE_SPARKLE_UPDATER) {
CONFIG(release, debug|release) {
include(3rdparty/sparkle/sparkleUpdater.pri)
}
}
}

win32 {
include(windows/windows.pri)
}

macx {
include(mac/mac.pri)
}

SOURCES += main.cpp \
    #core/api/v1/graftgenericapiv1.cpp \
    core/productmodel.cpp \
    core/productitem.cpp \
    core/productmodelserializator.cpp \
    core/graftbaseclient.cpp \
    core/barcodeimageprovider.cpp \
    core/carditem.cpp \
    core/cardmodel.cpp \
    core/keygenerator.cpp \
    core/selectedproductproxymodel.cpp \
    core/currencymodel.cpp \
    core/currencyitem.cpp \
    core/accountitem.cpp \
    core/accountmodel.cpp \
    core/quickexchangeitem.cpp \
    core/quickexchangemodel.cpp \
    core/accountmodelserializator.cpp \
    core/accountmanager.cpp \
    core/graftclienttools.cpp \
    core/qrcodegenerator.cpp \
    core/graftclientconstants.cpp \
    core/blogreader.cpp \
    core/feedmodel.cpp \
    devicedetector.cpp \
    designfactory.cpp \
    navigationproperties.cpp \
    abstractdevicetools.cpp \
    core/txhistory/TransactionHistory.cpp \
    core/txhistory/TransactionHistoryModel.cpp \
    core/txhistory/TransactionInfo.cpp 
    

HEADERS += \
    core/config.h \
    #core/api/v1/graftgenericapiv1.h \
    core/api/graftbasehandler.h \
    core/productmodel.h \
    core/productitem.h \
    core/productmodelserializator.h \
    core/graftbaseclient.h \
    core/barcodeimageprovider.h \
    core/carditem.h \
    core/cardmodel.h \
    core/keygenerator.h \
    core/selectedproductproxymodel.h \
    core/currencymodel.h \
    core/currencyitem.h \
    core/accountitem.h \
    core/accountmodel.h \
    core/quickexchangeitem.h \
    core/quickexchangemodel.h \
    core/accountmodelserializator.h \
    core/accountmanager.h \
    core/graftclienttools.h \
    core/qrcodegenerator.h \
    core/graftclientconstants.h \
    core/feedmodel.h \
    core/blogreader.h \
    devicedetector.h \
    designfactory.h \
    navigationproperties.h \
    abstractdevicetools.h \
    sparkle.h \
    core/txhistory/TransactionHistory.h \
    core/txhistory/TransactionHistoryModel.h \
    core/txhistory/TransactionInfo.h \
    core/txhistory/Transfer.h 


include(resources/resources.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
