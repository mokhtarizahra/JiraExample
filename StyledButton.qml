import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Control {
    id: root

    property color baseColor   : "#071e5f"
    property color hoverColor  : "#8faef0"
    property color disableColor: "#2a2a2a"
    property color textColor   : "#f7f7f7"
    property int   radius      : 10
    property int   fontSize    : 14
    property alias text        : btn.text
    property bool  disabled    : false

    signal clicked()

    width                      : btn.implicitWidth + 20
    height                     : btn.implicitHeight + 20

    contentItem: Button {
        id                     : btn
        enabled                : !root.disabled
        anchors.centerIn       : parent

        background             : Rectangle {
            radius             : root.radius
            color              : !btn.enabled ? root.disableColor
                               : btn.down ? Qt.lighter(root.baseColor, 1.3)
                               : btn.hovered ? root.hoverColor
                               : root.baseColor

            border.color       : btn.down || btn.hovered ? "transparent" : "#0a4364"
            border.width       : 2
        }

        contentItem: Text {
            text               : btn.text
            font.family        : "Times New Roman"
            font.pixelSize     : root.fontSize
            color              : !btn.enabled ? "#666"
                               : btn.down || btn.hovered ? "black"
                               : root.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment  : Text.AlignVCenter
        }

        onClicked              : root.clicked()
    }

    DropShadow {
        anchors.fill           : btn
        horizontalOffset       : 2
        verticalOffset         : 3
        radius                 : 10
        samples                : 16
        color                  : "#50000000"
        source                 : btn
        visible                : btn.enabled
    }
}
