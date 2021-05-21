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
