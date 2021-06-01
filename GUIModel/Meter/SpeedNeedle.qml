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
    id: speedNeedle
    width:444
    height:444
    x: 318
    y: 180
    visible: false
    property real speedValue

    readonly property real speedNeedleMax: 100
    readonly property real speedNeedleMin: 0

    onSpeedValueChanged: {
        setNeedleAngle();
        effectPwrNeedle.angle = (2.25 * speedValue*Math.PI/180)+effectPwrNeedle.angleBase
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

    function setNeedleAngle(){
        if(speedNeedleMax < speedValue){
            speedValue = speedNeedleMax
        }else if( speedValue < speedNeedleMin){
            speedValue = speedNeedleMin
        }
        rotateNeedle.angle = 2.25 * speedValue
    }

    /* Needle - visible in ADAS/Map mode */
    Item {
        id:needleGroup
        width:444
        height:444
        
        Image{
            id: pwrNeedle
            source: "qrc:/Images/ADASView/METER/needle.png"
            x: 28
            y: 220
            width:182
            height:4
            visible: false
        }
        
        Item{
            id: needleMask
            visible: false
            anchors.fill:pwrNeedle
            property double maskPercent: 0
            
            Rectangle{
                id: needleMaskInvisible
                color: "red"
                opacity: 0
                anchors.left: parent.left
                width: pwrNeedle.width * (1.0 - needleMask.maskPercent/100.0)
                height: pwrNeedle.height
                visible: true
            }
            Rectangle{
                id: needleMaskVisible
                color: "blue"
                anchors.right: parent.right
                opacity: 1
                width: pwrNeedle.width * (needleMask.maskPercent/100.0)
                height: pwrNeedle.height
                visible: true
            }
        }
        
        
        OpacityMask {
            id: maskedPwrNeedle
            cached: false
            width: pwrNeedle.x
            height:pwrNeedle.y
            anchors.fill:pwrNeedle
            source: pwrNeedle
            maskSource: needleMask
        }
        
        transform: Rotation{
            id:rotateNeedle
            origin.x: needleGroup.width / 2
            origin.y: needleGroup.height / 2
            angle : 0
        }
        
        
    }
    
    Item{
        id: centerCircleGroup
        width:124
        height:126
        x:160
        y:166
        Image{
            id: centerCircle
            source: "qrc:/Images/ADASView/METER/center_circle.png"
            width:124
            height:126
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: true
        }
    }
    
    Item {
        id: pwrNeedleEffect
        width:444
        height:444
        x: 0
        y: 0
        visible: false
        
        Image{
            source: "qrc:/Images/ADASView/METER/pwr_wave.png"
            width:444
            height:442
            visible: true
        }
        
        Image{
            source: "qrc:/Images/ADASView/METER/pwr_glow.png"
            width:444
            height:442
            visible: true
        }
    }
    

    ShaderEffect{
        id: effectPwrNeedle
        anchors.fill: pwrNeedleEffect
        visible: false
        blending: true
        supportsAtlasTextures: true
        property real angleBase: -pi*1/2
        property real angle:-pi*1/2
        property var src: ShaderEffectSource{
            sourceItem: pwrNeedleEffect
        }

        readonly property real pi: 3.1415926535

        vertexShader: "qrc:/Shaders/vert/guageMask.vert"
        fragmentShader:"qrc:/Shaders/frag/guageMask.frag"
    }
    
    
    SequentialAnimation{
        id: normalToAdasAnimation
        onStarted: rootItem.focus=false
        onStopped: rootItem.focus=true
        PauseAnimation {
            duration: 330 + 891
        }
        
        PropertyAnimation{
            target: speedNeedle
            property: "visible"
            duration: 0
            from:false
            to:true
        }
        
        NumberAnimation{
            target: centerCircle
            property: "scale"
            duration: 396
            easing.type: Easing.InOutSine
            from: 0
            to: 1
        }
        
        PropertyAnimation{
            target:effectPwrNeedle
            property:"visible"
            duration:0
            from:false
            to:true
        }
        
        ParallelAnimation{
            NumberAnimation {
                target:needleMask
                property: "maskPercent"
                duration: 198
                from:0.0
                to:100.0
            }
            
            NumberAnimation{
                target:effectPwrNeedle
                property:"opacity"
                duration:198
                from:0
                to:1
            }
        }
        PauseAnimation {
            duration: 330
        }
        
    }
    
    SequentialAnimation{
        id: mapToNormalAnimation
        onStarted: rootItem.focus=false
        ParallelAnimation{
            NumberAnimation {
                target:needleMask
                property: "maskPercent"
                duration: 198
                from:100.0
                to:0.0
            }
            
            NumberAnimation{
                target:effectPwrNeedle
                property:"opacity"
                duration:198
                from:1
                to:0
            }
        }
        
        PropertyAnimation{
            target:effectPwrNeedle
            property:"visible"
            duration:0
            from:true
            to:false
        }
        
        NumberAnimation{
            target: centerCircle
            property: "scale"
            duration: 396
            easing.type: Easing.InOutSine
            from: 1
            to: 0
        }
        
        PropertyAnimation{
            target: speedNeedle
            property: "visible"
            duration: 0
            from:true
            to:false
        }
    }
    
}
