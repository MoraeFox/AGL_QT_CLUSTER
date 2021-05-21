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
import QtQuick.Shapes 1.14

Item {
    id: speedGuage
    x:666
    y:97
    width:588
    height:588
    property real speedValue

    readonly property real speedGuageMax: 100
    readonly property real speedGuageMin: 0

    onSpeedValueChanged: {
        limitSpeedValue();
        effectPwr.angle = (2.25 * speedValue*Math.PI/180)+effectPwr.angleBase
    }

    Connections{
        target: rootItem
        onTransNormalToAdas:{
            normalToAdasAnimation.start()
        }

        onTransAdasToMap:{
            /* nop */
        }

        onTransMapToNormal:{
            mapToNormalAnimation.start()
        }
    }

    function limitSpeedValue(){
        if(speedGuageMax < speedValue){
            speedValue = speedGuageMax
        }else if(speedValue < speedGuageMin){
            speedValue = speedGuageMin
        }
    }

    /* Guage - visible in Normal mode */
    Item {
        id:pwrGuageGroup
        width:588
        height:588
        
        Image{
            id:pwrGuage
            source: "qrc:/Images/NormalView/METER/pwr_guage.png"
            width:588
            height:588

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: 1
            visible: false
        }
        ShaderEffect{
            id: effectPwr
            anchors.fill: parent
            visible: true
            blending: true
            supportsAtlasTextures: true
            property real angleBase: -pi*1/2
            property real angle:-pi*1/2
            property var src: ShaderEffectSource{
                sourceItem: pwrGuage
                live: false
            }

            readonly property real pi: 3.1415926535

            vertexShader: "qrc:/Shaders/vert/guageMask.vert"
            fragmentShader:"qrc:/Shaders/frag/guageMask.frag"
        }
    }
    
    
    Image{
        id:ringLine
        source: "qrc:/Images/NormalView/METER/ring_line.ktx"
        width:588
        height:588
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Image{
        id:speedTxt
        source: "qrc:/Images/NormalView/SPEED/speed_txt.png"
        width:588
        height:588
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Image{
        id:ring5
        source: "qrc:/Images/NormalView/METER/ring5.png"
        width: 34
        height:24
        anchors.left: parent.left
        anchors.leftMargin: -11
        anchors.verticalCenter: parent.verticalCenter
    }
    
    SequentialAnimation{
        id: normalToAdasAnimation
        onStarted: rootItem.focus=false
        ParallelAnimation{
            NumberAnimation{
                target: speedTxt
                property: "opacity"
                duration: 330
                easing.type: Easing.InOutSine
                from:1.0
                to:0.5
            }
            
            SequentialAnimation{
                NumberAnimation{
                    target: pwrGuageGroup
                    property: "opacity"
                    duration: 330
                    easing.type: Easing.InOutSine
                    from:1.0
                    to:0.0
                }
                PropertyAnimation{
                    target: pwrGuageGroup
                    property: "visible"
                    duration: 0
                    easing.type: Easing.InOutSine
                    from:true
                    to:false
                }
            }
        }
        
        ParallelAnimation{
            /* down size */
            NumberAnimation{
                target: speedGuage
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:1
                to:0.75
            }
            
            /* translation */
            PathAnimation{
                target: speedGuage
                anchorPoint: Qt.point(speedGuage.width/2, speedGuage.height/2)
                orientation: PathAnimation.Fixed
                duration: 891
                easing.type: meterParts.easing
                
                path: Path {
                    startX: 960; startY: 391
                    PathLine { x: 540; y: 402 }
                }
            }
            
            SequentialAnimation{
                PauseAnimation {
                    duration: 891-330
                }
                NumberAnimation{
                    target: speedTxt
                    property: "opacity"
                    duration: 330
                    easing.type: Easing.InOutSine
                    from:0.5
                    to:1.0
                }
            }
        }
    }
    
    SequentialAnimation{
        id: mapToNormalAnimation
        onStarted: rootItem.focus=false
        
        PauseAnimation {
            duration: 254 + 330
        }
        
        
        ParallelAnimation{
            /* scaling */
            NumberAnimation{
                target: speedGuage
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:0.75
                to:1.0
            }
            
            /* slide */
            PathAnimation{
                target: speedGuage
                anchorPoint: Qt.point(speedGuage.width/2, speedGuage.height/2)
                orientation: PathAnimation.Fixed
                duration: 891
                easing.type: meterParts.easing
                
                path: Path {
                    startX: 540; startY: 402
                    PathLine { x: 960; y: 391 }
                }
            }
            
            NumberAnimation{
                target: speedTxt
                property: "opacity"
                duration: 330
                easing.type: Easing.InOutSine
                from:1.0
                to:0.5
            }
        }
        
        ParallelAnimation{
            NumberAnimation{
                target: speedTxt
                property: "opacity"
                duration: 330
                easing.type: Easing.InOutSine
                from:0.5
                to:1.0
            }
            
            SequentialAnimation{
                PropertyAnimation{
                    target: pwrGuageGroup
                    property: "visible"
                    duration: 0
                    easing.type: Easing.InOutSine
                    from:false
                    to:true
                }
                
                NumberAnimation{
                    target: pwrGuageGroup
                    property: "opacity"
                    duration: 330
                    easing.type: Easing.InOutSine
                    from:0.0
                    to:1.0
                }
            }
        }
        PauseAnimation {
            duration: 330
        }
    }
}
