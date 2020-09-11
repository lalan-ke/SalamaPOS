import QtQuick 2.3
import QtQuick.Layouts 1.3
import "../components"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    property bool isAnimationRunning: popupTimer.running

    RotationAnimation
    {
        target: ico
        from: 0
        to: 360
        duration: 1000
        loops: RotationAnimation.Infinite
        running: isAnimationRunning
    }

    Item
    {
        id: logo
        width: parent.width * 0.5
        height: width

        y: (parent.height - height)/3
        anchors.horizontalCenter: parent.horizontalCenter

        AppIcon
        {
            color: menuColor
            size: parent.height*0.75
            icon: "\uf78a"

            anchors.centerIn: parent
        }
    }

    AppText
    {
        color: menuColor
        text: qsTr("MySale Pro")
        font.pixelSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
    }

    Item
    {
        id: p
        height: 40
        width: parent.width

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100

        RowLayout
        {
            anchors.centerIn: parent
            spacing: 10

            AppIcon
            {
                id: ico
                color: menuColor
                size: p.height
                icon: "\uf110"

                Layout.alignment: Qt.AlignVCenter
            }

            AppText
            {
                color: "black"
                text: qsTr("Loading ...")
                font.pixelSize: 20

                Layout.alignment: Qt.AlignVCenter
            }
        }
    }

    AppText
    {
        color: "black"
        text: qsTr("(c)2020")
        font.pixelSize: 13

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
