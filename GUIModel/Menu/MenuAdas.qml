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
    id:menuAdasRoot
    visible: false

    /* public properties */
    property alias mode:menuAdas.mode

    /* public functions */
    function incrementIndex(){
        menuAdas.incrementIndex()
    }

    function decrementIndex(){
        menuAdas.decrementIndex()
    }

    function changeEnabled(){
        menuAdas.changeEnabled()
    }


    Item {
        id: menuAdas
        visible:true
        width: 826
        height: 358

        property var mode: "normal" /* normal or adas */

        property int  index : 0
        property bool icon0Enabled : false
        property bool icon1Enabled : false
        property bool icon2Enabled : false

        property bool icon0Focused : true
        property bool icon1Focused : false
        property bool icon2Focused : false

        onModeChanged: {
            if(mode === "normal"){
                menuAdasNormal.visible = true
                menuAdasAdas.visible = false
            }else if(mode === "adas"){
                menuAdasNormal.visible = false
                menuAdasAdas.visible = true
            }else{
                menuAdasNormal.visible = true
                menuAdasAdas.visible = false
            }
        }

        function incrementIndex(){
            index++
            if(index === 3) index = 0

            if(index == 0){
                icon0Focused = true
                icon1Focused = false
                icon2Focused = false
            }
            else if(index == 1){
                icon0Focused = false
                icon1Focused = true
                icon2Focused = false
            }
            else if(index == 2){
                icon0Focused = false
                icon1Focused = false
                icon2Focused = true
            }
        }
        function decrementIndex(){
            index--
            if(index === -1) index = 2

            if(index == 0){
                icon0Focused = true
                icon1Focused = false
                icon2Focused = false
            }
            else if(index == 1){
                icon0Focused = false
                icon1Focused = true
                icon2Focused = false
            }
            else if(index == 2){
                icon0Focused = false
                icon1Focused = false
                icon2Focused = true
            }
        }
        function changeEnabled(){
            if(index === 0){ // left
                icon0Enabled = !(icon0Enabled)
            }
            if(index === 1) { //center
                icon1Enabled = !(icon1Enabled)
            }
            if(index === 2) { //right
                icon2Enabled = !(icon2Enabled)
            }
        }

        /**************adas image******************/
        Item{
            id: menuAdasNormal

            MenuAdasIconNormal {
                enabled: menuAdas.icon0Enabled
                focused: menuAdas.icon0Focused
                offImage: "qrc:/Images/NormalView/ADAS/adas_icon1_off.png"
                onImage: "qrc:/Images/NormalView/ADAS/adas_icon1_on.png"
                textImage: "qrc:/Images/NormalView/ADAS/adas_text1.png"
            }

            MenuAdasIconNormal {
                x:130
                enabled: menuAdas.icon1Enabled
                focused: menuAdas.icon1Focused
                offImage: "qrc:/Images/NormalView/ADAS/adas_icon2_off.png"
                onImage: "qrc:/Images/NormalView/ADAS/adas_icon2_on.png"
                textImage: "qrc:/Images/NormalView/ADAS/adas_text2.png"
            }

            MenuAdasIconNormal {
                x:260
                enabled: menuAdas.icon2Enabled
                focused: menuAdas.icon2Focused
                offImage: "qrc:/Images/NormalView/ADAS/adas_icon3_off.png"
                onImage: "qrc:/Images/NormalView/ADAS/adas_icon3_on.png"
                textImage: "qrc:/Images/NormalView/ADAS/adas_text3.png"
            }
        }


        Item{
            id: menuAdasAdas
            visible: false

            MenuAdasIconAdas {
                enabled: menuAdas.icon0Enabled
                focused: menuAdas.icon0Focused
                offImage: "qrc:/Images/ADASView/MENU/adas_icon1_off.png"
                onImage: "qrc:/Images/ADASView/MENU/adas_icon1_on.png"
                textImage: "qrc:/Images/ADASView/MENU/adas_text1.png"
            }

            MenuAdasIconAdas {
                x:120
                enabled: menuAdas.icon1Enabled
                focused: menuAdas.icon1Focused
                offImage: "qrc:/Images/ADASView/MENU/adas_icon2_off.png"
                onImage: "qrc:/Images/ADASView/MENU/adas_icon2_on.png"
                textImage: "qrc:/Images/ADASView/MENU/adas_text2.png"
            }

            MenuAdasIconAdas {
                x:240
                enabled: menuAdas.icon2Enabled
                focused: menuAdas.icon2Focused
                offImage: "qrc:/Images/ADASView/MENU/adas_icon3_off.png"
                onImage: "qrc:/Images/ADASView/MENU/adas_icon3_on.png"
                textImage: "qrc:/Images/ADASView/MENU/adas_text3.png"
            }

        }
    }
}
