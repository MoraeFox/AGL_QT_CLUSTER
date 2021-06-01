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
import QtGraphicalEffects 1.14

Item{
    id: digitalSpeed
    property real speedValue

    readonly property real digitalSpeedMax: 300
    readonly property real digitalSpeedMin: 0

    onSpeedValueChanged: {
        updateSpeedValue();
        updateSpeedNumPosition();
        updateSpeedNumVisible();
    }

    Connections{
        target: rootItem
        onTransNormalToAdas:{
            normalToAdasAnimation.start()
        }

        onTransAdasToMap:{
            /**/
        }

        onTransMapToNormal:{
            mapToNormalAnimation.start()
        }
    }

    function updateSpeedValue(){
        digitalSpeedParts.speedValue1 = speedValue%10
        digitalSpeedParts.speedValue10 = (speedValue/10)%10
        digitalSpeedParts.speedValue100 = (speedValue/100)%10
    }

    function updateSpeedNumPosition(){
        if((0 <= speedValue) && (speedValue < 10)){
            speedNum1.x = 93
        }else if((10 <= speedValue) && (speedValue < 100)){
            speedNum1.x = 137
            speedNum10.x = 47
        }else if(100 <= speedValue){
            speedNum1.x = 180
            speedNum10.x = 90
        }
    }

    function updateSpeedNumVisible(){
        if((digitalSpeedMin <= speedValue) && (speedValue < 10)){
            speedNum1.visible = true
            speedNum10.visible = false
            speedNum100.visible = false
        }else if((10 <= speedValue) && (speedValue < 100)){
            speedNum1.visible = true
            speedNum10.visible = true
            speedNum100.visible = false
        }else if((100 <= speedValue) && (speedValue <= digitalSpeedMax)){
            speedNum1.visible = true
            speedNum10.visible = true
            speedNum100.visible = true
        }else{
            speedNum1.visible = false
            speedNum10.visible = false
            speedNum100.visible = false
        }
    }

    Item{
        id:digitalSpeedParts
        property int speedValue1
        property int speedValue10
        property int speedValue100

        Image{
            id:ring4
            source: "qrc:/Images/NormalView/METER/ring4.ktx"
            x:762
            y:200
            width:396
            height:395
        }

        Image{
            id:speedUnit
            source: "qrc:/Images/NormalView/SPEED/speed_unit.png"
            x:907
            y:457
            width:97
            height:59
        }

        Item{
            id:speedNum

            x:816
            y:324
            Image{
                id:speedNum1
                source: "qrc:/Images/NormalView/SPEED/speed_num1-" + digitalSpeedParts.speedValue1 + ".png"
                x:93
                width:98
                height:120
                visible: true
            }
            Image{
                id:speedNum10
                source: "qrc:/Images/NormalView/SPEED/speed_num1-" + digitalSpeedParts.speedValue10 + ".png"
                width:98
                height:120
                visible: false
            }
            Image{
                id:speedNum100
                source: "qrc:/Images/NormalView/SPEED/speed_num1-" + digitalSpeedParts.speedValue100 + ".png"
                width:98
                height:120
                visible: false
            }
        }

        SequentialAnimation{
            id: normalToAdasAnimation
            onStarted: rootItem.focus=false
            /* remove background */
            SequentialAnimation{
                NumberAnimation{
                    target: ring4
                    property: "scale"
                    duration: 330
                    easing.type: Easing.Linear
                    from:1.0
                    to:0
                }

                PropertyAnimation{
                    target: ring4
                    property: "visible"
                    duration: 0
                    from:true
                    to:false
                }
            }

            ParallelAnimation{
                /* scaling */
                NumberAnimation {
                    target: speedNum
                    property: "scale"
                    duration: 891
                    easing.type: meterParts.easing
                    from:1
                    to:0.725
                }

                /* translation */
                PathAnimation{
                    target: speedNum
                    orientation: PathAnimation.Fixed
                    duration: 891
                    easing.type: meterParts.easing

                    path: Path {
                        startX: 816; startY: 324
                        PathLine { x: 860; y: 41 }
                    }
                }

                /* scaling */
                NumberAnimation {
                    target: speedUnit
                    property: "scale"
                    duration: 891
                    easing.type: meterParts.easing
                    from:1
                    to:0.73
                }

                /* slide */
                PathAnimation{
                    target: speedUnit
                    orientation: PathAnimation.Fixed
                    duration: 891
                    easing.type: meterParts.easing

                    path: Path {
                        startX: 907; startY: 457
                        PathLine { x: 914; y: 128 }
                    }
                }
            }

        }


        SequentialAnimation{
            id: mapToNormalAnimation
            onStarted: rootItem.focus=false
            onStopped: rootItem.focus=true
            PauseAnimation {
                duration: 254
            }

            PauseAnimation {
                duration: 330
            }

            ParallelAnimation{
                /* scaling */
                NumberAnimation {
                    target: speedNum
                    property: "scale"
                    duration: 891
                    easing.type: meterParts.easing
                    from:0.725
                    to:1.00
                }

                /* translation */
                PathAnimation{
                    target: speedNum
                    duration: 891
                    easing.type: meterParts.easing
                    path: Path {
                        startX: 860; startY: 41
                        PathLine { x: 816; y: 324 }
                    }
                }

                /* scaling */
                NumberAnimation {
                    target: speedUnit
                    property: "scale"
                    duration: 891
                    easing.type: meterParts.easing
                    from:0.73
                    to:1.00
                }

                /* translation */
                PathAnimation{
                    target: speedUnit
                    orientation: PathAnimation.Fixed
                    duration: 891
                    easing.type: meterParts.easing

                    path: Path {
                        startX: 914; startY: 128
                        PathLine { x: 907; y: 457 }
                    }
                }
            }

            /* visible backgournd */
            SequentialAnimation{
                PropertyAnimation{
                    target: ring4
                    property: "visible"
                    duration: 0
                    from:false
                    to:true
                }

                NumberAnimation{
                    target: ring4
                    property: "scale"
                    duration: 330
                    easing.type: Easing.Linear
                    from:0.0
                    to:1.0
                }
            }
            PauseAnimation {
                duration: 330
            }

        }
    }
}
