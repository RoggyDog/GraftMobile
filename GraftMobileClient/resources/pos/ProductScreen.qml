import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.2

Item {
    ListView {
        id: productList
        anchors.fill: parent
        model: productModel
        delegate: productDelegate
    }

    Component {
        id: productDelegate
        ProductDelegate {
            width: productList.width
            productImage: image
            productName: name
            productPrice: cost
        }
    }

    RoundButton {
        id: addButton
        radius: 14
        topPadding: 15
        bottomPadding: 15
        highlighted: true
        Material.elevation: 0
        Material.accent: "#757575"
        anchors {
            bottom: parent.bottom
            bottomMargin: 94
            right: parent.right
            rightMargin: 40
            left: parent.left
            leftMargin: 40
        }
        text: qsTr("Checkout")
        font {
            family: "Liberation Sans"
            pointSize: 14
            capitalization: Font.MixedCase
        }
    }

    RoundButton {
        padding: 21
        width: height
        highlighted: true
        Material.elevation: 0
        Material.accent: "#d7d7d7"
        anchors {
            top: addButton.bottom
            topMargin: 20
            right: parent.right
            rightMargin: 5
            bottom: parent.bottom
            bottomMargin: 5
        }
        contentItem: Image {
            source: "qrc:/imgs/plus_icon.png"
        }
    }

    ListModel {
        id: productModel

        ListElement {
            name: "Hairout 1"
            image: "qrc:/examples/bob-haircuts.png"
            cost: 25
        }

        ListElement {
            name: "Hairout 2"
            image: "qrc:/examples/images.png"
            cost: 20
        }
    }
}