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

Item {
    id: outsideTemperature
    property int tempValue

    readonly property int tempValueMax: 131
    readonly property int tempValueMin: -20

    //        property int tempValue_10: (tempValue/10)%10
    //        property int tempValue_1: tempValue%10
    onTempValueChanged: {
        updateOutsideTemperatureVisible();
    }
    Component.onCompleted: tempValue = -20

    function updateOutsideTemperatureVisible(){
        if((tempValueMin <= tempValue) && (tempValue <= tempValueMax)){
            tempValueText.visible = true
        }else{
            tempValueText.visible = false
        }
    }

    Image{
        id: tempUnit
        source: "qrc:/Images/NormalView/TEMP/temp_unit.png"
        x: 671
        y: 58
        width: 32
        height: 24
    }
    FontLoader { id: localFont; source: "qrc:/Fonts/Inter-Regular.ttf"; }
    Text{
        id: tempValueText
        text: parent.tempValue
        renderType: Text.NativeRendering
        anchors.right: tempUnit.left
        horizontalAlignment :Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 1
        
        y: 49
        width: 46
        height: 33
        //font { family: localFont.name; pointSize: 29; capitalization: Font.Capitalize }
        font.family: localFont.name
        font.pointSize: 29
        font.letterSpacing: 1
        color: "White"
        visible: false
        
    }
    
    //        Image{
    //          id: temp_01
    //          source: "qrc:/Images/NormalView/TEMP/temp_01-" + parent.tempValue_1 + ".png"
    //          x:647
    //          y:49
    //          width:23
    //          height:33
    //          opacity: 0.7
    //          visible: {
    //               true
    //          }
    //        }
    //        Image{
    //          id: temp_10
    //          source: "qrc:/Images/NormalView/TEMP/temp_10-" + parent.tempValue_10 + ".png"
    //          x:624
    //          y:49
    //          width:23
    //          height:33
    //          opacity: 0.7
    //          visible: {
    //               true
    //          }
    //        }
}
