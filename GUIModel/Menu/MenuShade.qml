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
    /* public function */
    function startAnimationNormalToAdas(){
        normalToAdasAnimation.start()
    }

    function startAnimationMapToNormal(){
        mapToNormalAnimation.start()
    }

    Item{
        id: menuShades
        Item{
            id: menuShadeNormal
            visible: true

            Image{
                source: "qrc:/Images/NormalView/MENU/menu_shade.png"
                x: 522
                y: 390
                width: 444
                height: 330
            }

            Rectangle{
                color: "black"
                x: 960
                y: 390
                width: 300
                height: 300
            }
        }

        Item{
            id: menuShadeAdas
            visible: false

            Image{
                source: "qrc:/Images/ADASView/MENU/menu_shade.png"
                x: 436
                y: 360
                width: 444
                height: 332

            }

            Rectangle{
                color: "black"
                x: 100
                y: 400
                width: 440
                height: 300
            }
        }

        SequentialAnimation{
            id:normalToAdasAnimation
            onStarted: rootItem.focus=false
            NumberAnimation {
                target: menuShades
                property: "opacity"
                duration: 330
                from:1
                to:  0
            }
            PropertyAnimation{
                target: menuShadeNormal
                property: "visible"
                duration: 0
                from: true
                to: false
            }
            PropertyAnimation{
                target: menuShadeAdas
                property:"visible"
                duration: 0
                from: false
                to: true
            }

            PauseAnimation {
                duration: 891
            }

            NumberAnimation {
                target: menuShades
                property: "opacity"
                duration: 330
                from: 0
                to: 1
            }
        }


        SequentialAnimation{
            id: mapToNormalAnimation
            onStarted: rootItem.focus=false

            PauseAnimation {
                duration: 254
            }

            NumberAnimation {
                target: menuShades
                property: "opacity"
                duration: 330
                from: 1
                to: 0
            }
            PropertyAnimation{
                target: menuShadeNormal
                property: "visible"
                duration: 0
                from: false
                to: true
            }
            PropertyAnimation{
                target: menuShadeAdas
                property: "visible"
                duration: 0
                from: true
                to: false
            }

            PauseAnimation {
                duration: 891
            }

            NumberAnimation {
                target: menuShades
                property: "opacity"
                duration: 330
                from: 0
                to: 1
            }
        }
    }

}
