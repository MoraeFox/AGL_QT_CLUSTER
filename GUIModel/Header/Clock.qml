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

Item{
    id: clock
    property int timeHour
    property int timeMinute

    readonly property int timeHourMax: 23
    readonly property int timeHourMin: 0
    readonly property int timeMinuteMax: 59
    readonly property int timeMinuteMin: 0

    onTimeMinuteChanged: {
        updateMinute();
        updateClockVisible();
    }
    onTimeHourChanged: {
        hourUpdate();
        updateClockVisible();
    }

    function updateMinute(){
        clockParts.timeMinute10 = (timeMinute/10)%10
        clockParts.timeMinute1 = timeMinute%10
    }

    function hourUpdate(){
        clockParts.timeHour10 = (timeHour/10)%10
        clockParts.timeHour1 = timeHour%10
    }

    function updateClockVisible(){
        if((timeMinuteMin <= timeMinute) && (timeMinute <= timeMinuteMax)){
            if((timeHourMin <= timeHour) && (timeHour <= 9)){
                timeMinute1.visible = true
                timeMinute10.visible = true
                timeHour1.visible = true
                timeHour10.visible = false
            }else if((10 <= timeHour) && (timeHour <= timeHourMax)){
                timeMinute1.visible = true
                timeMinute10.visible = true
                timeHour1.visible = true
                timeHour10.visible = true
            }else{
                timeMinute1.visible = false
                timeMinute10.visible = false
                timeHour1.visible = false
                timeHour10.visible = false
            }
        }else{
            timeMinute1.visible = false
            timeMinute10.visible = false
            timeHour1.visible = false
            timeHour10.visible = false
        }
    }

    Component.onCompleted: {
        timeHour = 20
        timeMinute = 34
    }
    Item{
        id: clockParts
        property int timeHour10    //tens place of hour
        property int timeHour1     //ones place of hour
        property int timeMinute10  //tens place of minute
        property int timeMinute1   //ones place of minute
        Image{
            id: timeCron
            source: "qrc:/Images/NormalView/TIME/time_cron.png"
            x:1239
            y:49
            width:11
            height:34
        }
        Image{
            id: timeMinute1
            source: "qrc:/Images/NormalView/TIME/time_m1-" + parent.timeMinute1 + ".png"
            x:1275
            y:49
            width:23
            height:34
            visible: false
        }
        Image{
            id: timeMinute10
            source: "qrc:/Images/NormalView/TIME/time_m10-" + parent.timeMinute10 + ".png"
            x:1252
            y:49
            width:23
            height:34
            visible: false
        }
        Image{
            id: timeHour1
            source: "qrc:/Images/NormalView/TIME/time_h1-" + parent.timeHour1 + ".png"
            x:1214
            y:49
            width:23
            height:34
            visible: false
        }
        Image{
            id: timeHour10
            source: "qrc:/Images/NormalView/TIME/time_h10-" + parent.timeHour10 + ".png"
            x:1191
            y:49
            width:23
            height:34
            visible: false
        }
    }
}
