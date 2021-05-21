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
    id: shift
    property int shiftId  : 0
    property Image mId

    onShiftIdChanged: {
        idchange()
    }

    Connections{
        target: rootItem
        onTransNormalToAdas:{
            normalToAdasAnimationShift.start()
        }

        onTransAdasToMap:{
            /**/
        }

        onTransMapToNormal:{
            mapToNormalAnimationShift.start()
        }
    }

    function idchange(){

        shiftL.width = 126
        shiftN.width = 126
        shiftR.width = 126
        shiftP.width = 126
        shiftD.width = 126
        shiftL.height = 136
        shiftN.height = 136
        shiftR.height = 136
        shiftP.height = 136
        shiftD.height = 136

        if(shftTimer.running){
            shftTimer.stop()
        }

        switch(shiftId){
        case(1):
            mId = shiftD
            shiftL.visible = false
            shiftN.visible = false
            shiftR.visible = false
            shiftP.visible = false
            shiftD.visible = true
            break
        case(2):
            mId = shiftL
            shiftD.visible = false
            shiftN.visible = false
            shiftR.visible = false
            shiftP.visible = false
            shiftL.visible = true
            break
        case(3):
            mId = shiftN
            shiftD.visible = false
            shiftL.visible = false
            shiftR.visible = false
            shiftP.visible = false
            shiftN.visible = true
            break
        case(4):
            mId = shiftR
            shiftD.visible = false
            shiftL.visible = false
            shiftN.visible = false
            shiftP.visible = false
            shiftR.visible = true
            break
        case(5):
            mId = shiftP
            shiftD.visible = false
            shiftL.visible = false
            shiftN.visible = false
            shiftR.visible = false
            shiftP.visible = true
            break
        default:
            //mId = 0
            shiftD.visible = false
            shiftL.visible = false
            shiftN.visible = false
            shiftR.visible = false
            shiftP.visible = false
            break
        }
        shftTimer.start()
    }

    Timer {
        id:shftTimer
        interval: 300
        repeat: false
        running: false
        onTriggered: {
            shiftAnimScale.start()
        }
    }




/***********shiftParts************/
    Item{
        id: shiftParts
        x:356
        y:156
        width:126
        height:136
        Image{
          id: shiftD
          source: "qrc:/Images/NormalView/SHIFT/shift-d.png"
          width:126
          height:136
          visible: false
          anchors.centerIn: parent
        }
        Image{
          id: shiftL
          source: "qrc:/Images/NormalView/SHIFT/shift-l.png"
          width:126
          height:136
          visible: false
          anchors.centerIn: parent
        }
        Image{
          id: shiftN
          source: "qrc:/Images/NormalView/SHIFT/shift-n.png"
          width:126
          height:136
          visible: false
          anchors.centerIn: parent
        }
        Image{
          id: shiftR
          source: "qrc:/Images/NormalView/SHIFT/shift-r.png"
          width:126
          height:136
          visible: false
          anchors.centerIn: parent
        }
        Image{
          id: shiftP
          source: "qrc:/Images/NormalView/SHIFT/shift-p.png"
          width:126
          height:136
          visible: false
          anchors.centerIn: parent
        }

        SequentialAnimation{
            id:normalToAdasAnimationShift
            onStarted: rootItem.focus=false
            PauseAnimation{
                duration: 330
            }

            PathAnimation{
                target: shiftParts
                duration: 891
                easing.type: Easing.InOutSine

                path:Path {
                    startX: 356; startY: 156
                    PathArc {
                        x: 157; y: 336
                        radiusX: 180; radiusY: 180
                        direction: PathArc.Counterclockwise
                    }
                }
            }
        }

/*****************shit_animation******************/
        SequentialAnimation{
            id:mapToNormalAnimationShift
            onStarted: rootItem.focus=false
            PauseAnimation{
                duration:254 + 330
            }

            PathAnimation{
                target: shiftParts
                duration: 891
                easing.type: Easing.InOutSine

                path:Path {
                    startX: 157; startY: 336
                    PathArc {
                        x: 356; y: 156
                        radiusX: 180; radiusY: 180
                        direction: PathArc.Clockwise
                    }
                }
            }

        }

    }

    ParallelAnimation{
        id: shiftAnimScale
        PropertyAnimation {
            target: mId
            properties: "width"
            duration: 40
            easing.type: Easing.Linear
            to: 90.0
        }
        PropertyAnimation {
            target: mId
            properties: "height"
            duration: 40
            easing.type: Easing.Linear
            to: 97.0
        }
    }
}


