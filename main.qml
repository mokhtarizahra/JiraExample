import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12



ApplicationWindow {
    id        : mainWindow
    visible   : true
    background: Rectangle {
    color     : "#a8bfcf"
    }
    width     :  Math.min(Screen.width  * 0.9 , 900)
    height    : Math.min(Screen.height * 0.8 , 800)

    title     : qsTr("Show information User")

    flags     :Qt.CustomizeWindowHint |Qt.WindowTitleHint


    Item {
        anchors.fill: parent

        GridLayout { anchors.fill  : parent
                     rows          : 2

            StyledListview {
                id                 : tasklist
                model              : modeljira
                rowHeight          : 60
                Layout.row         : 0
                Layout.margins     : 10
                Layout.fillWidth   : true
                Layout.fillHeight  : true
                selectedColor      : "#ffe4b6"
                defaultColor       : "#ffffff"
                textColor          : "#000000"
                fontSize           : 16
            } // ListView

            RowLayout {
                Layout.row         : 1
                Layout.fillWidth   : true
                spacing            : 10
                Layout.margins     : 10

                StyledButton {
                    text           : "Add User"
                    onClicked      : dialog1.open()
                }

                StyledButton {
                    text           : "Edit Information"
                    enabled        : tasklist.count > 0 && tasklist.currentIndex >= 0
                    onClicked      :
                    {
                                      var row = tasklist.currentIndex
                                      dialog2.open()
                                      var task = modeljira.getTask(row)

                                      dialog2.nameFieldText = task.name
                                      dialog2.descFieldText = task.description
                                      dialog2.statusIndex   = task.status ? 2 : 0

                                      dialog2.rowToedit     = row
                    }
                }

                StyledButton {
                    text           : "Clear Users"
                    enabled        : tasklist.count>0
                    onClicked      : modeljira.clear()
                }

                StyledButton {
                    text           : "Remove User"
                    enabled        : tasklist.count>0 && tasklist.count >=0
                    onClicked      : modeljira.removeTask()
                }

                Item {Layout.fillWidth: true }

                StyledButton {
                    text           : "Close"
                    onClicked      : mainWindow.close()
                }

            } // RowLayout

        } // GridLayout

        StyledDialog {
            id                     :dialog1
            title                  : "New User"
            width                  : mainWindow.width * 0.4
            height                 : mainWindow.height * 0.4
            x                      : (mainWindow.width - width) / 2
            y                      : (mainWindow.height - height) / 2

            onOpenedDialog         : {
                nameFieldText = ""
                descFieldText = ""
                statusIndex   = 0 }

            onSaveRequested: {
                var status = (statusIndex === 2)
                modeljira.createTask(nameFieldText, descFieldText , status)
                dialog1.close()
            }
        }//Dialog1

        StyledDialog {
            id                      :dialog2
            title                   : "Edit Information User"
            width                   : mainWindow.width * 0.4
            height                  : mainWindow.height * 0.4
            x                       : (mainWindow.width - width) / 2
            y                       : (mainWindow.height - height) / 2

            property int rowToedit  : -1

            okButtonText            : "Save Changes"

            onSaveRequested: {
                var index = modeljira.index(dialog2.rowToedit, 0)
                modeljira.setData(index, nameFieldText, modeljira.NameRole)
                modeljira.setData(index, descFieldText, modeljira.DescriptionRole)
                modeljira.setData(index, statusIndex === 2, modeljira.StatusRole); dialog1.close()
            }

            }//Dialog2

        } // Item
    } // Window
