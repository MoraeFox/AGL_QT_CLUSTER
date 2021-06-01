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
