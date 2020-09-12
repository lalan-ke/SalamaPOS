import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4 as Controls2

import "../components"

Controls2.Popup
{
    id: root
    width: 450
    height: 500

    x: (mainApp.width - width)/2
    y: (mainApp.height - height)/2
    modal: true
    closePolicy: Controls2.Popup.NoAutoClose

    property bool isNewItemMode: true
    property int currentIndex: -1

    property string barCode: ""
    property string itemName: ""
    property string itemUnit: ""
    property real itemBp: -1
    property real itemSp: -1
    property real itemQty: -1
    property string itemCompany: ""

    property alias qty: qty

    onClosed: {
        barCode = ""
        itemName = ""
        itemUnit = ""
        itemBp = -1
        itemSp = -1
        itemQty = -1
        itemCompany = ""

        /*barcode.textInput.text = ""
        name.textInput.text = ""
        unit.textInput.text = ""
        bp.textInput.text = ""
        sp.textInput.text = ""
        qty.textInput.text = ""
        company.textInput.text = ""*/
    }

    contentItem: Rectangle
    {
        color: bgColor
        anchors.fill: parent


        ColumnLayout
        {
            anchors.fill: parent
            anchors.margins: 30

            Item
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                Rectangle
                {
                    color: "black"
                    height: 3
                    width: parent.width
                    opacity: 0.08

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                }

                AppText
                {
                    color: "black"
                    size: 17
                    text: isNewItemMode? qsTr("New Item Window"):qsTr("Update Item")

                    anchors.centerIn: parent
                }
            }

            Item
            {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout
                {
                    anchors.fill: parent
                    spacing: 10

                    AppTextInput
                    {
                        id: barcode
                        prefWidth: 150
                        label: qsTr("Item Barcode")
                        hintText: qsTr("Scan/enter barcode")
                        textInput.text: isNewItemMode? "":barCode
                    }

                    AppTextInput
                    {
                        id: name
                        prefWidth: 150
                        label: qsTr("Item Name")
                        hintText: qsTr("Enter item name")
                        textInput.text: isNewItemMode? "":itemName
                    }

                    AppTextInput
                    {
                        id: unit
                        prefWidth: 150
                        label: qsTr("Unit")
                        hintText: qsTr("Item unit, ie, 1kg, 1g")
                        textInput.text: isNewItemMode? "":itemUnit
                    }

                    AppTextInput
                    {
                        id: bp
                        prefWidth: 150
                        label: qsTr("Buying price")
                        hintText: qsTr("Enter bp in Ksh.")
                        textInput.text: isNewItemMode? "":itemBp
                    }

                    AppTextInput
                    {
                        id: sp
                        prefWidth: 150
                        label: qsTr("Selling price")
                        hintText: qsTr("Enter sp in Ksh.")
                        textInput.text: isNewItemMode? "":itemSp
                    }

                    AppTextInput
                    {
                        id: qty
                        prefWidth: 150
                        label: qsTr("Quantity")
                        hintText: qsTr("Enter quantity added")
                        textInput.text: isNewItemMode? "":itemQty
                    }

                    AppTextInput
                    {
                        id: company
                        prefWidth: 150
                        label: qsTr("Item's Company")
                        hintText: qsTr("Manufacturing company")
                        textInput.text: isNewItemMode? "":itemCompany
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30

                        RowLayout
                        {
                            anchors.fill: parent
                            spacing: 10

                            HorizontalSpacer {}

                            Rectangle
                            {
                                Layout.fillHeight: true
                                Layout.preferredWidth: 100

                                color: menuColor
                                radius: 3


                                AppText
                                {
                                    color: "white"
                                    size: 15
                                    text: qsTr("Cancel")

                                    anchors.centerIn: parent
                                }

                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked: root.close()
                                }
                            }

                            Rectangle
                            {
                                Layout.fillHeight: true
                                Layout.preferredWidth: 150

                                color: menuColor
                                radius: 3

                                RowLayout
                                {
                                    anchors.centerIn: parent

                                    spacing: 10

                                    AppIcon
                                    {
                                        color: "white"
                                        size: 15
                                        icon: "\uf067"
                                    }

                                    AppText
                                    {
                                        color: "white"
                                        size: 15
                                        text: isNewItemMode? qsTr("Add Item"):qsTr("Update Item")
                                    }
                                }

                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked: {
                                        var _barcode = barcode.textInput.text
                                        var _name = name.textInput.text
                                        var _unit = unit.textInput.text
                                        var _bp = bp.textInput.text
                                        var _sp = sp.textInput.text
                                        var _qty = qty.textInput.text
                                        var _company = company.textInput.text

                                        if(_barcode!=="" && _name !== "" && _unit!=="" && _bp!=="" && _sp!=="" && _qty!=="")
                                        {
                                            if(isNewItemMode)
                                                addNewItemToDb(_barcode,_name,_unit,_bp,_sp,_qty,_company);

                                            else
                                                updateItemInDb(_barcode,_name,_unit,_bp,_sp,_qty,_company);

                                        }

                                        else
                                        {
                                            console.log(new Date().getTime());
                                            console.log(new Date().toISOString());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function addNewItemToDb(_barcode,_name,_unit,_bp,_sp,_qty,_company)
    {
        var tmspt = new Date().getTime();
        StockItemModel.addNewItem(_barcode,_name, _unit, _bp, _sp, parseInt(_qty), _company, tmspt, 1 /*category*/);
    }

    function updateItemInDb(_barcode,_name,_unit,_bp,_sp,_qty,_company)
    {
        StockItemModel.updateItem(_barcode, _name, _unit, _bp, _sp, _company, 1/*category*/, barCode, currentIndex);
    }

    Connections
    {
        target: StockItemModel

        function onItemUpdatedChanged(status)
        {
            if(status)
            {
                console.log(">> Item Updated Successfuly!");
                root.close();
            }

            else
                console.log(">> Error Updating item");
        }

        function onItemAddingChanged(status)
        {
            if(status)
            {
                console.log(">> Item Added Successfuly!");
                root.close();
            }

            else
                console.log(">> Error Adding item");
        }
    }
}