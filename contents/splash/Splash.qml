/*   This is developed on top of Breath2 Splash Screen by "Manjaro Team, Bogdan Covaciu and David Linares (Mcder3)"
 *   and Old_Worldmap Playmouth theme by pegellinux
 *
 *   Copyright 2021 M H R V K REDDY <Hariram.M@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 3,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {
    id: root
    source: "images/World_Map.png"
    fillMode: Image.PreserveAspectCrop

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
        if (stage == 6) {
            preLoadingText.from = 0;
            preLoadingText.to = 1;
            preLoadingText.running = true;
        }
        if (stage == 7) {
            preLoadingText.from = 1;
            preLoadingText.to = 0;
            preLoadingText.running = true;
        }
    }

    Item {
        id: content
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        opacity: 1
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            property real size: units.gridUnit * 12
            x: (root.width - width) / 2
            y: (root.height - height) / 2
            source: "images/logo.svg"
            sourceSize.width: size
            sourceSize.height: size
        }
    }

        Text {
            id: date
            text:Qt.formatDateTime(new Date(),"dddd, hh:mm")
            font.pointSize: 32
            color: "#FFFFFF"
            opacity:1
            font { family: "Noto Sans"; weight: Font.Bold}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 30
        }

    Image {
        id: topRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height
        source: "images/rectangle.svg"
        Rectangle {
            y: 232
            radius: 0
            anchors.horizontalCenterOffset: 0
            color: "#212529"
            anchors {
                bottom: parent.bottom
                bottomMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            height: 10
            width: height*30
            Rectangle {
                id: topRectRectangle
                radius: 1
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 0.01)
                color: "#9E471A"
                Behavior on width {
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    SequentialAnimation {
        id: introAnimation
        running: false

        ParallelAnimation {
            PropertyAnimation {
                property: "y"
                target: topRect
                to: ((root.height / 3) * 2) - 75
                duration: 1500
                easing.type: Easing.InOutBack
                easing.overshoot: 0.5
            }

        }
    }

    Text {
        id: preloadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "Enjoy The Simplicity"
        color: "#FFFFFF"
        font.family: webFont.name
        font.weight: Font.Light

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: ((root.height / 3) * 2) + 140
    }

    OpacityAnimator {
        id: preLoadingText
        running: false
        target: preloadingText
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
    }
}
