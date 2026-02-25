import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12



Control {
    id: root
    property alias text            : field.text
    property alias placeholderText : field.placeholderText
    property int   fontSize        : 14
    property color baseColor       : "#b6edf4"
    property color hoverColor      : "#f7f7f7"
    property int   radius          : 10

    contentItem                    : TextField {
        id                         : field
        font.pixelSize             : root.fontSize
        color                      : "black"
        placeholderText            : root.placeholderText
        font.family                : "Times New Roman"

        background                 : Rectangle {
            radius                 : root.radius
            color                  : field.hovered || field.activeFocus ? root.hoverColor : root.baseColor
            border.color           : "black"
            border.width           : 2
        }
    }

    DropShadow {
        anchors.fill               : field
        horizontalOffset           : 2
        verticalOffset             : 3
        radius                     : 10
        samples                    : 16
        color                      : "#50000000"
        source                     : field
        visible                    : field.enabled
    }
}
