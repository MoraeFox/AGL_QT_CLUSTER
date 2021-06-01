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
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.11

Item{
    id: adasIconAdas

    property bool enabled: false
    property bool focused: false

    property alias onImage: onImage.source
    property alias offImage: offImage.source
    property alias textImage: textImage.source

    Image{
        id: offImage
        source: "qrc:/Images/ADASView/MENU/adas_icon1_off.png"
        x:170
        y:186
        width:104
        height:90
        visible: !(adasIconAdas.enabled)
    }
    Image{
        id: onImage
        source: "qrc:/Images/ADASView/MENU/adas_icon1_on.png"
        x:170
        y:186
        width:104
        height:90
        visible: adasIconAdas.enabled
    }
    Image{
        id: textImage
        source: "qrc:/Images/ADASView/MENU/adas_text1.png"
        x:202
        y:278
        width:40
        height:18
        visible:true
    }
    Image{
        source: "qrc:/Images/ADASView/MENU/adas_panel1.png"
        x:165
        y:170
        width:114
        height:144
        visible: adasIconAdas.focused
    }
    
}
