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

import QtQuick 2.14

Item {
    id: header
/***********Outside temperature************/
    OutsideTemperature {
        id: outsideTemperature
    }

/***********clock************/
    Clock {
        id: clock
    }

/***********Turn_parts************/
    Item{
        id: turn_parts
        Image{
          id: turn_l_on
          source: "qrc:/Images/NormalView/TURN/turn_l_on.png"
          x: 467
          y: 43
          width: 44
          height: 44
          visible: false
        }
        Image{
          id: turn_l_off
          source: "qrc:/Images/NormalView/TURN/turn_l_off.png"
          x: 467
          y: 43
          width: 44
          height: 44
          visible: true
        }
        Image{
          id: turn_r_on
          source: "qrc:/Images/NormalView/TURN/turn_r_on.png"
          x: 1409
          y: 43
          width: 44
          height: 44
          visible: false
        }
        Image{
          id: turn_r_off
          source: "qrc:/Images/NormalView/TURN/turn_r_off.png"
          x: 1409
          y: 43
          width: 44
          height: 44
          visible: true
        }
    }
}
