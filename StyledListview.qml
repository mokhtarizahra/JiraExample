import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

Control {
    id: root

    property alias model                          : listView.model
    property alias currentIndex                   : listView.currentIndex
    property alias count                          : listView.count
    property int   rowHeight                      : 50
    property color selectedColor                  : "#B0E0E6"
    property color defaultColor                   : "#ffffff"
    property color borderColor                    : "black"
    property int   borderWidth                    : 2
    property int   fontSize                       : 14
    property color textColor                      : "black"
    property color headerColor                    : "#00CED1"

    property real  col0Width                      : 60
    property real  col1Width                      : 150
    property real  col2Width                      : 250
    property real  col3Width                      : 120

    ColumnLayout {
        anchors.fill                              : parent
        spacing                                   : 5

        // Header
        Rectangle {
            Layout.fillWidth                      : true
            height                                : 45
            radius                                : 10
            color                                 : root.headerColor
            border.color                          : root.borderColor
            border.width                          : root.borderWidth

            GridLayout {
                anchors.fill                      : parent
                anchors.margins                   : 10
                columns                           : 4
                rowSpacing                        : 0
                columnSpacing                     : 0

                Text { text                       : "Number"
                       font.bold                  : true
                       font.pixelSize             : root.fontSize+2
                       font.family                : "Times New Roman"
                       Layout.preferredWidth      : root.col0Width
                       horizontalAlignment        : Text.AlignHCenter
                       verticalAlignment          : Text.AlignVCenter
                }
                Text { text                       : "User Name"
                       font.bold                  : true
                       font.pixelSize             : root.fontSize+2
                       font.family                : "Times New Roman"
                       Layout.preferredWidth      : root.col1Width
                       horizontalAlignment        : Text.AlignHCenter
                       verticalAlignment          : Text.AlignVCenter
                }
                Text { text                       : "User ID"
                       font.bold                  : true
                       font.pixelSize             : root.fontSize+2
                       font.family                : "Times New Roman"
                       Layout.preferredWidth      : root.col2Width
                       horizontalAlignment        : Text.AlignHCenter
                       verticalAlignment          : Text.AlignVCenter
                }
                Text { text                       : "Status"
                       font.bold                  : true
                       font.pixelSize             : root.fontSize+2
                       font.family                : "Times New Roman"
                       Layout.preferredWidth      : root.col3Width
                       horizontalAlignment        : Text.AlignHCenter
                       verticalAlignment          : Text.AlignVCenter
                }
            }
        }

        // ListView
        ListView {
            id                                    : listView
            Layout.fillWidth                      : true
            Layout.fillHeight                     : true
            currentIndex                          : -1
            spacing                               : 5

            delegate                              : Rectangle {
                id                                : rowRect
                width                             : parent.width
                height                            : root.rowHeight
                color                             : listView.currentIndex === index ? root.selectedColor : root.defaultColor
                radius                            : 8
                border.color                      : root.borderColor
                border.width                      : root.borderWidth
                anchors.margins                   : 5

                layer.enabled                     : true
                layer.effect                      : DropShadow {
                    horizontalOffset              : 2
                    verticalOffset                : 2
                    radius                        : 8
                    samples                       : 16
                    color                         : "#50000000"
                }

                GridLayout {
                    anchors.fill                  : parent
                    anchors.margins               : 10
                    columns                       : 4
                    rowSpacing                    : 0
                    columnSpacing                 : 0

                    Text { text                   : (index + 1) + ". "
                           font.pixelSize         : root.fontSize
                           font.family            : "Times New Roman"
                           Layout.preferredWidth  : root.col0Width
                           horizontalAlignment    : Text.AlignHCenter
                           verticalAlignment      : Text.AlignVCenter
                           font.bold              : true
                    }
                    Text { text                   : model.name
                           font.pixelSize         : root.fontSize
                           font.family            : "Times New Roman"
                           Layout.preferredWidth  : root.col1Width
                           horizontalAlignment    : Text.AlignHCenter
                           verticalAlignment      : Text.AlignVCenter
                           font.bold              : true
                    }
                    Text {
                          text                    : model.description
                          font.pixelSize          : root.fontSize
                          font.family             : "Times New Roman"
                          Layout.preferredWidth   : root.col2Width
                          horizontalAlignment     : Text.AlignHCenter
                          verticalAlignment       : Text.AlignVCenter
                          font.bold               : true
                    }

                    RowLayout {
                        spacing                   : 5
                        Layout.alignment          : Qt.AlignVCenter | Qt.AlignLeft
                        Layout.preferredWidth     : root.col3Width
                        Layout.preferredHeight    : root.rowHeight

                        Image {
                            width                 : 20
                            height                : 20
                            source                : model.status === 2 ? "qrc:/Image/green-check-mark-icon.svg" :
                                                    model.status === 1 ? "qrc:/Image/loader-icon.svg"           :
                                                                         "qrc:/Image/incorrect-icon.svg"
                            fillMode              : Image.PreserveAspectFit
                            Layout.preferredWidth : width
                            Layout.preferredHeight: height
                        }

                        Text {
                            text                  : model.status === 2 ? "Lagin" :
                                                    model.status === 1 ? "Null"  :
                                                                         "Not Lagin"
                            font.family           : "Times New Roman"
                            font.pixelSize        : root.fontSize
                            verticalAlignment     : Text.AlignVCenter
                            font.bold             : true
                        }
                        Text {
                            id                    : timerText
                            text                  : "Timer : " + model.remainingTime
                            font.family           : "Times New Roman"
                            font.pixelSize        : root.fontSize
                            verticalAlignment     : Text.AlignVCenter
                            font.bold             : true
                        }
                    }


                }

                MouseArea { anchors.fill          : parent
                            onClicked             : listView.currentIndex = index
                }
            }
        }
    }
}
