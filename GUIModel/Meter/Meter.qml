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

import QtQuick 2.14
import QtGraphicalEffects 1.14

Item {
    id: meter
    property real speedValue: 0
    property real tachoValue: 0
    property real chargeValue:100

    onSpeedValueChanged: {
        speedGuage.speedValue = speedValue
        speedNeedle.speedValue = speedValue
        digitalSpeed.speedValue = speedValue
    }

    onTachoValueChanged: {
        tachometer.tachoValue = tachoValue
    }
    onChargeValueChanged: {
        chargeGuage.chargeValue = chargeValue
    }


    Item {
       id: meterParts
       property var easing: Easing.InOutQuad
       Component.onCompleted: {
           testAnim.start()
       }

       Connections{
           target: rootItem
           onTransNormalToAdas:{
               / *nop */
           }

           onTransAdasToMap:{
               / *nop */
           }

           onTransMapToNormal:{
               / *nop */
           }
       }

       Sideline {
           id: sideline
       }

       Ring {
           id: ring
       }

       ChargeGuage {
           id: chargeGuage
       }

       SpeedGuage {
           id: speedGuage
       }

       SpeedNeedle {
           id: speedNeedle
       }

       Tachometer {
           id: tachometer
       }

       Ready {
           id: ready
       }

       Mask {
           id: mask
       }

       DigitalSpeed {
           id: digitalSpeed
       }

       ParallelAnimation{
           id: testAnim
           SequentialAnimation{
               id: testAnimSpeed
               loops: Animation.Infinite
               NumberAnimation {
                   target: meter
                   property: "speedValue"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                   to: 300
               }
               NumberAnimation{
                   duration: 5000
               }

               NumberAnimation {
                   target: meter
                   property: "speedValue"
                   duration: 5000
                   easing.type: Easing.InOutQuad
                   to: 0
               }
           }

           SequentialAnimation{
               id: testAnimTacho
               loops: Animation.Infinite
               NumberAnimation {
                   target: meter
                   property: "tachoValue"
                   duration: 500
                   easing.type: Easing.InOutQuad
                   to: 8000
               }
               NumberAnimation {
                   target: meter
                   property: "tachoValue"
                   duration: 2500
                   easing.type: Easing.InOutQuad
                   to: 0
               }
           }
           SequentialAnimation{
               id: testAnimCharge
               loops: Animation.Infinite
               NumberAnimation {
                   target: meter
                   property: "chargeValue"
                   duration: 10000
                   easing.type: Easing.Linear
                   to: 0
               }
               NumberAnimation {
                   target: meter
                   property: "chargeValue"
                   duration: 10000
                   easing.type: Easing.Linear
                   to: 100
               }
           }
       }
    }
}


