import QtQuick 2.9
import QtQuick.Controls 2.2
import com.device.platform 1.0

ApplicationWindow {
    id: root

    property bool allowClose: false
    property var handleBackEvent: null

    Connections {
        target: Detector
        onUpdateNeeded: {
            updatePopup.link = updateLink
            updatePopup.version = newVersion
            updatePopup.open()
        }
    }

    visible: true
    height: 683
    width: 384
    maximumHeight: 683
    maximumWidth: 384
    minimumHeight: 683
    minimumWidth: 384
    Component.onCompleted: init()

    Shortcut {
        sequences: Detector.isPlatform(Platform.Mobile) ? ["Esc", "Back"] : ["Esc", "Backspace"]
        onActivated: handleBackEvent()
    }

    PopupMessageLabel {
        id: closeLabel
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 60
            rightMargin: 60
            bottomMargin: 35
        }
        labelText: qsTr("Please, click again to close \nthe application.")
        opacityAnimator.onStopped: allowClose = false
    }

    UpdatePopup {
        id: updatePopup
        padding: 0
        topPadding: 0
        bottomPadding: 0
        width: root.width / 1.2
        height: contentHeight
        topMargin: (root.height - height) / 2
        leftMargin: (root.width - width) / 2
    }

    function init() {
        Detector.checkAppVersion()
        if (Detector.isPlatform(Platform.IOS)) {
            root.visibility = ApplicationWindow.FullScreen
        } else if (Detector.isPlatform(Platform.MacOS)) {
            root.flags = Qt.WindowTitleHint | Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint
        }
    }

    function showCloseLabel() {
        closeLabel.opacity = 1.0
        closeLabel.timer.start()
    }
}
