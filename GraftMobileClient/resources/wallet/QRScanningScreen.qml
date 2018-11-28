import QtQuick 2.9
import QtQuick.Dialogs 1.2
import com.device.platform 1.0
import "../components"
import "../"

BaseScreen {
    id: qrScanning
    title: qsTr("Pay")
    specialBackMode: Detector.isPlatform(Platform.IOS) ? pop : goBack

    Connections {
        target: qrScanning
        onAttentionAccepted: qRScanningView.resetView()
    }

    QRScanningView {
        id: qRScanningView
        anchors.fill: parent
        onQrCodeDetected: {
            if (GraftClient.isSaleQrCodeValid(message)) {
                GraftClient.saleDetails(message)
                pushScreen.openPaymentConfirmationScreen()
            } else {
                screenDialog.text = qsTr("QR Code data is wrong. \nPlease, scan correct QR Code.")
                screenDialog.open()
            }
        }
    }

    function pop() {
        qRScanningView.stopScanningView()
        goBack()
    }
}
