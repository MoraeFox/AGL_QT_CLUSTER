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
