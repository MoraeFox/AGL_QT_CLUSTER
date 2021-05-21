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
    /* public functions */
    function open(){
        menuContentsClear.open()
    }

    function close(){
        menuContentsClear.close()
    }

    function incrementIndex(){
        if(menuMain.index === 0){
            menuRadio.incrementIndex()
        }else if(menuMain.index === 1){
            menuAdas.incrementIndex()
        }else if(menuMain.index === 2){
            menuAudio.incrementIndex()
        }
    }

    function decrementIndex(){
        if(menuMain.index === 0){
            menuRadio.decrementIndex()
        }else if(menuMain.index === 1){
            menuAdas.decrementIndex()
        }else if(menuMain.index === 2){
            menuAudio.decrementIndex()
        }
    }

    function enter(){
        if(menuMain.index === 0){
            /* nop */
        }else if(menuMain.index === 1){
            menuAdas.changeEnabled()
        }else if(menuMain.index === 2){
            /* nop */
        }
    }

    function startAnimationNormalToAdas(){
        normalToAdasAnimation.start()
    }

    function startAnimationMapToNormal(){
        mapToNormalAnimation.start()
    }


    Item{
        id: menuContentsClear
        width:826
        height: 358
        visible: false
        x: 52
        y: 298

        function open(){
            menuContentsClear.visible = false
            menuContentsBlur.visible = true
        }

        function close(){
            checkVisibleMenuContent()

            menuContentsClear.visible = true
            menuContentsBlur.visible = false
        }

        function checkVisibleMenuContent(){
            if(menuMain.index === 0){//radio
                menuAudio.visible = false
                menuAdas.visible = false
                menuRadio.visible = true
            }
            else if(menuMain.index === 1){//adas
                menuAudio.visible = false
                menuRadio.visible = false
                menuAdas.visible = true
            }
            else if(menuMain.index === 2){//music
                menuRadio.visible = false
                menuAdas.visible = false
                menuAudio.visible = true
            }
            else{
                //NOP
            }
        }
        
        MenuAdas {
            id: menuAdas
        }
        
        MenuAudio {
            id: menuAudio
        }
        
        MenuRadio {
            id: menuRadio
        }
        
    }
    
    GaussianBlur {
        id:menuContentsBlur
        anchors.fill:menuContentsClear
        source: menuContentsClear
        deviation: 4
        radius: 8
        samples: 16
        visible: true
    }

    SequentialAnimation{
        id:normalToAdasAnimation
        onStarted: rootItem.focus=false
        ParallelAnimation{
            NumberAnimation {
                target: menuContentsClear
                property: "opacity"
                duration: 330
                from:1
                to:0
            }

            NumberAnimation {
                target: menuContentsBlur
                property: "opacity"
                duration: 330
                from:1
                to:0
            }
        }

        NumberAnimation{
            target: menuContentsClear
            property: "x"
            duration:0
            from:52
            to:582
        }
        NumberAnimation{
            target: menuContentsClear
            property: "y"
            duration:0
            from:298
            to:362
        }

        PropertyAnimation{
            target: menuAudio
            property: "mode"
            duration:0
            to:"adas"
        }

        PropertyAnimation{
            target: menuRadio
            property: "mode"
            duration:0
            to:"adas"
        }

        PropertyAnimation{
            target: menuAdas
            property: "mode"
            duration:0
            to:"adas"
        }

        PauseAnimation {
            duration:891
        }

        ParallelAnimation{
            NumberAnimation {
                target: menuContentsClear
                property: "opacity"
                duration: 330
                from:0
                to:1
            }
            NumberAnimation {
                target: menuContentsBlur
                property: "opacity"
                duration: 330
                from:0
                to:1
            }
        }
    }

    SequentialAnimation{
        id:mapToNormalAnimation
        onStarted: rootItem.focus=false

        PauseAnimation {
            duration: 254
        }

        ParallelAnimation{
            NumberAnimation {
                target: menuContentsClear
                property: "opacity"
                duration: 330
                from: 1
                to: 0
            }

            NumberAnimation {
                target: menuContentsBlur
                property: "opacity"
                duration: 330
                from: 1
                to: 0
            }
        }

        PauseAnimation {
            duration: 891
        }

        NumberAnimation{
            target: menuContentsClear
            property: "x"
            duration: 0
            from: 582
            to: 52
        }
        NumberAnimation{
            target: menuContentsClear
            property: "y"
            duration: 0
            from: 362
            to: 298
        }

        PropertyAnimation{
            target: menuAdas
            property: "mode"
            duration: 0
            to: "normal"
        }

        PropertyAnimation{
            target: menuRadio
            property: "mode"
            duration: 0
            to: "normal"
        }

        PropertyAnimation{
            target: menuAudio
            property: "mode"
            duration: 0
            to: "normal"
        }

        ParallelAnimation{
            NumberAnimation {
                target: menuContentsClear
                property: "opacity"
                duration: 330
                from: 0
                to: 1
            }
            NumberAnimation {
                target: menuContentsBlur
                property: "opacity"
                duration: 330
                from: 0
                to: 1
            }
        }
    }
}
