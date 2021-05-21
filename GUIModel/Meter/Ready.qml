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
    id: ready
    x:666
    y:97
    width:588
    height:588
    
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

    Image{
        id:readyBase
        source: "qrc:/Images/NormalView/METER/ready_base.png"
        width:159
        height:51
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Image{
        id:readyText
        source: "qrc:/Images/NormalView/METER/ready_text-on.png"
        width:159
        height:51
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    
    SequentialAnimation{
        id: normalToAdasAnimation
        onStarted: rootItem.focus=false
        /* delay */
        PauseAnimation {
            duration: 330
        }
        
        ParallelAnimation{
            NumberAnimation{
                target: ready
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:1.0
                to:0.75
            }
            
            /* translation */
            PathAnimation{
                target: ready
                anchorPoint: Qt.point(ready.width/2, ready.height/2)
                orientation: PathAnimation.Fixed
                duration: 891
                easing.type: meterParts.easing
                
                path: Path {
                    startX: 960; startY: 391
                    PathLine { x: 540; y: 402 }
                }
            }
        }
    }
    
    SequentialAnimation{
        id: mapToNormalAnimation
        onStarted: rootItem.focus=false
        /* delay */
        PauseAnimation {
            duration: 254
        }
        
        PauseAnimation {
            duration: 330
        }
        
        ParallelAnimation{
            NumberAnimation{
                target: ready
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:0.75
                to:1.00
            }
            
            /* translation */
            PathAnimation{
                target: ready
                anchorPoint: Qt.point(ready.width/2, ready.height/2)
                orientation: PathAnimation.Fixed
                duration: 891
                easing.type: meterParts.easing
                
                path: Path {
                    startX: 540; startY: 402
                    PathLine { x: 960; y: 391 }
                }
            }
        }
    }
}
