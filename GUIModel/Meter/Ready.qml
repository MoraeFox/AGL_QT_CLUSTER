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
