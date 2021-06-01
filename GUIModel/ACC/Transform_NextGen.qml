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
