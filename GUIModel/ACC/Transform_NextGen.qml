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
import Qt3D.Core 2.14
import Qt3D.Extras 2.14

Transform {
    id: root

    //----- initial parameter -----//
    property real default_px:  0.0
    property real default_py:  0.0
    property real default_pz:  0.0
    property real default_rx:  0.0
    property real default_ry:  0.0
    property real default_rz:  0.0
    property real default_s :  1.0

    //----- for animation -----//
    property real posi_x: default_px
    property real posi_y: default_py
    property real posi_z: default_pz

    property real roll_x: default_rx
    property real roll_y: default_ry
    property real roll_z: default_rz

    property real scale: default_s

    property real scale_x: scale
    property real scale_y: scale
    property real scale_z: scale

    scale3D:  Qt.vector3d(scale_x,scale_y,scale_z)
    rotationX: roll_x
    rotationY: roll_y
    rotationZ: roll_z
    translation: Qt.vector3d(posi_x,posi_y,posi_z)
}
