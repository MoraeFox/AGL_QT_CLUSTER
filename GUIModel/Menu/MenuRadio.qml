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
