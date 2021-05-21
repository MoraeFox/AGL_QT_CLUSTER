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
import QtGraphicalEffects 1.0

Item{
    /* public properties */
    property alias icon: menuFrame.icon
    property alias txt: menuFrame.txt
    property alias position: menuFrame.position
    property alias mode: menuFrame.mode

    /* public functions */
    function upScroll(){
        menuFrame.upScroll()
    }

    function downScroll(){
        menuFrame.downScroll()
    }

    function open(){
        menuFrame.open()
    }

    function close(){
        menuFrame.close()
    }


    Item{
        id:menuFrame

        property string icon: ""
        property string txt: ""
        property var position: -1
        property var mode: "normal"     /* normal or adas */

        property double direction: +1   /* +1:Left -1:Right */
        property int margin: 0

        FontLoader { id: localFont; source: "qrc:/Fonts/Inter-Regular.ttf" }

        onModeChanged: {
            if(mode === "normal"){
                direction = +1
                margin = 0
            } else if(mode === "adas"){
                direction = -1
                margin = 380
            } else {
                direction = +1
                margin = 0
            }

            menuFrame.x = 0
            menuFrameItem.resetPosition()
        }

         onPositionChanged: {
            if(menuFrameItem.isInited === 0){
                menuFrameItem.resetPosition()
                menuFrameItem.isInited = 1
            }
        }


        function upScroll(){
            if(position === 0){
                position = 5
            }
            else if(position === 1){
                animationMenuScrollTo0.start()
                position = 0
            }
            else if(position === 2){
                animationMenuScrollTo1.start()
                position = 1
            }
            else if(position === 3){
                animationMenuScrollTo2.start()
                position = 2
            }
            else if(position === 4){
                animationMenuScrollTo3.start()
                position = 3
            }
            else if(position === 5){
                animationMenuScrollTo4.start()
                position = 4
            }
        }

        function downScroll(){
            if(position === 0){
                animationMenuScrollTo1.start()
                position = 1
            }
            else if(position === 1){
                animationMenuScrollTo2.start()
                position = 2
            }
            else if(position === 2){
                animationMenuScrollTo3.start()
                position = 3
            }
            else if(position === 3){
                animationMenuScrollTo4.start()
                position = 4
            }
            else if(position === 4){
                position = 5
            }
            else if(position === 5){
                animationMenuScrollTo0.start()
                position = 0
            }
        }

        function open(){
            animationMenuOpen.start()
        }

        function close(){
            animationMenuClose.start()
        }


        Item{
            id: menuFrameItem

            property double direction: menuFrame.direction
            property int margin: menuFrame.margin
            property int isInited: 0

            function resetPosition(){
                if(position === 0){
                    menuFrameBgTop.opacity = 1.0
                    menuFrameBg.width = 460
                    menuFrameBg.height = 116*0.4
                    menuIcon.scale = 0.4
                    menuFrameBg.x = 0
                    menuIcon.x = 26 * 0.4 * menuFrameItem.direction + menuFrameItem.margin
                    menuText.scale = 0.4
                    menuText.x = 122 * 0.4 * menuFrameItem.direction + menuFrameItem.margin
                    menuFrameItem.opacity = 0
                    menuFrameItem.x = 100 * menuFrameItem.direction
                    menuFrameItem.y = -68
                }
                if(position === 1){
                    menuFrameBgTop.opacity = 1.0
                    menuFrameBg.width = 460
                    menuFrameBg.height = 116*0.5
                    menuFrameBg.x = 0
                    menuIcon.scale = 0.5
                    menuIcon.x = 26 * 0.5 * menuFrameItem.direction + menuFrameItem.margin
                    menuText.scale = 0.5
                    menuText.x = 122 * 0.5 * menuFrameItem.direction + menuFrameItem.margin
                    menuFrameItem.opacity = 1
                    menuFrameItem.x = 50 * menuFrameItem.direction
                    menuFrameItem.y = -48
                }
                if(position === 2){
                    menuFrameBgCenter.opacity = 1.0
                    menuFrameBg.width = 460
                    menuFrameBg.height = 116
                    menuFrameBg.x = 0
                    menuIcon.x = 26 * menuFrameItem.direction + menuFrameItem.margin
                    menuText.x = 122 * menuFrameItem.direction + menuFrameItem.margin
                    menuFrameItem.opacity = 1
                    menuFrameItem.x = 0
                    menuFrameItem.y = 0
                }

                if(position === 3){
                    menuFrameBgBottom.opacity = 1.0
                    menuFrameBg.width = 460 - 50
                    menuFrameBg.height = 74
                    if(menuFrameItem.direction === +1) {
                        menuFrameBg.x = 0
                    } else {
                        menuFrameBg.x = 50
                    }
                    menuIcon.scale = (74/116)
                    menuIcon.x = 26 * (74/116) * menuFrameItem.direction + menuFrameItem.margin
                    menuText.scale = (74/116)
                    menuText.x = 122 * (74/116) * menuFrameItem.direction + menuFrameItem.margin
                    menuFrameItem.opacity = 1
                    menuFrameItem.x = 100 * menuFrameItem.direction
                    menuFrameItem.y = 104
                }
                if(position === 4){
                    menuFrameBgBottom.opacity = 1.0
                    menuFrameBg.width = 460 - 50
                    menuFrameBg.height = 116*(0.7)
                    if(menuFrameItem.direction === +1) {
                        menuFrameBg.x = 0
                    } else {
                        menuFrameBg.x = 50
                    }
                    menuIcon.scale = (0.7)
                    menuIcon.x = 26 * (0.7) * menuFrameItem.direction + menuFrameItem.margin
                    menuText.scale = (0.7)
                    menuText.x = 122 * (0.7) *menuFrameItem.direction + menuFrameItem.margin
                    menuFrameItem.opacity = 0
                    menuFrameItem.x = 160 * menuFrameItem.direction
                    menuFrameItem.y = 140
                }
                if(position === 5){
                    menuFrameBgBottom.opacity = 1.0
                    menuFrameBg.width = 460 - 50
                    menuFrameBg.height = 116*(0.7)
                    if(menuFrameItem.direction === +1) {
                        menuFrameBg.x = 0
                    } else {
                        menuFrameBg.x = 50
                    }
                    menuIcon.scale = (0.7)
                    menuIcon.x = 26 * (0.7) * menuFrameItem.direction + menuFrameItem.margin
                    menuText.scale = (0.7)
                    menuText.x = 122 * (0.7) * menuFrameItem.direction + menuFrameItem.margin
                    menuFrameItem.opacity = 0
                    menuFrameItem.x = 160 * menuFrameItem.direction
                    menuFrameItem.y = 140
                }
            }


            Item{
                id: menuFrameBg
                x:0
                y:0
                width: 460
                height: 116
                Image{
                    id: menuFrameBgTop
                    anchors.fill: parent
                    source: "qrc:/Images/NormalView/MENU/menu_panel1.png"
                    opacity: 0
                }
                Image{
                    id: menuFrameBgCenter
                    anchors.fill: parent
                    source: "qrc:/Images/NormalView/MENU/menu_panel2.png"
                    opacity: 0
                }
                Image{
                    id: menuFrameBgBottom
                    anchors.fill: parent
                    source: "qrc:/Images/NormalView/MENU/menu_panel3.png"
                    opacity: 0
                }
            }

            Image{
                id: menuIcon
                source:menuFrame.icon
                x: 26 * direction + margin
                width: 76
                height: 90
                anchors.verticalCenter: menuFrameBg.verticalCenter
            }

            Text {
                id: menuText
                x: 122 * direction + margin
                width: 68
                height: 26
                y:46
                text: menuFrame.txt
                font { family: localFont.name; pointSize: 20; capitalization: Font.Capitalize }
                anchors.verticalCenter: menuFrameBg.verticalCenter
                color: "white"

            }

            MenuFrameScrollTo0{
                id:animationMenuScrollTo0
                scrollDuration: 330
            }

            MenuFrameScrollTo1{
                id:animationMenuScrollTo1
                scrollDuration: 330
            }

            MenuFrameScrollTo2 {
                id:animationMenuScrollTo2
                scrollDuration: 330
            }

            MenuFrameScrollTo3 {
                id:animationMenuScrollTo3
                scrollDuration: 330
            }

            MenuFrameScrollTo4{
                id:animationMenuScrollTo4
                scrollDuration: 330
            }


            /* Open */
            SequentialAnimation{
                id:animationMenuOpen

                NumberAnimation{
                    target: menuFrame
                    property: "x"
                    to: 360 * menuFrameItem.direction
                    duration: 0
                }

                PropertyAnimation{
                    target: menuFrame
                    property: "visible"
                    from:false
                    to: true
                    duration: 0
                }

                PauseAnimation {
                    duration: if(position === 0){
                                  0
                              }else if(position === 1){
                                  48
                              }else if(position === 2){
                                  96
                              }else if(position === 3){
                                  144
                              }else if(position === 4){
                                  0
                              }else if(position === 5){
                                  0
                              }
                }

                NumberAnimation{
                    target: menuFrame
                    property: "x"
                    from: 360 * menuFrameItem.direction
                    to: 0
                    duration: 260
                    easing.type: Easing.InQuad
                }

            }

            SequentialAnimation{
                id:animationMenuClose

                NumberAnimation{
                    target: menuFrame
                    property: "x"
                    to: 0
                    duration: 0
                }

                PauseAnimation {
                    duration: if(position === 0){
                                  0
                              }else if(position === 1){
                                  48
                              }else if(position === 2){
                                  96
                              }else if(position === 3){
                                  144
                              }else if(position === 4){
                                  0
                              }else if(position === 5){
                                  0
                              }
                }

                NumberAnimation{
                    target: menuFrame
                    property: "x"
                    from: 0
                    to: 360 * menuFrameItem.direction
                    duration: 260
                    easing.type: Easing.OutQuad
                }

                PropertyAnimation{
                    target: menuFrame
                    property: "visible"
                    from: true
                    to: false
                    duration: 0
                }
            }

        }


    }
}
