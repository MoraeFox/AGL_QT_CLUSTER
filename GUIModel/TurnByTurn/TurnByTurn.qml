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

Item {
    id: turnByTurn
    property int receivedArrowId  : 0 /* 1:l1 2:l2 3:r1 4:r2 */
    property int receivedTbtValue : 0

    onReceivedArrowIdChanged: {
        tbtParts.idchange()
    }
    onReceivedTbtValueChanged: {
        tbtParts.valuechange()
    }
    Component.onCompleted: {
        receivedArrowId  = 1
        receivedTbtValue = 200
    }

    Item{
        id:tbtParts
        property int receivedTbtValue1    : receivedTbtValue%10
        property int receivedTbtValue10   : (receivedTbtValue/10)%10
        property int receivedTbtValue100  : (receivedTbtValue/100)%10
        property int currentArrowId   : 0
        property int currentTbtValue      : 0
        property int currentTbtValue1     : currentTbtValue%10
        property int currentTbtValue10    : (currentTbtValue/10)%10
        property int currentTbtValue100   : (currentTbtValue/100)%10

        Connections{
            target: rootItem
            onTransNormalToAdas:{
                normalToAdasAnimationTbt.start()
            }

            onTransAdasToMap:{
                adasToMapAnimationTbt.start()
            }

            onTransMapToNormal:{
                mapToNormalAnimationTbt.start()
            }
        }


        function idchange(){

            if(currentArrowId != 0){
                tbtArrowCur.source = "qrc:/Images/NormalView/TBT/tbt_arrow-" + currentArrowId  + ".ktx"
                tbtArrowNex.source = "qrc:/Images/NormalView/TBT/tbt_arrow-" + receivedArrowId + ".ktx"

                switch(currentArrowId){
                    case 1:
                        tbtArrowCurMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "l1" + ".ktx"
                        break
                    case 2:
                        tbtArrowCurMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "l2" + ".ktx"
                        break
                    case 3:
                        tbtArrowCurMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "r1" + ".ktx"
                        break
                    case 4:
                        tbtArrowCurMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "r2" + ".ktx"
                        break
                    default:
                        break
                }

                switch(receivedArrowId){
                    case 1:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "l1" + ".ktx"
                        break
                    case 2:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "l2" + ".ktx"
                        break
                    case 3:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "r1" + ".ktx"
                        break
                    case 4:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "r2" + ".ktx"
                        break
                    default:
                        break
                }
            }
            else{  //if no displayed item
                tbtArrowNex.source = "qrc:/Images/NormalView/TBT/tbt_arrow-" + receivedArrowId + ".ktx"

                switch(receivedArrowId){
                    case 1:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "l1" + ".ktx"
                        break
                    case 2:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "l2" + ".ktx"
                        break
                    case 3:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "r1" + ".ktx"
                        break
                    case 4:
                        tbtArrowNexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_arrow-" + "r2" + ".ktx"
                        break
                    default:
                        break
                }
            }
            arrowAnim.start()
            currentArrowId = receivedArrowId
        }

        function valuechange(){

            receivedTbtValue1   = receivedTbtValue%10
            receivedTbtValue10  = (receivedTbtValue/10)%10
            receivedTbtValue100 = (receivedTbtValue/100)%10

            currentTbtValue1    = currentTbtValue%10
            currentTbtValue10   = (currentTbtValue/10)%10
            currentTbtValue100  = (currentTbtValue/100)%10

            if(currentTbtValue >= 100) {
                tbtNum1Cur.visible = true
                tbtNum10Cur.visible = true
                tbtNum100Cur.visible = true

                tbtNum1CurMap.visible = true
                tbtNum10CurMap.visible = true
                tbtNum100CurMap.visible = true

            }else if(currentTbtValue >= 10){
                tbtNum1Cur.visible = true
                tbtNum10Cur.visible = true
                tbtNum100Cur.visible = false

                tbtNum1CurMap.visible = true
                tbtNum10CurMap.visible = true
                tbtNum100CurMap.visible = false
            }else{
                tbtNum1Cur.visible = true
                tbtNum10Cur.visible = false
                tbtNum100Cur.visible = false

                tbtNum1CurMap.visible = true
                tbtNum10CurMap.visible = false
                tbtNum100CurMap.visible = false
            }

            if(receivedTbtValue >= 100) {
                tbtNum1Nex.visible = true
                tbtNum10Nex.visible = true
                tbtNum100Nex.visible = true

                tbtNum1NexMap.visible = true
                tbtNum10NexMap.visible = true
                tbtNum100NexMap.visible = true
            }else if(receivedTbtValue >= 10){
                tbtNum1Nex.visible = true
                tbtNum10Nex.visible = true
                tbtNum100Nex.visible = false

                tbtNum1NexMap.visible = true
                tbtNum10NexMap.visible = true
                tbtNum100NexMap.visible = false
            }else{
                tbtNum1Nex.visible = true
                tbtNum10Nex.visible = false
                tbtNum100Nex.visible = false

                tbtNum1NexMap.visible = true
                tbtNum10NexMap.visible = false
                tbtNum100NexMap.visible = false
            }

            tbtUnitCur.source   = "qrc:/Images/NormalView/TBT/tbt_unit.png"
            tbtNum1Cur.source   = "qrc:/Images/NormalView/TBT/tbt_num1-"   + currentTbtValue1   + ".png"//9
            tbtNum10Cur.source  = "qrc:/Images/NormalView/TBT/tbt_num10-"  + currentTbtValue10  + ".png"//0
            tbtNum100Cur.source = "qrc:/Images/NormalView/TBT/tbt_num100-" + currentTbtValue100 + ".png"//0

            tbtUnitNex.source   = "qrc:/Images/NormalView/TBT/tbt_unit.png"
            tbtNum1Nex.source   = "qrc:/Images/NormalView/TBT/tbt_num1-"   + receivedTbtValue1   + ".png"//9
            tbtNum10Nex.source  = "qrc:/Images/NormalView/TBT/tbt_num10-"  + receivedTbtValue10  + ".png"//9
            tbtNum100Nex.source = "qrc:/Images/NormalView/TBT/tbt_num100-" + receivedTbtValue100 + ".png"//1


            tbtUnitCurMap.source   = "qrc:/Images/ADASView/TBT/map_tbt_unit.png"
            tbtNum1CurMap.source   = "qrc:/Images/ADASView/TBT/map_tbt_num1-"   + currentTbtValue1   + ".png"//9
            tbtNum10CurMap.source  = "qrc:/Images/ADASView/TBT/map_tbt_num10-"  + currentTbtValue10  + ".png"//0
            tbtNum100CurMap.source = "qrc:/Images/ADASView/TBT/map_tbt_num100-" + currentTbtValue100 + ".png"//0

            tbtUnitNexMap.source   = "qrc:/Images/ADASView/TBT/map_tbt_unit.png"
            tbtNum1NexMap.source   = "qrc:/Images/ADASView/TBT/map_tbt_num1-"   + receivedTbtValue1   + ".png"//9
            tbtNum10NexMap.source  = "qrc:/Images/ADASView/TBT/map_tbt_num10-"  + receivedTbtValue10  + ".png"//9
            tbtNum100NexMap.source = "qrc:/Images/ADASView/TBT/map_tbt_num100-" + receivedTbtValue100 + ".png"//1

            value_anim.start()
            currentTbtValue = receivedTbtValue
        }

        Item{
            id:tbtNormal
        /*-----------------------------------current tbt value------------------------------------*/
            Image{
              id:tbtUnitCur
              x:1525
              y:327
              width:23
              height:17
              opacity: 0
            }
            Image{
              id:tbtNum1Cur
              x:1501
              y:316
              width:19
              height:28
              opacity: 0
            }
            Image{
              id:tbtNum10Cur
              x:1482
              y:316
              width:19
              height:28
              opacity: 0
            }
            Image{
              id:tbtNum100Cur
              x:1463
              y:316
              width:19
              height:28
              opacity: 0
            }
        /*----------------------------------- next tbt value  ------------------------------------*/
            Image{
              id:tbtUnitNex
              x:1525
              y:327
              width:23
              height:17
              opacity: 0
            }
            Image{
              id:tbtNum1Nex
              x:1501
              y:316
              width:19
              height:28
              opacity: 0
            }
            Image{
              id:tbtNum10Nex
              x:1482
              y:316
              width:19
              height:28
              opacity: 0
            }
            Image{
              id:tbtNum100Nex
              x:1463
              y:316
              width:19
              height:28
              opacity: 0
            }
        /*-----------------------------------current tbt arrow------------------------------------*/
            Image{
              id:tbtArrowCur
              x:1349
              y:176
              width:307
              height:111
              opacity: 0
            }
        /*----------------------------------- next tbt arrow  ------------------------------------*/
            Image{
              id:tbtArrowNex
              x:1349
              y:176
              width:307
              height:111
              opacity: 0
            }
        }

        Item{
            id:tbtMap
            y: -20
            visible: false
            /*-----------------------------------current tbt value------------------------------------*/
            Image{
              id:tbtUnitCurMap
              x:974
              y:440
              width:26
              height:20
              opacity: 0
            }
            Image{
              id:tbtNum1CurMap
              x:948
              y:428
              width:24
              height:32
              opacity: 0
            }
            Image{
              id:tbtNum10CurMap
              x:925
              y:428
              width:24
              height:32
              opacity: 0
            }
            Image{
              id:tbtNum100CurMap
              x:902
              y:428
              width:24
              height:32
              opacity: 0
            }
        /*----------------------------------- next tbt value  ------------------------------------*/
            Image{
              id:tbtUnitNexMap
              x:974
              y:440
              width:26
              height:20
              opacity: 0
            }
            Image{
              id:tbtNum1NexMap
              x:948
              y:428
              width:24
              height:32
              opacity: 0
            }
            Image{
              id:tbtNum10NexMap
              x:925
              y:428
              width:24
              height:32
              opacity: 0
            }
            Image{
              id:tbtNum100NexMap
              x:902
              y:428
              width:24
              height:32
              opacity: 0
            }
        /*-----------------------------------current tbt arrow------------------------------------*/
            Image{
              id:tbtArrowCurMap
              x:798
              y:296
              width:307
              height:111
              opacity: 0
            }
        /*----------------------------------- next tbt arrow  ------------------------------------*/
            Image{
              id:tbtArrowNexMap
              x:798
              y:296
              width:307
              height:111
              opacity: 0
            }
        }

    /*----------------------------------- value animation ------------------------------------*/
        ParallelAnimation{
            id: value_anim
            NumberAnimation {
                target: tbtUnitCur
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtNum1Cur
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtNum10Cur
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtNum100Cur
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtUnitNex
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
            NumberAnimation {
                target: tbtNum1Nex
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
            NumberAnimation {
                target: tbtNum10Nex
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
            NumberAnimation {
                target: tbtNum100Nex
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }

            NumberAnimation {
                target: tbtUnitCurMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtNum1CurMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtNum10CurMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtNum100CurMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtUnitNexMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
            NumberAnimation {
                target: tbtNum1NexMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
            NumberAnimation {
                target: tbtNum10NexMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
            NumberAnimation {
                target: tbtNum100NexMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
        }

    /*----------------------------------- arrow animation ------------------------------------*/
        ParallelAnimation{
            id: arrowAnim
            NumberAnimation {
                target: tbtArrowCur
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtArrowNex
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }

            NumberAnimation {
                target: tbtArrowCurMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from: 1
                to: 0
            }
            NumberAnimation {
                target: tbtArrowNexMap
                property: "opacity"
                duration: 500
                easing.type: Easing.Linear
                from : 0
                to: 1
            }
        }

    /*----------------------------------- mode toransition animation ------------------------------------*/
        SequentialAnimation{
            id:normalToAdasAnimationTbt
            onStarted: rootItem.focus=false
            NumberAnimation {
                target: tbtNormal
                property: "opacity"
                duration: 330
                from:1
                to:0
            }

            PropertyAnimation{
                target: tbtNormal
                property: "visible"
                duration: 0
                from: true
                to: false
            }
        }

        SequentialAnimation{
            id: adasToMapAnimationTbt
            onStarted: rootItem.focus=false
            PropertyAnimation{
                target: tbtMap
                property: "visible"
                duration: 0
                to: true
            }

            PropertyAnimation{
                target: tbtMap
                property: "opacity"
                duration: 330
                to: 1
            }
        }

        SequentialAnimation{
            id:mapToNormalAnimationTbt
            onStarted: rootItem.focus=false
            onStopped: rootItem.focus=true
            PauseAnimation {
                duration: 254
            }

            PropertyAnimation{
                target: tbtMap
                property: "opacity"
                duration: 330
                to: 0
            }

            PropertyAnimation{
                target: tbtMap
                property: "visible"
                duration: 0
                to: false
            }

            PauseAnimation {
                duration: 891
            }

            PropertyAnimation{
                target: tbtNormal
                property: "visible"
                duration:0
                from:"flase"
                to: true
            }

            NumberAnimation {
                target: tbtNormal
                property: "opacity"
                duration: 330
                from:0
                to:1
            }
        }
    }
}
