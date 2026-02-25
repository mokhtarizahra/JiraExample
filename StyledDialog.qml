import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12


Popup {
    id: root
    modal: true

    property string title            : ""
    property alias nameFieldText     : nameField.text
    property alias descFieldText     : descField.text
    property alias statusIndex       : statusCombo.currentIndex

    property alias okButtonText      : okBtn.text
    property alias cancleokButtonText: cancleBtn.text


    signal openedDialog()
    signal saveRequested()

    closePolicy                      : Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background                       : Rectangle {
        id                           : wrapper
        radius                       : 12
        color                        : "#b6edf4"
        border.color                 : "#0a0b0b"
        border.width                 : 2
    }

    contentItem                      : GridLayout {
        id                           : contentLayout
        anchors.fill                 : parent
        anchors.margins              : 20
        columns                      : 1
        rowSpacing                   : 10

        Text {
            visible                  : title !== ""
            text                     : title
            font.bold                : true
            font.pixelSize           : 18
            font.family              : "Times New Roman"
            horizontalAlignment      : Text.AlignHCenter
            Layout.fillWidth         : true
        }

        StyledTextField {
            id                       : nameField
            placeholderText          : "User Name"
            Layout.fillWidth         : true
        }

        StyledTextField {
            id                       : descField
            placeholderText          : "User ID"
            Layout.fillWidth         : true
        }

        StyledCombobox {
            id                       : statusCombo
            model                    : ["Not Lagin", "Null", "Lagin"]
            Layout.fillWidth         : true
        }

        RowLayout {
            Layout.alignment         : Qt.AlignRight

            StyledButton {
                id                   : okBtn
                text                 : "Save"
                onClicked            : saveRequested()
            }

            Item { Layout.fillWidth: true }

            StyledButton {
                id                   :cancleBtn
                text                 : "Cancel"
                onClicked            : root.close()
            }
        }

        layer.enabled                : true
        layer.effect                 : DropShadow {
            horizontalOffset         : 2
            verticalOffset           : 3
            radius                   : 10
            samples                  : 16
            color                    : "#50000000"
        }
    }

    onOpened                         : openedDialog()


}
