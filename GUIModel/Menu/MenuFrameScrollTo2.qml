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

import QtQuick 2.0

ParallelAnimation{
    property int scrollDuration: 240
    onStarted: rootItem.focus=false
    onStopped: rootItem.focus=true
    
    PropertyAnimation{
        target: menuFrameBgTop
        property: "opacity"
        to: 0.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    PropertyAnimation{
        target: menuFrameBgCenter
        property: "opacity"
        to: 1.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    PropertyAnimation{
        target: menuFrameBgBottom
        property: "opacity"
        to: 0.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuFrameBg
        properties: "width"
        to: 460
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuFrameBg
        properties: "height"
        to: 116
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuFrameBg
        properties: "x"
        to: 0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuIcon
        properties: "scale"
        to:1.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuIcon
        properties: "x"
        to:26 * menuFrameItem.direction + menuFrameItem.margin
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuText
        properties: "scale"
        to:1.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuText
        properties: "x"
        to: 122 * menuFrameItem.direction + menuFrameItem.margin
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuFrameItem
        properties: "opacity"
        to: 1.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuFrameItem
        properties: "x"
        to:0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        target: menuFrameItem
        property: "y"
        to:0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        target: menuFrame
        property: "z"
        to: 0.4
        duration: 0
    }
}
