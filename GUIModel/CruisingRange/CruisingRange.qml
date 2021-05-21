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
    id: cruisingRange
    
    x:258
    y:309
    width:268
    height:39
    
    property real cruisingRangeValue

    readonly property real cruisingRangeValueMax: 999.9
    readonly property real cruisingRangeValueMin: 0

    onCruisingRangeValueChanged: {
        updateCruisingRangeValue();
        updateCruisingRangeVisible();
    }

    Connections{
        target: rootItem
        onTransNormalToAdas:{
            normalToAdasAnimationFuel.start()
        }

        onTransAdasToMap:{
            /**/
        }

        onTransMapToNormal:{
            mapToNormalAnimationFuel.start()
        }
    }

    function updateCruisingRangeValue(){
        cruisingRangeParts.cruisingRangeValue100 = (cruisingRangeValue/100)%10
        cruisingRangeParts.cruisingRangeValue10 = (cruisingRangeValue/10)%10
        cruisingRangeParts.cruisingRangeValue1 = cruisingRangeValue%10
        cruisingRangeParts.cruisingRangeValue01 = 0
    }

    function updateCruisingRangeVisible(){
        if((100 <= cruisingRangeValue) && (cruisingRangeValue <= cruisingRangeValueMax)){
            fuelNum01.visible = true
            fuelNum1.visible = true
            fuelNum10.visible = true
            fuelNum100.visible = true
        }else if((10 <= cruisingRangeValue) && (cruisingRangeValue < 100)){
            fuelNum01.visible = true
            fuelNum1.visible = true
            fuelNum10.visible = true
            fuelNum100.visible = false
        }else if((1 <= cruisingRangeValue) && (cruisingRangeValue < 10)){
            fuelNum01.visible = true
            fuelNum1.visible = true
            fuelNum10.visible = false
            fuelNum100.visible = false
        }else if((cruisingRangeValueMin <= cruisingRangeValue) && (cruisingRangeValue < 1)){
            fuelNum01.visible = true
            fuelNum1.visible = true
            fuelNum10.visible = false
            fuelNum100.visible = false
        }else{
            fuelNum01.visible = false
            fuelNum1.visible = false
            fuelNum10.visible = false
            fuelNum100.visible = false
        }
    }

    Item{
        id: cruisingRangeParts
        property int cruisingRangeValue100 //hundreds place
        property int cruisingRangeValue10  //tens place
        property int cruisingRangeValue1   //ones place
        property int cruisingRangeValue01  //first decimal place
        Image{
            id: fuelUnit
            source: "qrc:/Images/NormalView/FUEL/fuel_unit.png"
            x:228
            y:9
            width:40
            height:26
        }
        Image{
            id: fuelNum01
            source: "qrc:/Images/NormalView/FUEL/fuel_num1-" + parent.cruisingRangeValue01 + ".png"
            x:202
            y:6
            width:19
            height:29
            visible: false
        }
        Image{
            id: fuelNum1
            source: "qrc:/Images/NormalView/FUEL/fuel_num10-" + parent.cruisingRangeValue1 + ".png"
            x:174
            y:6
            width:19
            height:29
            visible: false
        }
        Image{
            id: fuelNum10
            source: "qrc:/Images/NormalView/FUEL/fuel_num100-" + parent.cruisingRangeValue10 + ".png"
            x:154
            y:6
            width:19
            height:29
            visible:false
        }
        Image{
            id: fuelNum100
            source: "qrc:/Images/NormalView/FUEL/fuel_num1000-" + parent.cruisingRangeValue100 + ".png"
            x:134
            y:6
            width:19
            height:29
            visible:false
        }
        Image{
            id: fuelDot
            source: "qrc:/Images/NormalView/FUEL/fuel_dot.png"
            x:194
            y:28
            width:6
            height:6
        }
        Image{
            id: fuelIcon
            source: "qrc:/Images/NormalView/FUEL/fuel_icon.png"
            x:0
            y:0
            width:119
            height:39
        }
    }

    SequentialAnimation{
        id:normalToAdasAnimationFuel
        onStarted: rootItem.focus=false
        PauseAnimation{
            duration:330
        }

        PathAnimation{
            target: cruisingRange
            duration: 891
            easing.type: Easing.InOutSine
            path:Path {
                startX: 258; startY: 309
                PathArc {
                    x: 238; y: 657
                    radiusX: 180; radiusY: 180
                    direction: PathArc.Counterclockwise
                }
            }
        }
    }

    SequentialAnimation{
        id:mapToNormalAnimationFuel
        onStarted: rootItem.focus=false
        PauseAnimation{
            duration: 254 + 330
        }

        PathAnimation{
            target: cruisingRange
            duration: 891
            easing.type: Easing.InOutSine
            path:Path {
                startX: 238; startY: 657
                PathArc {
                    x: 258; y: 309
                    radiusX: 180; radiusY: 180
                    direction: PathArc.Clockwise
                }
            }
        }

    }
}
