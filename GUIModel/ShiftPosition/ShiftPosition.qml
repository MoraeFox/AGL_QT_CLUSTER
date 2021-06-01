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


