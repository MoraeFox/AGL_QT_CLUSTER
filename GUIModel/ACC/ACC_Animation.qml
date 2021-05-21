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
import Qt3D.Animation 2.14

Item {
    id:car_Anim

    property int acc_line_pos   : 0  //0:hide 1:far 2:mid 3:near
    property int cur_line_pos   : 0
    property int acc_enable     : 0  //0:OFF 1:ON (follow)
    property int acc_icon       : 0  //0:hide 1:icon 2:???
    property int acc_value      : 148  //0:hide 1~999:value
    property int acc_value1     : acc_value%10
    property int acc_value10    : (acc_value/10)%10
    property int acc_value100   : (acc_value/100)%10
    property int acc_car_pos    : 0  //0:hide 1:far 2:mid 3:near
    property int cur_car_pos    : 0
    property int received_tbt_id: stage.received_id
    property int current_tbt_id

    onAcc_line_posChanged: {
        lineposchange()
    }
    onAcc_enableChanged: {
        enablechange()
    }
    onAcc_car_posChanged: {
        carposchange()
    }
    onReceived_tbt_idChanged: {
        tbt_idchange()
    }

    Connections{
        target: rootItem
        onTransNormalToAdas:{
            if(rootItem.set_state == "set_default"){
                fadeout_in_default.start()
            }else if(rootItem.set_state == "set_middle"){
                fadeout_in_mid.start()
            }else if(rootItem.set_state == "set_near"){
                fadeout_in_near.start()
            }
            cameraToAdasPos.start()

            if(rootItem.car_state == "normal_default"){
                rootItem.car_state = "adas_default"}
            else if(rootItem.car_state == "normal_middle"){
                rootItem.car_state = "adas_middle"}
            else if(rootItem.car_state == "normal_near"){
                rootItem.car_state = "adas_near"}

            if(rootItem.arrow_state == "arrow_normal_default"){
                rootItem.arrow_state = "arrow_adas_default"}
            else if(rootItem.arrow_state == "arrow_normal_middle"){
                rootItem.arrow_state = "arrow_adas_middle"}
            else if(rootItem.arrow_state == "arrow_normal_near"){
                rootItem.arrow_state = "arrow_adas_near"}
        }

        onTransAdasToMap:{
            adasToMapAnimation_acc3d.start()

        }

        onTransMapToNormal:{
            ddditemTonormalsize.start()
            if(rootItem.set_state == "set_default"){
                fadeout_in_default.start()
            }else if(rootItem.set_state == "set_middle"){
                fadeout_in_mid.start()
            }else if(rootItem.set_state == "set_near"){
                fadeout_in_near.start()
            }
            cameraTonormalPos.start()


            if(rootItem.car_state == "adas_default"){
                rootItem.car_state = "normal_default"}
            else if(rootItem.car_state == "adas_middle"){
                rootItem.car_state = "normal_middle"}
            else if(rootItem.car_state == "adas_near"){
                rootItem.car_state = "normal_near"}

            if(rootItem.arrow_state == "arrow_adas_default"){
                rootItem.arrow_state = "arrow_normal_default"}
            else if(rootItem.arrow_state == "arrow_adas_middle"){
                rootItem.arrow_state = "arrow_normal_middle"}
            else if(rootItem.arrow_state == "arrow_adas_near"){
                rootItem.arrow_state = "arrow_normal_near"}
        }
    }

    function lineposchange(){
    }

    function enablechange(){
    }

    function carposchange(){
    }

    function tbt_idchange(){////////////////////
            switch(received_tbt_id){
            case 1:
                tbt_arrow_anim_to_LF.start()
                break;
            case 2:
                tbt_arrow_anim_to_L.start()
                break;
            case 3:
                tbt_arrow_anim_to_RF.start()
                break;
            case 4:
                tbt_arrow_anim_to_R.start()
                break;
            default:
                break;
            }
        stage.current_id=stage.received_id
    }
    /*----------------------------------- arrow animation ------------------------------------*/
        ParallelAnimation{
            id: tbt_arrow_anim_to_LF
            NumberAnimation {
                target: stage.material_tbt_LF
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_L,stage.material_tbt_RF,stage.material_tbt_R]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.material_tbt_shadow_LF
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_shadow_L,stage.material_tbt_shadow_RF,stage.material_tbt_shadow_R]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.trans_tbt_LF
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.52 : 0.5
            }
            NumberAnimation {
                targets: [stage.trans_tbt_L,stage.trans_tbt_RF,stage.trans_tbt_R]
                properties: "default_py"
                duration: 1000
                to: 0.5
            }
            NumberAnimation {
                target: stage.trans_tbt_shadow_LF
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.2 : 0.1
            }
            NumberAnimation {
                targets: [stage.trans_tbt_shadow_L,stage.trans_tbt_RF,stage.trans_tbt_R]
                properties: "default_py"
                duration: 1000
                to: 0.1
            }
        }
        ParallelAnimation{
            id: tbt_arrow_anim_to_L
            NumberAnimation {
                target: stage.material_tbt_L
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_LF,stage.material_tbt_RF,stage.material_tbt_R]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.material_tbt_shadow_L
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_shadow_LF,stage.material_tbt_shadow_RF,stage.material_tbt_shadow_R]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.trans_tbt_L
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.52 : 0.5
            }
            NumberAnimation {
                targets: [stage.trans_tbt_LF,stage.trans_tbt_RF,stage.trans_tbt_R]
                properties: "default_py"
                duration: 1000
                to: 0.5
            }
            NumberAnimation {
                target: stage.trans_tbt_shadow_L
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.2 : 0.1
            }
            NumberAnimation {
                targets: [stage.trans_tbt_shadow_LF,stage.trans_tbt_shadow_RF,stage.trans_tbt_shadow_R]
                properties: "default_py"
                duration: 1000
                to: 0.1
            }
        }
        ParallelAnimation{
            id: tbt_arrow_anim_to_RF
            NumberAnimation {
                target: stage.material_tbt_RF
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_LF,stage.material_tbt_L,stage.material_tbt_R]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.material_tbt_shadow_RF
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_shadow_LF,stage.material_tbt_shadow_L,stage.material_tbt_shadow_R]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.trans_tbt_RF
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.52 : 0.5
            }
            NumberAnimation {
                targets: [stage.trans_tbt_LF,stage.trans_tbt_L,stage.trans_tbt_R]
                properties: "default_py"
                duration: 1000
                to: 0.5
            }
            NumberAnimation {
                target: stage.trans_tbt_shadow_RF
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.2 : 0.1
            }
            NumberAnimation {
                targets: [stage.trans_tbt_shadow_LF,stage.trans_tbt_shadow_L,stage.trans_tbt_shadow_R]
                properties: "default_py"
                duration: 1000
                to: 0.1
            }
        }
        ParallelAnimation{
            id: tbt_arrow_anim_to_R
            NumberAnimation {
                target: stage.material_tbt_R
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_LF,stage.material_tbt_L,stage.material_tbt_RF]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.material_tbt_shadow_R
                property: "u_alphaFactor"
                duration: 1000
                to: rootItem.mode == 1 ? 1 : 0
            }
            NumberAnimation {
                targets: [stage.material_tbt_shadow_LF,stage.material_tbt_shadow_L,stage.material_tbt_shadow_RF]
                properties: "u_alphaFactor"
                duration: 1000
                to: 0
            }
            NumberAnimation {
                target: stage.trans_tbt_R
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.52 : 0.5
            }
            NumberAnimation {
                targets: [stage.trans_tbt_LF,stage.trans_tbt_L,stage.trans_tbt_RF]
                properties: "default_py"
                duration: 1000
                to: 0.5
            }
            NumberAnimation {
                target: stage.trans_tbt_shadow_R
                property: "default_py"
                duration: 1000
                to: rootItem.mode == 1 ? 0.2 : 0.1
            }
            NumberAnimation {
                targets: [stage.trans_tbt_shadow_LF,stage.trans_tbt_shadow_L,stage.trans_tbt_shadow_RF]
                properties: "default_py"
                duration: 1000
                to: 0.1
            }
        }
    SequentialAnimation{
        id:fadeout_in_default
        onStarted: rootItem.focus=false
        ParallelAnimation{
            NumberAnimation { target: stage.material_distance_set;        property: "u_alphaFactor";   duration: 330; from:0.2; to: 0 }
            NumberAnimation { target: stage.material_distance_arrow;      property: "u_alphaFactor";   duration: 330; from:1;   to: 0 }
            NumberAnimation { target: stage.material_distance_base;       property: "u_alphaFactor";   duration: 330; from:1;   to: 0 }
            NumberAnimation { targets: [stage.material_tbt_LF, stage.material_tbt_L, stage.material_tbt_RF, stage.material_tbt_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_LF, stage.trans_tbt_L, stage.trans_tbt_RF, stage.trans_tbt_R];property: "default_py";duration: 0;to: 0.0 }
            NumberAnimation { targets: [stage.material_tbt_shadow_LF, stage.material_tbt_shadow_L, stage.material_tbt_shadow_RF, stage.material_tbt_shadow_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_shadow_LF, stage.trans_tbt_shadow_L, stage.trans_tbt_shadow_RF, stage.trans_tbt_shadow_R];property: "default_py";duration: 0;to: 0.0 }
        }
        PauseAnimation {duration: 957}
        ParallelAnimation{
            NumberAnimation { target: stage.material_distance_set;        property: "u_alphaFactor";   duration: 330; from:0;   to: 0.2 }
            NumberAnimation { target: stage.material_distance_arrow;      property: "u_alphaFactor";   duration: 330; from:0;   to: 1 }
            NumberAnimation { target: stage.material_distance_base;       property: "u_alphaFactor";   duration: 330; from:0;   to: 1 }
        }
    }
    SequentialAnimation{
        id:fadeout_in_mid
        onStarted: rootItem.focus=false
        ParallelAnimation{
            NumberAnimation { target: stage.material_distance_set_mid;    property: "u_alphaFactor";   duration: 330; from:0.2; to: 0 }
            NumberAnimation { target: stage.material_distance_arrow;      property: "u_alphaFactor";   duration: 330; from:1;   to: 0 }
            NumberAnimation { target: stage.material_distance_base;       property: "u_alphaFactor";   duration: 330; from:1;   to: 0 }
            NumberAnimation { targets: [stage.material_tbt_LF, stage.material_tbt_L, stage.material_tbt_RF, stage.material_tbt_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_LF, stage.trans_tbt_L, stage.trans_tbt_RF, stage.trans_tbt_R];property: "default_py";duration: 0;to: 0.0 }
            NumberAnimation { targets: [stage.material_tbt_shadow_LF, stage.material_tbt_shadow_L, stage.material_tbt_shadow_RF, stage.material_tbt_shadow_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_shadow_LF, stage.trans_tbt_shadow_L, stage.trans_tbt_shadow_RF, stage.trans_tbt_shadow_R];property: "default_py";duration: 0;to: 0.0 }
        }
        PauseAnimation {duration: 957}
        ParallelAnimation{
            NumberAnimation { target: stage.material_distance_set_mid;    property: "u_alphaFactor";   duration: 330; from:0;   to: 0.2 }
            NumberAnimation { target: stage.material_distance_arrow;      property: "u_alphaFactor";   duration: 330; from:0;   to: 1 }
            NumberAnimation { target: stage.material_distance_base;       property: "u_alphaFactor";   duration: 330; from:0;   to: 1 }
        }
    }
    SequentialAnimation{
        id:fadeout_in_near
        onStarted: rootItem.focus=false
        ParallelAnimation{
            NumberAnimation { target: stage.material_distance_set_near;   property: "u_alphaFactor";   duration: 330; from:0.2; to: 0 }
            NumberAnimation { target: stage.material_distance_arrow;      property: "u_alphaFactor";   duration: 330; from:1;   to: 0 }
            NumberAnimation { target: stage.material_distance_base;       property: "u_alphaFactor";   duration: 330; from:1;   to: 0 }
            NumberAnimation { targets: [stage.material_tbt_LF, stage.material_tbt_L, stage.material_tbt_RF, stage.material_tbt_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_LF, stage.trans_tbt_L, stage.trans_tbt_RF, stage.trans_tbt_R];property: "default_py";duration: 0;to: 0.0 }
            NumberAnimation { targets: [stage.material_tbt_shadow_LF, stage.material_tbt_shadow_L, stage.material_tbt_shadow_RF, stage.material_tbt_shadow_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_shadow_LF, stage.trans_tbt_shadow_L, stage.trans_tbt_shadow_RF, stage.trans_tbt_shadow_R];property: "default_py";duration: 0;to: 0.0 }
        }
        PauseAnimation {duration: 957}
        ParallelAnimation{
            NumberAnimation { target: stage.material_distance_set_near;   property: "u_alphaFactor";   duration: 330; from:0;   to: 0.2 }
            NumberAnimation { target: stage.material_distance_arrow;      property: "u_alphaFactor";   duration: 330; from:0;   to: 1 }
            NumberAnimation { target: stage.material_distance_base;       property: "u_alphaFactor";   duration: 330; from:0;   to: 1 }
        }
    }


    SequentialAnimation{
        id: cameraToAdasPos
        onStarted: rootItem.focus=false
        property int duration_camera: 891//957
        property int duration_all: 330//363
        property var easing_camera: Easing.InOutQuart
        property var easing_all: Easing.InOutQuart
        PauseAnimation {duration: 330}
        ParallelAnimation{
            NumberAnimation { target: ddditem;     property: "scale";  to: 1.0;  duration: cameraToAdasPos.duration_camera ; easing.type: Easing.OutBack}//cameraToAdasPos.easing_camera                }
            NumberAnimation { target: ddditem;     property: "x";  to:  512;  duration: cameraToAdasPos.duration_camera ; easing.type: Easing.InOutQuad}//cameraToAdasPos.easing_camera                }
            NumberAnimation { target: ddditem;     property: "y";  to:  -35;  duration: cameraToAdasPos.duration_camera ; easing.type: Easing.OutBack}//cameraToAdasPos.easing_camera                }
            NumberAnimation { target: stage.trans_camera;         property: "posX";     to: -10;  duration: cameraToAdasPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.InOutCubic               }
            NumberAnimation { target: stage.trans_camera;         property: "posY";     to:7;  duration: cameraToAdasPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutExpo              }
            NumberAnimation { target: stage.trans_camera;         property: "posZ";     to: 8;  duration: cameraToAdasPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutExpo           }
            NumberAnimation { target: stage.trans_camera;         property: "rotX";     to: -24.2039;  duration: cameraToAdasPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutBack            }
            NumberAnimation { target: stage.trans_camera;         property: "rotY";     to: -46.4688;  duration: cameraToAdasPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.InOutQuart               }
            NumberAnimation { target: stage.trans_camera;         property: "rotZ";     to: -0.999999;  duration: cameraToAdasPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutExpo             }
            NumberAnimation { target: stage.trans_distance_arrow; property: "scale_x";  to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_arrow; property: "scale_z";  to: 0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_base;  property: "posi_z";   to: 6.7*0.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_base;  property: "scale_x";  to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_base;  property: "scale_z";  to: 0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set;   property: "posi_z";   to: 6.7*0.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set;   property: "scale_x";  to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set;   property: "scale_z";  to: 0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_mid ;property: "posi_z"; to: 6.7*0.4+4*0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_mid ;property: "scale_x";to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_mid ;property: "scale_z";to: 0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_near;property: "posi_z"; to: 6.7*0.4+8*0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_near;property: "scale_x";to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_near;property: "scale_z";to: 0.75;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_road;           property: "posi_z";   to: 6*0.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_road;           property: "scale_x";  to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_road;           property: "scale_z";  to: 0.6;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_sensorline;     property: "posi_z";   to: 6*0.25;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_sensorline;     property: "scale_x";  to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_sensorline;     property: "scale_z";  to: 0.6;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_road_light;     property: "posi_z";   to: 6*0.6;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_road_light;     property: "scale_x";  to: 1.4;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
            NumberAnimation { target: stage.trans_road_light;     property: "scale_z";  to: 0.6;  duration: cameraToAdasPos.duration_all; easing.type: cameraToAdasPos.easing_all                }
        }
        ParallelAnimation{
            NumberAnimation {
                target: {
                    switch(received_tbt_id){
                    case 1:
                        stage.material_tbt_LF
                        break;
                    case 2:
                        stage.material_tbt_L
                        break;
                    case 3:
                        stage.material_tbt_RF
                        break;
                    case 4:
                        stage.material_tbt_R
                        break;
                    default:
                        stage.material_tbt_LF
                        break;
                    }
                }
                property: "u_alphaFactor"
                duration: 330
                from:0
                to: 1
            }
            NumberAnimation {
                target: {
                    switch(received_tbt_id){
                    case 1:
                        stage.material_tbt_shadow_LF
                        break;
                    case 2:
                        stage.material_tbt_shadow_L
                        break;
                    case 3:
                        stage.material_tbt_shadow_RF
                        break;
                    case 4:
                        stage.material_tbt_shadow_R
                        break;
                    default:
                        stage.material_tbt_shadow_LF
                        break;
                    }
                }
                property: "u_alphaFactor"
                duration: 330
                from:0
                to: 1
            }
            NumberAnimation {
                target: {
                    switch(received_tbt_id){
                    case 1:
                        stage.trans_tbt_LF
                        break;
                    case 2:
                        stage.trans_tbt_L
                        break;
                    case 3:
                        stage.trans_tbt_RF
                        break;
                    case 4:
                        stage.trans_tbt_R
                        break;
                    default:
                        stage.trans_tbt_LF
                        break;
                    }
                }
                property: "default_py"
                duration: 330
                from: 0
                to: 0.52
            }
            NumberAnimation {
                target: {
                    switch(received_tbt_id){
                    case 1:
                        stage.trans_tbt_shadow_LF
                        break;
                    case 2:
                        stage.trans_tbt_shadow_L
                        break;
                    case 3:
                        stage.trans_tbt_shadow_RF
                        break;
                    case 4:
                        stage.trans_tbt_shadow_R
                        break;
                    default:
                        stage.trans_tbt_shadow_LF
                        break;
                    }
                }
                property: "default_py"
                duration: 330
                from: 0
                to: 0.2
            }
        }
    }

    SequentialAnimation{
        id: cameraTonormalPos
        onStarted: rootItem.focus=false
        property int duration_camera: 891//957
        property int duration_all: 330//363
        property var easing_camera: Easing.InOutQuart
        property var easing_all: Easing.InOutQuart
        PauseAnimation {duration: 330}
        ParallelAnimation{
            NumberAnimation { target: ddditem;     property: "scale";  to: 0.6;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//cameraTonormalPos.easing_camera                }
            NumberAnimation { target: ddditem;     property: "x";  to:  548;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//cameraTonormalPos.easing_camera                }
            NumberAnimation { target: ddditem;     property: "y";  to:  -23;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//cameraTonormalPos.easing_camera                }
            NumberAnimation { target: stage.trans_camera;         property: "posX";     to: 0.0;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.InOutCubic               }
            NumberAnimation { target: stage.trans_camera;         property: "posY";     to:2.6;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutExpo              }
            NumberAnimation { target: stage.trans_camera;         property: "posZ";     to: 2.35;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutExpo           }
            NumberAnimation { target: stage.trans_camera;         property: "rotX";     to:-8.29241;  duration: cameraTonormalPos.duration_camera*1.2; easing.type: Easing.InOutQuad}//Easing.InBack             }
            NumberAnimation { target: stage.trans_camera;         property: "rotY";     to: 0.0;  duration: cameraTonormalPos.duration_camera*1.2; easing.type: Easing.InOutQuad}//Easing.InOutQuart               }
            NumberAnimation { target: stage.trans_camera;         property: "rotZ";     to: 0.0;  duration: cameraTonormalPos.duration_camera; easing.type: Easing.InOutQuad}//Easing.OutExpo               }
            NumberAnimation { target: stage.trans_distance_arrow; property: "scale_x";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_arrow; property: "scale_z";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_base;  property: "posi_z";   to: 0.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_base;  property: "scale_x";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_base;  property: "scale_z";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set;   property: "posi_z";   to: 0.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set;   property: "scale_x";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set;   property: "scale_z";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_mid ;property: "posi_z"; to: 0.0+4;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_mid ;property: "scale_x";to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_mid ;property: "scale_z";to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_near;property: "posi_z"; to: 0.0+8;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_near;property: "scale_x";to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_distance_set_near;property: "scale_z";to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_road;           property: "posi_z";   to: 0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_road;           property: "scale_x";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_road;           property: "scale_z";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_sensorline;     property: "posi_z";   to: 0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_sensorline;     property: "scale_x";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_sensorline;     property: "scale_z";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_road_light;     property: "posi_z";   to: 0.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_road_light;     property: "scale_x";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { target: stage.trans_road_light;     property: "scale_z";  to: 1.0;  duration: cameraTonormalPos.duration_all; easing.type: cameraTonormalPos.easing_all                }
            NumberAnimation { targets: [stage.material_tbt_LF, stage.material_tbt_L, stage.material_tbt_RF, stage.material_tbt_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_LF, stage.trans_tbt_L, stage.trans_tbt_RF, stage.trans_tbt_R];property: "default_py";duration: 0;to: 0.0 }
            NumberAnimation { targets: [stage.material_tbt_shadow_LF, stage.material_tbt_shadow_L, stage.material_tbt_shadow_RF, stage.material_tbt_shadow_R];property: "u_alphaFactor";duration: 330;to: 0 }
            NumberAnimation { targets: [stage.trans_tbt_shadow_LF, stage.trans_tbt_shadow_L, stage.trans_tbt_shadow_RF, stage.trans_tbt_shadow_R];property: "default_py";duration: 0;to: 0.0 }
        }
    }

    SequentialAnimation{
        id: adasToMapAnimation_acc3d
        onStarted: rootItem.focus=false
        NumberAnimation {
            target: ddditem
            property: "opacity"
            duration: 330
            from:1
            to:0
        }

        PropertyAnimation{
            target: ddditem
            property: "visible"
            duration:0
            to:false
        }
    }

    SequentialAnimation{
        id: ddditemTonormalsize
        onStarted: rootItem.focus=false
        PauseAnimation {duration: 330}
        PropertyAnimation{
            target: ddditem
            property: "visible"
            duration:0
            to:true
        }

        NumberAnimation {
            target: ddditem
            property: "opacity"
            duration: 330
            from:0
            to:1
        }
    }
    Item{
        id: distance_set_3d_Anim
        states:[
            State{
                name:"set_default"
                when: rootItem.set_state === "set_default"
            },
            State{
                name:"set_middle"
                when: rootItem.set_state === "set_middle"
            },
            State{
                name:"set_near"
                when: rootItem.set_state === "set_near"
            }
        ]

        transitions: [
            Transition {
                SequentialAnimation{
                    onStarted: rootItem.focus=false
                    ParallelAnimation{
                        NumberAnimation {
                            target: stage.material_distance_set_mid
                            property: "u_alphaFactor"
                            duration: 0
                            to: 0
                        }
                        NumberAnimation {
                            target: stage.material_distance_set_near
                            property: "u_alphaFactor"
                            duration: 0
                            to: 0
                        }
                    }
                    PauseAnimation { duration: 300}
                    NumberAnimation{
                        target: stage.material_distance_set
                        property: "u_alphaFactor"
                        duration: 50
                        to: 0.2
                    }
                }
                from: "*"
                to: "set_default"
            },
            Transition {
                SequentialAnimation{
                    onStarted: rootItem.focus=false
                    ParallelAnimation{
                        NumberAnimation{
                            target: stage.material_distance_set
                            property: "u_alphaFactor"
                            duration: 0
                            to: 0
                        }
                        NumberAnimation {
                            target: stage.material_distance_set_near
                            property: "u_alphaFactor"
                            duration: 0
                            to: 0
                        }
                    }
                    PauseAnimation { duration: 300}
                    NumberAnimation {
                        target: stage.material_distance_set_mid
                        property: "u_alphaFactor"
                        duration: 50
                        to: 0.2
                    }
                }
                from: "*"
                to: "set_middle"
            },
            Transition {
                SequentialAnimation{
                    onStarted: rootItem.focus=false
                    ParallelAnimation{
                        NumberAnimation{
                            target: stage.material_distance_set
                            property: "u_alphaFactor"
                            duration: 0
                            to: 0
                        }
                        NumberAnimation {
                            target: stage.material_distance_set_mid
                            property: "u_alphaFactor"
                            duration: 0
                            to: 0
                        }
                    }
                    PauseAnimation { duration: 300}
                    NumberAnimation {
                        target: stage.material_distance_set_near
                        property: "u_alphaFactor"
                        duration: 50
                        to: 0.2
                    }
                }
                from: "*"
                to: "set_near"
            }
        ]
    }
    Item{
        id: arrow_3d_Anim

        states:[
            State{
                name:"arrow_normal_default"
                when: rootItem.arrow_state == "arrow_normal_default"
            },
            State{
                name:"arrow_normal_middle"
                when: rootItem.arrow_state == "arrow_normal_middle"
            },
            State{
                name:"arrow_normal_near"
                when: rootItem.arrow_state == "arrow_normal_near"
            },
            State{
                name:"arrow_adas_default"
                when: rootItem.arrow_state == "arrow_adas_default"
            },
            State{
                name:"arrow_adas_middle"
                when: rootItem.arrow_state == "arrow_adas_middle"
            },
            State{
                name:"arrow_adas_near"
                when: rootItem.arrow_state == "arrow_adas_near"
            }
        ]

        transitions: [
            Transition {
                NumberAnimation{
                    target: stage.trans_distance_arrow
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_distance_arrow.default_pz
                }
                from: "*"
                to: "arrow_normal_default"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_distance_arrow
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_distance_arrow.default_pz + 4
                }
                from: "*"
                to: "arrow_normal_middle"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_distance_arrow
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_distance_arrow.default_pz + 7.99
                }
                from: "*"
                to: "arrow_normal_near"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_distance_arrow
                    properties: "posi_z"
                    duration: 300
                    to: 6.7*0.4
                }
                from: "*"
                to: "arrow_adas_default"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_distance_arrow
                    properties: "posi_z"
                    duration: 300
                    to: 6.7*0.4+4*0.75
                }
                from: "*"
                to: "arrow_adas_middle"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_distance_arrow
                    properties: "posi_z"
                    duration: 300
                    to: 6.7*0.4+8 * 0.75
                }
                from: "*"
                to: "arrow_adas_near"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_distance_arrow
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: 6.7 * 0.75
                    }
                }
                from: "normal_default"
                to: "adas_default"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_distance_arrow
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: 6.7+4 * 0.75
                    }
                }
                from: "normal_middle"
                to: "adas_middle"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_distance_arrow
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: 6.7+8 * 0.75
                    }
                }
                from: "normal_near"
                to: "adas_near"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_distance_arrow
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: stage.trans_distance_arrow.default_pz
                    }
                }
                from: "adas_default"
                to: "normal_default"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_distance_arrow
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: stage.trans_distance_arrow.default_pz + 4
                    }
                }
                from: "adas_middle"
                to: "normal_middle"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_distance_arrow
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: stage.trans_distance_arrow.default_pz + 7.99
                    }
                }
                from: "adas_near"
                to: "normal_near"
            }
        ]

    }

    Item{
        id: car_3d_Anim

        states:[
            State{
                name:"normal_default"
                when: rootItem.car_state == "normal_default"
            },
            State{
                name:"normal_middle"
                when: rootItem.car_state == "normal_middle"
            },
            State{
                name:"normal_near"
                when: rootItem.car_state == "normal_near"
            },
            State{
                name:"adas_default"
                when: rootItem.car_state == "adas_default"
            },
            State{
                name:"adas_middle"
                when: rootItem.car_state == "adas_middle"
            },
            State{
                name:"adas_near"
                when: rootItem.car_state == "adas_near"
            }
        ]

        transitions: [
            Transition {
                NumberAnimation{
                    target: stage.trans_other_car
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_other_car.default_pz
                }
                from: "*"
                to: "normal_default"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_other_car
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_other_car.default_pz + 4
                }
                from: "*"
                to: "normal_middle"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_other_car
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_other_car.default_pz + 8
                }
                from: "*"
                to: "normal_near"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_other_car
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_other_car.default_pz + 7.35
                }
                from: "*"
                to: "adas_default"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_other_car
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_other_car.default_pz + 7.35 + 4*0.75
                }
                from: "*"
                to: "adas_middle"
            },
            Transition {
                NumberAnimation{
                    target: stage.trans_other_car
                    properties: "posi_z"
                    duration: 300
                    to: stage.trans_other_car.default_pz + 7.35 + 8*0.75
                }
                from: "*"
                to: "adas_near"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_other_car
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: stage.trans_other_car.default_pz + 7.35
                    }
                }
                from: "normal_default"
                to: "adas_default"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_other_car
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: stage.trans_other_car.default_pz + 7.35 + 4*0.75
                    }
                }
                from: "normal_middle"
                to: "adas_middle"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_other_car
                        properties: "posi_z"
                        easing.type: Easing.OutCubic
                        duration: 957
                        to: stage.trans_other_car.default_pz + 7.35 + 8*0.75
                    }
                }
                from: "normal_near"
                to: "adas_near"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_other_car
                        properties: "posi_z"
                        easing.type: Easing.InCubic
                        duration: 957
                        to: stage.trans_other_car.default_pz
                    }
                }
                from: "adas_default"
                to: "normal_default"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_other_car
                        properties: "posi_z"
                        easing.type: Easing.InCubic
                        duration: 957
                        to: stage.trans_other_car.default_pz + 4
                    }
                }
                from: "adas_middle"
                to: "normal_middle"
            },
            Transition {
                SequentialAnimation{
                    PauseAnimation { duration: 330}
                    NumberAnimation{
                        target: stage.trans_other_car
                        properties: "posi_z"
                        easing.type: Easing.InCubic
                        duration: 957
                        to: stage.trans_other_car.default_pz + 8
                    }
                }
                from: "adas_near"
                to: "normal_near"
            }
        ]
    }
}
