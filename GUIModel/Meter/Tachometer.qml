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
    id: tachometer
    property real tachoValue

    readonly property real tachoValueMax: 8000
    readonly property real tachoValueMin: 0

    onTachoValueChanged: {
        limitTachoValue();
        effectRpm.angle = (0.03375 * tachoValue*Math.PI/180)+effectRpm.angleBase
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

    function limitTachoValue(){
        if(tachoValue > tachoValueMax){
            tachoValue = tachoValueMax
        }else if(tachoValue < tachoValueMin){
            tachoValue = tachoValueMin
        }
    }

    Image{
        id:rpmGuage
        source: "qrc:/Images/NormalView/METER/prm_guage.ktx"
        x:770
        y:200
        width:380
        height:382
        visible: false
    }
    ShaderEffect{
        id: effectRpm
        anchors.fill: rpmGuage
        visible: true
        blending: true
        supportsAtlasTextures: true
        property real angleBase: -pi*3/4
        property real angle:-pi*3/4
        property var src: ShaderEffectSource{
            sourceItem: rpmGuage
            live: false
        }


        readonly property real pi: 3.1415926535

        vertexShader: "qrc:/Shaders/vert/guageMask.vert"
        fragmentShader:"qrc:/Shaders/frag/guageMask.frag"
    }

    
    Image{
        id:rpmTxt
        source: "qrc:/Images/NormalView/METER/prm_txt.png"
        x:770
        y:190
        width:379
        height:401
    }
    
    SequentialAnimation{
        id:normalToAdasAnimation
        onStarted: rootItem.focus=false
        PropertyAnimation{
            target:tachometer
            property:"opacity"
            duration: 330
            easing.type: Easing.Linear
            to:0
        }
        PropertyAnimation{
            target: tachometer
            property: "visible"
            duration: 0
            to:false
        }
    }
    
    SequentialAnimation{
        id:mapToNormalAnimation
        onStarted: rootItem.focus=false
        
        PauseAnimation {
            duration: 891 + 330 + 254
        }
        
        PropertyAnimation{
            target: tachometer
            property: "visible"
            duration: 0
            to:true
        }
        
        PropertyAnimation{
            target:tachometer
            property:"opacity"
            duration: 330
            easing.type: Easing.Linear
            to:1
        }
    }
    
}
