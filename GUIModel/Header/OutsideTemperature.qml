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
