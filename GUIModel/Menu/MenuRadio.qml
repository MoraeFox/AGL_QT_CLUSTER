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

Item {
    id: menuRadio
    visible:false
    width: 826
    height: 358
    property string mode: "normal"
    
    function incrementIndex(){
        radioPanels.incrementIndex()
    }
    
    function decrementIndex(){
        radioPanels.decrementIndex()
    }
    
    Item{
        id:radioPanels
        
        property int index: 0
        
        function incrementIndex(){
            index++
            if(index === 3) index = 0
            
            if(index === 0){
                radioPanel2.slideOut(+1) /*Slide out to right*/
                radioPanel0.slideIn(+1)  /*Slide in from left*/
            }else if(index === 1){
                radioPanel0.slideOut(+1)
                radioPanel1.slideIn(+1)
            }else if(index === 2){
                radioPanel1.slideOut(+1)
                radioPanel2.slideIn(+1)
            }
        }
        
        function decrementIndex(){
            index--
            if(index === -1) index = 2
            
            if(index === 2){
                radioPanel0.slideOut(-1) /*Slide out to left*/
                radioPanel2.slideIn(-1)  /*Slide in from right*/
            }else if(index === 1){
                radioPanel2.slideOut(-1)
                radioPanel1.slideIn(-1)
            }else if(index === 0){
                radioPanel1.slideOut(-1)
                radioPanel0.slideIn(-1)
            }
        }
        
        
        MenuRadioPanel{
            id:      radioPanel0
            mode:    menuRadio.mode
            icon:    "qrc:/Images/ADASView/MENU/radio_icon_FM.png"
            title:   "InterFM"
            channel: "89.7MHz"
            bg:      "qrc:/Images/ADASView/MENU/radio_blur_FM.png"
            panelVisible: true
        }
        MenuRadioPanel{
            id:      radioPanel1
            mode:    menuRadio.mode
            icon:    "qrc:/Images/ADASView/MENU/radio_icon_FM.png"
            title:   "J-WAVE"
            channel: "81.3MHz"
            bg:      "qrc:/Images/ADASView/MENU/radio_blur_FM.png"
            panelVisible: false
        }
        MenuRadioPanel{
            id:      radioPanel2
            mode:    menuRadio.mode
            icon:    "qrc:/Images/ADASView/MENU/radio_icon_AM.png"
            title:   "TBS Radio"
            channel: "954kHz"
            bg:      "qrc:/Images/ADASView/MENU/radio_blur_AM.png"
            panelVisible: false
        }
    }
}
