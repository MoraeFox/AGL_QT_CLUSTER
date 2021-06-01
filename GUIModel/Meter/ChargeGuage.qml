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

Item {
    id: chargeGuage
    x:666
    y:97
    width:588
    height:588
    property real chargeValue

    readonly property real chargeGuageMax: 100
    readonly property real chargeGuageMin: 0

    onChargeValueChanged: {
        limitChargeValue();
        effectChr.angleBase = (-0.45 * chargeValue*Math.PI/180)+effectChr.angle
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

    function limitChargeValue(){
        if(chargeValue > chargeGuageMax){
            chargeValue = chargeGuageMax
        }else if(chargeValue < chargeGuageMin){
            chargeValue = chargeGuageMin
        }
    }

    Item{
        id: chrGuageGroup
        width:588
        height:588
        Item {
            id: chrGuage
            width:588
            height:588
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: false
            Image{
                id: chrGuageImg
                source: "qrc:/Images/NormalView/METER/charge_guage.ktx"
                width:588
                height:588
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: true
            }
            Image {
                id: chrEffect
                source: ""
                width:588
                height:588
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: true
            }
        }
        ShaderEffect{
            id: effectChr
            anchors.fill: parent
            visible: true
            blending: true
            supportsAtlasTextures: true
            property real angleBase: -pi*1/2
            property real angle:-pi*1/2
            property var src: ShaderEffectSource{
                sourceItem: chrGuage
                live: false
            }

            readonly property real pi: 3.1415926535

            vertexShader: "qrc:/Shaders/vert/guageMask.vert"
            fragmentShader:"qrc:/Shaders/frag/guageMask.frag"
        }
    }
    SequentialAnimation{
        id: normalToAdasAnimation
        onStarted: rootItem.focus=false
        SequentialAnimation{
            NumberAnimation{
                target: chrGuageGroup
                property: "opacity"
                duration: 330
                easing.type: Easing.InOutSine
                from:1.0
                to:0.0
            }
            PropertyAnimation{
                target: chrGuageGroup
                property: "visible"
                duration: 0
                easing.type: Easing.InOutSine
                from:true
                to:false
            }
        }
        
        ParallelAnimation{
            /* down size */
            NumberAnimation{
                target: chargeGuage
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:1
                to:0.75
            }
            
            /* translation */
            PathAnimation{
                target: chargeGuage
                anchorPoint: Qt.point(chargeGuage.width/2, chargeGuage.height/2)
                orientation: PathAnimation.Fixed
                duration: 891
                easing.type: meterParts.easing
                
                path: Path {
                    startX: 960; startY: 391
                    PathLine { x: 540; y: 402 }
                }
            }
            PropertyAnimation{
                target: chrGuageImg
                property: "source"
                to: "qrc:/Images/ADASView/METER/chr_wave.png"
                duration: 0
            }
            PropertyAnimation{
                target: chrEffect
                property: "source"
                to: "qrc:/Images/ADASView/METER/chr_glow.png"
                duration: 0
            }
        }
        PauseAnimation{
            duration: 396
        }
        PropertyAnimation{
            target: chrGuageGroup
            property: "visible"
            to: true
            duration: 0
        }
        PropertyAnimation{
            target: chrGuageGroup
            property: "opacity"
            to: 1
            duration: 198
        }
    }
    
    SequentialAnimation{
        id: mapToNormalAnimation
        onStarted: rootItem.focus=false
        onStopped: rootItem.focus=true
        PropertyAnimation{
            target: chrGuageGroup
            property: "opacity"
            to: 0
            duration: 198
        }
        PropertyAnimation{
            target: chrGuageGroup
            property: "visible"
            to: true
            duration: 0
        }
        PauseAnimation {
            duration: 254 + 330
        }
        
        
        ParallelAnimation{
            /* scaling */
            NumberAnimation{
                target: chargeGuage
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:0.75
                to:1.0
            }
            
            /* slide */
            PathAnimation{
                target: chargeGuage
                anchorPoint: Qt.point(chargeGuage.width/2, chargeGuage.height/2)
                orientation: PathAnimation.Fixed
                duration: 891
                easing.type: meterParts.easing
                
                path: Path {
                    startX: 540; startY: 402
                    PathLine { x: 960; y: 391 }
                }
            }
            PropertyAnimation{
                target: chrGuageImg
                property: "source"
                to: "qrc:/Images/NormalView/METER/charge_guage.ktx"
                duration: 0
            }
            PropertyAnimation{
                target: chrEffect
                property: "source"
                to: ""
                duration: 0
            }
        }
        
        SequentialAnimation{
            PropertyAnimation{
                target: chrGuageGroup
                property: "visible"
                duration: 0
                easing.type: Easing.InOutSine
                from:false
                to:true
            }
            
            NumberAnimation{
                target: chrGuageGroup
                property: "opacity"
                duration: 330
                easing.type: Easing.InOutSine
                from:0.0
                to:1.0
            }
        }
        PauseAnimation {
            duration: 330
        }
    }
}
