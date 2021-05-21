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
