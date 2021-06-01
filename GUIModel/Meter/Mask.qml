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
    id:mask
    visible: false
    opacity: 0

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

    Item {
        id:maskTop
        width: 1920
        height: 128
        
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#FF000000"
                }
                GradientStop {
                    position: 0.25
                    color: "#FF000000"
                }
                GradientStop {
                    position: 1.0
                    color: "#00000000"
                }
                
            }
        }
    }
    
    Item {
        id:maskBottom
        x:480
        y:720 - 64
        width: 120
        height: 64
        
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 1.0
                    color: "#FF000000"
                }
                GradientStop {
                    position: 0.0
                    color: "#00000000"
                }
                
            }
        }
    }
    
    SequentialAnimation{
        id:normalToAdasAnimation
        onStarted: rootItem.focus=false
        PauseAnimation {
            duration: 330
        }
        
        PropertyAnimation{
            target: mask
            property: "visible"
            duration:0
            from:false
            to:true
        }
        
        PropertyAnimation{
            target: mask
            property: "opacity"
            duration:891
            from:0
            to:1
        }
        
        
    }
    
    SequentialAnimation{
        id:mapToNormalAnimation
        onStarted: rootItem.focus=false
        PauseAnimation {
            duration: 254 + 330
        }
        
        PropertyAnimation{
            target: mask
            property: "opacity"
            duration:891
            from:1
            to:0
        }
        
        PropertyAnimation{
            target: mask
            property: "visible"
            duration:0
            from:true
            to:false
        }
        
    }
    
}
