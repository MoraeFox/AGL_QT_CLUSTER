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
    id: menuRoot

    Connections{
        target: rootItem
        onTransNormalToAdas:{
            menuMain.startAnimationNormalToAdas()
            menuContents.startAnimationNormalToAdas()
            menuShade.startAnimationNormalToAdas()
        }

        onTransAdasToMap:{
            /**/
        }

        onTransMapToNormal:{
            menuMain.startAnimationMapToNormal()
            menuContents.startAnimationMapToNormal()
            menuShade.startAnimationMapToNormal()
        }

        onKeyPressed_Up:{
            if(menu.state === "open"){
                menuMain.incrementIndex()
            }
        }

        onKeyPressed_Down:{
            if(menu.state === "open"){
                menuMain.decrementIndex()
            }
        }

        onKeyPressed_Left:{
            if(menu.state === "close"){
                menuContents.decrementIndex()
            }
        }

        onKeyPressed_Right:{
            if(menu.state === "close"){
                menuContents.incrementIndex()
            }
        }

        onKeyPressed_Enter:{
            if(menu.state === "close"){
                menuContents.enter()
            }else if(menu.state === "open"){
                menuContents.close()
                menuMain.close()
                menu.state = "close"
            }
        }

        onKeyPressed_Menu:{
            if(menu.state === "close"){
                menuContents.open()
                menuMain.open()
                menu.state = "open"
            }
        }
    }

    Item{
        id: menu

        property var mode: "normal" /* Normal or Adas */
        property var state: "open" /* open or close  */

        MenuContents {
            id: menuContents
        }

        /************************************************menu_area****************************************************/
        MenuMain {
            id: menuMain
        }

        MenuShade {
            id: menuShade
        }
    }




}
