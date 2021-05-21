/*
 * Copyright (c) 2020,2021 Panasonic Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import QtQuick 2.0

Item{
    id: menuRadioPanelRoot

    /* public properties */
    property alias icon: radioPanel.icon
    property alias title: radioPanel.title
    property alias channel: radioPanel.channel
    property alias bg: radioPanel.bg
    property alias mode: radioPanel.mode
    property alias panelVisible: radioPanel.visible
    visible: true

    /* public functions */
    function slideIn(direction){
        radioPanel.slideIn(direction)
    }

    function slideOut(direction){
        radioPanel.slideOut(direction)
    }

    Item {
        id: radioPanel
        width: 826
        height: 358
        property url icon:    ""
        property string title:   ""
        property string channel: ""
        property url bg:      ""

        property var mode: "normal" /* normal or adas */
        property double slideDirection: 1 /* +1:Right -1:Left */

        FontLoader { id: localFont; source: "qrc:/Fonts/Inter-Regular.ttf" }

        onModeChanged: {
            if(mode === "normal"){
                adasToNormalAnimationRadio.start()
            }else if(mode === "adas"){
                normalToAdasAnimationRadio.start()
            }
        }

        function slideIn(direction){
            slideDirection = direction

            if(delayTimer.running){
                delayTimer.stop()
            }

            inAnimation.start()

            delayTimer.start()
        }

        function slideOut(direction){
            slideDirection = direction
            if(delayTimer.running){
                delayTimer.stop()
            }

            outAnimation.start()
        }


        Timer {
            id: delayTimer
            interval: 330
            repeat: false
            running: false
            onTriggered: {
                blurFadeInAnimation.start()
            }
        }

        Item{
            width:826
            height: 358

            Image {
                id: bgImage
                width:826
                height:358
                source: bg
            }
            Image {
                id: iconImage
                width: 112
                height: 112
                x:172
                y:194
                source: icon
            }
            Text {
                id: titleText
                y:226
                color: "white"
                font { family: localFont.name; pointSize: 20; capitalization: Font.Capitalize }
                anchors.horizontalCenterOffset: -59
                anchors.horizontalCenter: parent.horizontalCenter
                text: title
                property var anchor: "center"

                onAnchorChanged: {
                    if(anchor === "center"){
                        changeAnchorsToCenter()
                    }else if(anchor === "left"){
                        changeAnchorsToLeft()
                    }
                }

                function changeAnchorsToCenter(){
                    anchors.leftMargin = 0
                    anchors.left = undefined
                    anchors.horizontalCenter = parent.horizontalCenter
                    anchors.horizontalCenterOffset = -59
                }

                function changeAnchorsToLeft(){
                    anchors.horizontalCenterOffset = 0
                    anchors.horizontalCenter = undefined
                    anchors.left = parent.left
                    anchors.leftMargin = 302
                }
            }
            Text {
                id:channelName
                y:256
                color: "white"
                font { family: localFont.name; pointSize: 20; capitalization: Font.Capitalize }
                anchors.horizontalCenterOffset: -59
                anchors.horizontalCenter: parent.horizontalCenter
                text: channel
                property var anchor: "center"

                onAnchorChanged: {
                    if(anchor === "center"){
                        changeAnchorsToCenter()
                    }else if(anchor === "left"){
                        changeAnchorsToLeft()
                    }
                }

                function changeAnchorsToCenter(){
                    anchors.leftMargin = 0
                    anchors.left = undefined
                    anchors.horizontalCenter = parent.horizontalCenter
                    anchors.horizontalCenterOffset = -59
                }

                function changeAnchorsToLeft(){
                    anchors.horizontalCenterOffset = 0
                    anchors.horizontalCenter = undefined
                    anchors.left = parent.left
                    anchors.leftMargin = 302
                }
            }
        }

        PropertyAnimation {
            id:outAnimation
            target: radioPanel
            property: "visible"
            duration: 0
            to: false
        }

        ParallelAnimation{
            id:inAnimation

            NumberAnimation {
                target: bgImage
                property: "opacity"
                duration: 0
                to:0
            }

            PropertyAnimation {
                target: radioPanel
                property: "visible"
                duration: 0
                to: true
            }
            NumberAnimation {
                target: iconImage
                property: "x"
                duration: 260
                from:if(radioPanel.mode === "normal"){
                         301 - 20 * radioPanel.slideDirection
                     }else if(mode === "adas"){
                         172 - 20 * radioPanel.slideDirection
                     }
                to: if(radioPanel.mode === "normal"){
                        301
                    }else if(radioPanel.mode === "adas"){
                        172
                    }
                easing.type: Easing.OutSine
            }
        }


        PropertyAnimation {
            id: blurFadeInAnimation

            target: bgImage
            property: "opacity"
            duration: 330
            from:0
            to:1
            easing.type: Easing.Linear
        }
    }

    SequentialAnimation{
        id:normalToAdasAnimationRadio

        PropertyAnimation {
            target: bgImage
            property: "visible"
            duration: 0
            to:1
        }

        PropertyAnimation{
            target: iconImage
            property: "x"
            duration: 0
            to: 172
        }
        PropertyAnimation{
            target: iconImage
            property: "y"
            duration: 0
            to: 194
        }

        PropertyAnimation {
            target: titleText
            property: "anchor"
            duration: 0
            to: "left"
        }
        PropertyAnimation{
            target: titleText
            property: "y"
            duration: 0
            to: 226
        }

        PropertyAnimation {
            target: channelName
            property: "anchor"
            duration: 0
            to: "left"
        }
        PropertyAnimation{
            target: channelName
            property: "y"
            duration: 0
            to: 256
        }
    }

    SequentialAnimation{
        id:adasToNormalAnimationRadio

        PropertyAnimation {
            target: bgImage
            property: "visible"
            duration: 0
            to:0
        }

        PropertyAnimation{
            target: iconImage
            property: "x"
            duration: 0
            to: 301
        }
        PropertyAnimation{
            target: iconImage
            property: "y"
            duration: 0
            to: 156
        }

        PropertyAnimation{
            target: titleText
            property: "y"
            duration: 0
            to: 308
        }
        PropertyAnimation {
            target: titleText
            property: "anchor"
            duration: 0
            to: "center"
        }

        PropertyAnimation{
            target: channelName
            property: "y"
            duration: 0
            to: 336
        }
        PropertyAnimation {
            target: channelName
            property: "anchor"
            duration: 0
            to: "center"
        }
    }
}
