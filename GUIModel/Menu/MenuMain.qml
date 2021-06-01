/*
 * Copyright 2020,2021 Panasonic Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.11

Item{
    id: menuMain

    /* public propeties */
    readonly property alias index: menuFrames.index

    /* public functions */
    function incrementIndex(){
        menuFrames.incrementIndex()
    }

    function decrementIndex(){
        menuFrames.decrementIndex()
    }

    function open(){
        menuFrames.open()
    }

    function close(){
        menuFrames.close()
    }

    function startAnimationNormalToAdas(){
        normalToAdasAnimation.start()
    }

    function startAnimationMapToNormal(){
        mapToNormalAnimation.start()
    }

    Item {
        id: menuFrames
        x: 326
        y: 468
        width: 500; height:280
        layer.textureMirroring: ShaderEffectSource.MirrorVertically
        property int index: 0 /* 0:radio 1:ADAS 2:audio */
        property var mode: "normal" /* normal or adas */


        function incrementIndex(){
            menuFrame0.upScroll()
            menuFrame1.upScroll()
            menuFrame2.upScroll()
            menuFrame3.upScroll()
            menuFrame4.upScroll()
            menuFrame5.upScroll()

            index++
            if(index === 3) index = 0
        }

        function decrementIndex(){
            menuFrame0.downScroll()
            menuFrame1.downScroll()
            menuFrame2.downScroll()
            menuFrame3.downScroll()
            menuFrame4.downScroll()
            menuFrame5.downScroll()

            index--
            if(index === -1) index = 2
        }

        function open(){
            menuFrame0.open()
            menuFrame1.open()
            menuFrame2.open()
            menuFrame3.open()
            menuFrame4.open()
            menuFrame5.open()
        }

        function close(){
            menuFrame0.close()
            menuFrame1.close()
            menuFrame2.close()
            menuFrame3.close()
            menuFrame4.close()
            menuFrame5.close()
        }

        MenuFrame{
            id: menuFrame0
            position: 0
            mode: menuFrames.mode
            icon: "qrc:/Images/NormalView/MENU/ADAS/L_icon_adas.png"
            txt: "ADAS"
        }

        MenuFrame{
            id: menuFrame1
            position: 1
            mode: menuFrames.mode
            icon: "qrc:/Images/NormalView/MENU/MUSIC/L_icon_music.png"
            txt: "MUSIC"
        }

        MenuFrame{
            id: menuFrame2
            position: 2
            mode: menuFrames.mode
            icon: "qrc:/Images/NormalView/MENU/RADIO/L_icon_radio.png"
            txt: "RADIO"
        }

        MenuFrame{
            id: menuFrame3
            position: 3
            mode: menuFrames.mode
            icon: "qrc:/Images/NormalView/MENU/ADAS/L_icon_adas.png"
            txt: "ADAS"
        }

        MenuFrame{
            id: menuFrame4
            position: 4
            mode: menuFrames.mode
            icon: "qrc:/Images/NormalView/MENU/MUSIC/L_icon_music.png"
            txt: "MUSIC"
        }

        MenuFrame{
            id: menuFrame5
            position: 5
            mode: menuFrames.mode
            icon: "qrc:/Images/NormalView/MENU/RADIO/L_icon_radio.png"
            txt: "RADIO"
        }

        SequentialAnimation{
            id:normalToAdasAnimation
            onStarted: rootItem.focus=false
            NumberAnimation {
                target: menuFrames
                property: "opacity"
                duration: 330
                from:1
                to:0
            }
            PauseAnimation {
                duration:891
            }
            PropertyAnimation {
                target: menuFrames
                property: "mode"
                duration: 0
                to: "adas"
            }
            NumberAnimation {
                target: menuFrames
                property: "x"
                duration: 0
                to:80 + 444
            }
            NumberAnimation {
                target: menuFrames
                property: "y"
                duration: 0
                to:498
            }
            NumberAnimation {
                target: menuFrames
                property: "opacity"
                duration: 330
                from:0
                to:1
            }
        }

        SequentialAnimation{
            id:mapToNormalAnimation
            onStarted: rootItem.focus=false

            PauseAnimation {
                duration: 254
            }
            ParallelAnimation{
                NumberAnimation {
                    target: menuFrames
                    property: "opacity"
                    duration: 330
                    from:1
                    to:0
                }
                PauseAnimation {
                    duration:891
                }
            }

            PropertyAnimation {
                target: menuFrames
                property: "mode"
                duration: 0
                to: "normal"
            }
            NumberAnimation {
                target: menuFrames
                property: "x"
                duration: 0
                to:326
            }
            NumberAnimation {
                target: menuFrames
                property: "y"
                duration: 0
                to:468
            }

            NumberAnimation {
                target: menuFrames
                property: "opacity"
                duration: 330
                from:0
                to:1
            }
        }
    }
}
