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
    id: ring
    width:656
    height:656
    x:632
    y:63

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
        id:ring1
        source: "qrc:/Images/NormalView/METER/ring1.ktx"
        width:656
        height:656
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Image{
        id:ring3
        source: "qrc:/Images/NormalView/METER/ring3.ktx"
        width:456
        height:456
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Image{
        id:ring2
        source: "qrc:/Images/NormalView/METER/ring2.ktx"
        width:588
        height:588
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
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
                target: ring
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:1
                to:0.75
            }
            
            /* translation */
            PathAnimation{
                target: ring
                anchorPoint: Qt.point(ring.width/2, ring.height/2)
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
                target: ring
                property: "scale"
                duration: 891
                easing.type: meterParts.easing
                from:0.75
                to:1.0
            }
            
            /* translation */
            PathAnimation{
                target: ring
                anchorPoint: Qt.point(ring.width/2, ring.height/2)
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
