import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import "../delegates"
import "../components"

Window {
    id: myWindow

    property alias x: myWindow.x
    property alias y: myWindow.y
    property alias searchText: textField.text
    property alias currentIndex: completions.currentIndex

    flags:  Qt.Dialog | Qt.WindowCloseButtonHint
    modality: Qt.ApplicationModal
    color: bgColor
    width: 500
    height: 400

    onClosing: {
        close.accepted = false
        CompleterModel.addCompleterItems("")
        textField.text = ""
        close.accepted = true
    }


    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: 45

            RowLayout{
                anchors.fill: parent
                spacing: 5

                AppText
                {
                    Layout.alignment: Qt.AlignVCenter
                    horizontalAlignment: AppText.AlignLeft

                    text: qsTr("Item Name ")
                    color: QmlInterface.isDarkTheme? "grey":"#2e2e2e"
                }

                TextField
                {
                    id: textField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    verticalAlignment: TextInput.AlignBottom
                    horizontalAlignment: TextInput.AlignLeft
                    Layout.leftMargin: 5

                    color: QmlInterface.isDarkTheme? "#f4f4f4":"black"
                    font.pixelSize: 16
                    font.family: montserratFontLoader.name
                    selectByMouse: true
                    validator: RegExpValidator {regExp: RegExp("[a-zA-Z0-9]+")}

                    placeholderText: qsTr("Enter item Name")

                    onTextEdited: {
                        CompleterModel.addCompleterItems(text);
                    }

                }
            }
        }

        Rectangle {
            id: completionsBox
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.elevation: 6

            color: QmlInterface.isDarkTheme? "#29292d":"white"
            border.width: 1
            border.color: QmlInterface.isDarkTheme? "transparent":"silver"
            radius: 3

            ScrollView
            {
                width: completionsBox.width-6
                height: completionsBox.height-6
                anchors.centerIn: parent
                anchors.margins: 3

                clip: true
                spacing: 1

                ListView
                {
                    id: completions
                    width: parent.width - 5
                    height: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    currentIndex: -1
                    spacing: 1

                    model: CompleterModel
                    delegate: Component
                    {
                        AutocompleteDelegate
                        {
                            width: completions.width
                            label: model.name
                            labelIndex: model.index
                            isHighlighted: index === currentIndex

                            onClicked: currentIndex = index
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 45

            CheckBox
            {
                text: qsTr("Close dialog after adding item")
                checked: isDialogClosedAfterEachAdd



                onCheckStateChanged: isDialogClosedAfterEachAdd=checked
            }

            Rectangle
            {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                color: menuColor
                opacity: currentIndex === -1? 0.4:1
                enabled: currentIndex !== -1
                radius: 5
                height: 35
                width: 120

                RowLayout
                {
                    anchors.centerIn: parent
                    spacing: 10

                    AppText
                    {
                        Layout.alignment: Qt.AlignVCenter

                        text: qsTr("Add")
                        color: "white"
                    }

                    AppIcon
                    {
                        color: "white"
                        size: 16
                        icon: "\uf217"

                        Layout.alignment: Qt.AlignVCenter
                    }
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        StockItemModel.getItemData(CompleterModel.getKey(currentIndex))

                    }
                }
            }
        }
    }

    Connections
    {
        target: StockItemModel

        function onItemStockWarningChanged()
        {
            console.log(">> Stock is less to complete this add!")
        }

        function onItemDataChanged(status, jsonObj)
        {
            if(status)
            {
                console.log(">> Item Added to Checkout Model!")
                CheckoutModel.addSellItem(jsonObj["sellBarcode"], jsonObj["sellItemName"], jsonObj["sellItemUnit"], jsonObj["buyingPrice"], jsonObj["sellingPrice"], 1);

                searchText = "";
                currentIndex = -1;
                CompleterModel.addCompleterItems("");

                if(isDialogClosedAfterEachAdd)
                    myWindow.close()
            }

            else
                console.log(">> Failed to Add Item to Checkout Model!")
        }


    }
}