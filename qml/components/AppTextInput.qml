import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4 as Controls2

Item
{
    Layout.fillWidth: true
    Layout.preferredHeight: 30

    property alias label: textLabel.text
    property real prefWidth: 0
    property alias text: textInput.text
    property alias hintText: textInput.placeholderText

    RowLayout
    {
        anchors.fill: parent
        spacing: 10

        Item
        {
            Layout.fillHeight: true
            Layout.preferredWidth: prefWidth===0? textLabel.width:prefWidth

            AppText
            {
                id: textLabel
                color: "#555555"
                size: 15

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
            }
        }

        Controls2.TextField
        {
            id: textInput
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Controls2.TextField.AlignVCenter
            horizontalAlignment: Controls2.TextField.AlignLeft

            color: "black" //"#535353"
            font.pixelSize: 15
            font.family: montserratFontLoader.name
        }
    }
}
