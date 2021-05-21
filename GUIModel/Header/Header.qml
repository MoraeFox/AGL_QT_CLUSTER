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
