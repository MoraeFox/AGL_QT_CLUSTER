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
