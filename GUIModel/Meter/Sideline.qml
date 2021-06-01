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
    id: sideline
    width: 1780
    height: 1780
    x:70
    y:-499
    
    Connections{
        target: rootItem
        onTransNormalToAdas:{
            normalToAdasAnimation.start()
        }

        onTransAdasToMap:{
            / *nop */
        }

        onTransMapToNormal:{
            mapToNormalAnimation.start()
        }
    }

    Image{
        id:meterLineR
        source: "qrc:/Images/NormalView/METER/meter_line_r.ktx"
        x:980
        y:0
        width:800
        height:636
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
    }
    
    Image{
        id:meterLineL
        source: "qrc:/Images/NormalView/METER/meter_line_l.ktx"
        y:0
        width:800
        height:636
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0
    }
    
    transform: Rotation {
        id:sidelineRotation
        origin.x: sideline.width/2;
        origin.y: sideline.height/2;
        angle: 0
    }
    
    SequentialAnimation{
        id: normalToAdasAnimation
        onStarted: rootItem.focus=false
        PauseAnimation {
            duration: 330
        }
        
        ParallelAnimation{
            /* down size */
            NumberAnimation{
                target: sideline
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:1
                to:0.75
            }
            
            /* rotation */
            PropertyAnimation{
                target: sidelineRotation
                property: "angle"
                duration: 891
                easing.type: meterParts.easing
                from:0
                to:-90
            }
            
            /* translation */
            PathAnimation{
                target: sideline
                anchorPoint: Qt.point(sideline.width/2, sideline.height/2)
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
        PauseAnimation {
            duration: 254 + 330
        }
        
        ParallelAnimation{
            /* down size */
            NumberAnimation{
                target: sideline
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:0.75
                to:1.0
            }
            
            /* rotation */
            PropertyAnimation{
                target: sidelineRotation
                property: "angle"
                duration: 891
                easing.type: meterParts.easing
                from:-90
                to:0
            }
            
            /* translation */
            PathAnimation{
                target: sideline
                anchorPoint: Qt.point(sideline.width/2, sideline.height/2)
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
