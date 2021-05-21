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
