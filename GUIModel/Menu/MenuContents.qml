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
