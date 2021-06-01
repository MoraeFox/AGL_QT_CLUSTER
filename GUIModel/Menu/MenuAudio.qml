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
    id: menuAudio
    visible:false
    width: 826
    height: 358
    property string mode: "normal"
    
    function incrementIndex(){
        audioPanels.incrementIndex()
    }
    
    function decrementIndex(){
        audioPanels.decrementIndex()
    }
    
    Item{
        id: audioPanels
        height: 358
        
        property int index: 0
        
        function incrementIndex(){
            index++
            if(index === 3) index = 0
            
            if(index === 0){
                audioPanel2.slideOut(+1) /*Slide out to right*/
                audioPanel0.slideIn(+1)  /*Slide in from left*/
            }else if(index === 1){
                audioPanel0.slideOut(+1)
                audioPanel1.slideIn(+1)
            }else if(index === 2){
                audioPanel1.slideOut(+1)
                audioPanel2.slideIn(+1)
            }
        }
        
        function decrementIndex(){
            index--
            if(index === -1) index = 2
            
            if(index === 2){
                audioPanel0.slideOut(-1) /*Slide out to left*/
                audioPanel2.slideIn(-1)  /*Slide in from right*/
            }else if(index === 1){
                audioPanel2.slideOut(-1)
                audioPanel1.slideIn(-1)
            }else if(index === 0){
                audioPanel1.slideOut(-1)
                audioPanel0.slideIn(-1)
            }
        }

        MenuAudioPanel{
            id:     audioPanel0
            mode:   menuAudio.mode
            icon:   "qrc:/Images/ADASView/MENU/jacket1.png"
            title:  "You Don't Know Me"
            artist: "Martin Crown"
            bg:     "qrc:/Images/ADASView/MENU/jacket_blur1.png"
            panelVisible: true
       }
        MenuAudioPanel{
            id:     audioPanel1
            mode:   menuAudio.mode
            icon:   "qrc:/Images/ADASView/MENU/jacket2.png"
            title:  "LIGHT"
            artist: "Amelia Sedgwick"
            bg:     "qrc:/Images/ADASView/MENU/jacket_blur2.png"
            panelVisible: false
       }
        MenuAudioPanel{
            id:     audioPanel2
            mode:   menuAudio.mode
            icon:   "qrc:/Images/ADASView/MENU/jacket3.png"
            title:  "Ocean Power"
            artist: "Oceania Poseidon"
            bg:     "qrc:/Images/ADASView/MENU/jacket_blur3.png"
            panelVisible: false
        }
    }
}
