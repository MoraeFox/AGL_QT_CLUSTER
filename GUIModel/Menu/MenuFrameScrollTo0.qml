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

import QtQuick 2.0

ParallelAnimation{
    property int scrollDuration: 240
    onStarted: rootItem.focus=false
    onStopped: rootItem.focus=true
    PropertyAnimation{
        target: menuFrameBgTop
        property: "opacity"
        to: 1.0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    PropertyAnimation{
        target: menuFrameBgCenter
        property: "opacity"
        to: 0.0
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
        to: 116 * 0.4
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
        to:0.4
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuIcon
        properties: "x"
        to: 26 * 0.4  * menuFrameItem.direction + menuFrameItem.margin
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuText
        properties: "scale"
        to: 0.4
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuText
        properties: "x"
        to: 122 * 0.4  * menuFrameItem.direction + menuFrameItem.margin
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    PropertyAnimation{
        target: menuFrameItem
        properties: "opacity"
        to: 0
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation{
        target: menuFrameItem
        properties: "x"
        to: 100 * menuFrameItem.direction
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        target: menuFrameItem
        property: "y"
        to: -68
        duration: scrollDuration
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        target: menuFrame
        property: "z"
        to: 0
        duration: 0
    }
}
