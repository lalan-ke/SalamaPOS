import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4 as Controls2

import "../components"

Item {
    id: root

    Layout.fillWidth: true
    Layout.fillHeight: true

    Controls2.ScrollView
    {
        anchors.fill: parent
        anchors.margins: 10

        clip: true

        ColumnLayout
        {
            anchors.fill: parent
            width: root.width*0.9
            height: root.height*0.8
            spacing: 10

            Controls2.GroupBox
            {
                Layout.fillWidth: true
                Layout.minimumWidth: root.width-50
                Layout.preferredHeight: 80

                label: AppText
                {
                    color: "#535353"
                    size: 16
                    font.bold: true
                    text: qsTr("Theme")
                }

                RowLayout
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left

                    width: parent.width
                    spacing: 10
                    height: 30

                    AppText
                    {
                        color: "#535353"
                        size: 16
                        text: qsTr("Which theme do you prefer?  ")
                    }

                    Controls2.ComboBox
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        model: ["Light Theme (Default)", "Dark Theme"]
                    }
                }
            }

            Controls2.GroupBox
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 80

                label: AppText
                {
                    color: "#535353"
                    size: 16
                    font.bold: true
                    text: qsTr("Sounds & Notifications")
                }

                RowLayout
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left

                    width: parent.width
                    spacing: 10
                    height: 30

                    AppText
                    {
                        color: "#535353"
                        size: 16
                        text: qsTr("How should notification sounds be played? ")
                    }

                    Controls2.ComboBox
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        model: ["Play on important notifications (Default)", "Play on all notifications", "Don't play on any notification"]
                    }
                }
            }

            Controls2.GroupBox
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 300

                label: AppText
                {
                    color: "#535353"
                    size: 16
                    font.bold: true
                    text: qsTr("Organization")
                }

                ColumnLayout
                {
                    anchors.fill: parent
                    spacing: 5

                    AppTextInput
                    {
                        label: qsTr("Organization Name")
                        textInput.placeholderText: qsTr("Enter organization name")
                    }

                    AppTextInput
                    {
                        label: qsTr("Organization Slogan")
                        textInput.placeholderText: qsTr("Enter organization slogan/motto")
                    }

                    AppTextInput
                    {
                        label: qsTr("Organization Address")
                        textInput.placeholderText: qsTr("Enter organization postal address")
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30

                        RowLayout
                        {
                            anchors.fill: parent
                            spacing: 10

                            AppTextInput
                            {
                                label: qsTr("Organization Logo")
                                textInput.placeholderText: qsTr("Path to organization logo")
                            }

                            Controls2.Button
                            {
                                Layout.preferredWidth: 100
                                Layout.fillHeight: true

                                text: qsTr("Browse")

                            }
                        }
                    }
                }
            }

            Item
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                RowLayout
                {
                    anchors.fill: parent
                    spacing: 10

                    HorizontalSpacer {}

                    Controls2.Button
                    {
                        text: qsTr("Cancel")

                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 100
                    }

                    Controls2.Button
                    {
                        text: qsTr("Apply Changes")

                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 200
                    }
                }
            }

            VerticalSpacer {}
        }

    }
}