import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtCore

Window {
    id: window
    width: Screen.desktopAvailableWidth * 0.6
    height: Screen.desktopAvailableHeight * 0.9
    x: Screen.desktopAvailableWidth
    visible: true
    title: fileName
    color: "#1e1e1e"

    Settings {
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }

    ScrollView {
        id: scroll
        width: parent.width
        height: parent.height


        contentWidth: width; contentHeight: text.height
        MouseArea {
            id: mouse
            anchors.fill: parent


        }

        TextEdit {
            id: text
            font.pointSize: 13
            font.wordSpacing: 1
            font.weight: 300
            width: parent.width
            leftPadding: 30; rightPadding: 30
            bottomPadding: 10; topPadding: 10
            selectByKeyboard: false
            text: fileText
            color: "#e3e3e4"
            textFormat: "MarkdownText"
            readOnly: true
            wrapMode: TextEdit.Wrap
            horizontalAlignment: TextEdit.AlignLeft
            ToolTip {
                id: hoverlink
                visible: false
                delay: 100
            }

            onLinkActivated: if(!Qt.openUrlExternally(link));
            onLinkHovered: {
                hoverlink.text = link
                hoverlink.visible = true
                hoverlink.x = mouse.x
                hoverlink.y = mouse.y
            }


        }
    }
}
