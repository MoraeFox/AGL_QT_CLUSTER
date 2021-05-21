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

import QtQuick 2.14 as Quick
import Qt3D.Core 2.14
import Qt3D.Input 2.14
import Qt3D.Render 2.14
import Qt3D.Extras 2.14
import Qt3D.Animation 2.14

Entity {

    id: dddroot
    property alias material_sensorline: material_sensorline
    property alias material_distance_base: material_distance_base
    property alias material_distance_arrow: material_distance_arrow
    property alias material_distance_set: material_distance_set
    property alias material_distance_set_mid: material_distance_set_mid
    property alias material_distance_set_near: material_distance_set_near


    property alias trans_camera: trans_camera
    property alias trans_other_car: trans_other_car
    property alias trans_car: trans_car
    property alias trans_road: trans_road
    property alias trans_road_light: trans_road_light
    property alias trans_sensorline: trans_sensorline
    property alias trans_distance_base: trans_distance_base
    property alias trans_distance_arrow: trans_distance_arrow
    property alias trans_distance_set: trans_distance_set
    property alias trans_distance_set_mid: trans_distance_set_mid
    property alias trans_distance_set_near: trans_distance_set_near



    property int current_id: 0
    property int received_id: 0

    property alias material_tbt_LF: material_tbt_LF
    property alias material_tbt_L: material_tbt_L
    property alias material_tbt_RF: material_tbt_RF
    property alias material_tbt_R: material_tbt_R
    property alias trans_tbt_LF: trans_tbt_LF
    property alias trans_tbt_L: trans_tbt_L
    property alias trans_tbt_RF: trans_tbt_RF
    property alias trans_tbt_R: trans_tbt_R

    property alias material_tbt_shadow_LF: material_tbt_shadow_LF
    property alias material_tbt_shadow_L: material_tbt_shadow_L
    property alias material_tbt_shadow_RF: material_tbt_shadow_RF
    property alias material_tbt_shadow_R: material_tbt_shadow_R
    property alias trans_tbt_shadow_LF: trans_tbt_shadow_LF
    property alias trans_tbt_shadow_L: trans_tbt_shadow_L
    property alias trans_tbt_shadow_RF: trans_tbt_shadow_RF
    property alias trans_tbt_shadow_R: trans_tbt_shadow_R

    Entity {
        components: [
            trans_camera,
            camera
        ]
        Camera {
            id: camera
            projectionType: CameraLens.PerspectiveProjection
            fieldOfView: 44.09591363
            aspectRatio: 16 / 9
            nearPlane: 7
            farPlane : 30
            upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
            position: trans_camera.translation
        }

        Transform{
            id: trans_camera
            property real posX: 0.0
            property real posY: 2.6
            property real posZ: 2.35

            property real rotX: -8.29241
            property real rotY: 0.0
            property real rotZ: 0.0

            translation:Qt.vector3d(posX, posY, posZ)

            rotationX:rotX
            rotationY:rotY
            rotationZ:rotZ

            scale3D:Qt.vector3d(0.01, 0.01, 0.01)
        }
    }

    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                clearColor: "transparent"
                camera: camera
                frustumCulling: true
            }
            renderPolicy: RenderSettings.OnDemand
        }
    ]

    Entity {
        id : other_car

        components: [
            object_other_car,
            trans_other_car,
            material_other_car
        ]

        Mesh {
            id: object_other_car
            source: "qrc:/3DModelData/car.obj"
        }

        Transform_NextGen {
            id: trans_other_car
            default_px: 0.0
            default_py: 0.0
            default_pz: -21

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor_noAlpha{
            id: material_other_car

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/uvmap_gray.jpg"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }


    Entity {
        id: mycar

        components: [
            object_car,
            trans_car,
            material_car
        ]

        Mesh {
            id: object_car
            source: "qrc:/3DModelData/car.obj"
        }

        Transform_NextGen {
            id: trans_car

            default_px: 0.0
            default_py: 0.0
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor_noAlpha{
            id: material_car

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/uvmap.jpg"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : road

        components: [
            object_road,
            trans_road,
            material_road
        ]

        Mesh {
            id: object_road
            source: "qrc:/3DModelData/road.obj"
        }

        Transform_NextGen {
            id: trans_road

            default_px: 0.0
            default_py: 0.0
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s :   1.0
        }

        Material_ColorFactor_noAlpha{
            id: material_road

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/road.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name

        }
    }

    Entity {
        id : road_light

        components: [
            object_road_light,
            trans_road_light,
            material_road_light
        ]

        Mesh {
            id: object_road_light
            source: "qrc:/3DModelData/road_light.obj"
        }

        Transform_NextGen {
            id: trans_road_light

            default_px: 0.0
            default_py: 0.0
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor{
            id: material_road_light

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/road_light.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : sensorline

        components: [
            object_sensorline,
            trans_sensorline,
            material_sensorline
        ]

        Mesh {
            id: object_sensorline
            source: "qrc:/3DModelData/sensor_line.obj"
        }

        Transform_NextGen {
            id: trans_sensorline

            default_px: 0.0
            default_py: 0.01
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor{
            id: material_sensorline

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/sensor_line.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_base

        components: [
            object_distance_base,
            trans_distance_base,
            material_distance_base
        ]

        Mesh {
            id: object_distance_base
            source: "qrc:/3DModelData/distance_base.obj"
        }

        Transform_NextGen {
            id: trans_distance_base

            default_px: 0.0
            default_py: 0.03
            default_pz: 0.0
            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor{
            id: material_distance_base

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/distance_base.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_arrow

        components: [
            object_distance_arrow,
            trans_distance_arrow,
            material_distance_arrow,
        ]

        Mesh {
            id: object_distance_arrow
            source: "qrc:/3DModelData/distance_arrow.obj"
        }

        Transform_NextGen {
            id: trans_distance_arrow

            default_px: 0.0
            default_py: 0.035
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor{
            id: material_distance_arrow

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 1.0

            property url u_texture_name : "qrc:/3DModelTexture/distance_arrow.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_set

        components: [
            object_distance_set,
            trans_distance_set,
            material_distance_set
        ]

        Mesh {
            id: object_distance_set
            source: "qrc:/3DModelData/distance_set.obj"
        }

        Transform_NextGen {
            id: trans_distance_set

            default_px:   0.0
            default_py: 0.038
            default_pz: 0.0

            default_rx:   0.0
            default_ry:   0.0
            default_rz:   0.0

            default_s :   1.0
        }

        Material_ColorFactor{
            id: material_distance_set

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0.0

            property url u_texture_name : "qrc:/3DModelTexture/distance_set.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_set_mid

        components: [
            object_distance_set_mid,
            trans_distance_set_mid,
            material_distance_set_mid,
        ]

        Mesh {
            id: object_distance_set_mid
            source: "qrc:/3DModelData/distance_set.obj"
        }

        Transform_NextGen {
            id: trans_distance_set_mid

            default_px: 0.0
            default_py: 0.043
            default_pz: 4.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor{
            id: material_distance_set_mid

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0.0

            property url u_texture_name : "qrc:/3DModelTexture/distance_set.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_set_near

        components: [
            object_distance_set_near,
            trans_distance_set_near,
            material_distance_set_near
        ]

        Mesh {
            id: object_distance_set_near
            source: "qrc:/3DModelData/distance_set.obj"
        }

        Transform_NextGen {
            id: trans_distance_set_near

            default_px:   0.0
            default_py: 0.048
            default_pz: 8.0

            default_rx:   0.0
            default_ry:   0.0
            default_rz:   0.0

            default_s :   1.0
        }

        Material_ColorFactor{
            id: material_distance_set_near

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0.0

            property url u_texture_name : "qrc:/3DModelTexture/distance_set.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }


    Entity {
        id : distance_tbt_shadow_LF
        property int current_id: parent.current_id
        property real material_alpha: 0.0
        components: [object_tbt_shadow_LF,trans_tbt_shadow_LF,material_tbt_shadow_LF]

        Mesh {
            id: object_tbt_shadow_LF
            source: "qrc:/3DModelData/tbt_shadow.obj"
        }

        Transform_NextGen {
            id: trans_tbt_shadow_LF

            default_px: -1.0
            default_py: 0.1
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor_Tbt{
            id: material_tbt_shadow_LF

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_shadow_LF.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }
    Entity {
        id : distance_tbt_shadow_L
        property int current_id: parent.current_id
        property real material_alpha: 0.0
        components: [object_tbt_shadow_L,trans_tbt_shadow_L,material_tbt_shadow_L]

        Mesh {
            id: object_tbt_shadow_L
            source: "qrc:/3DModelData/tbt_shadow.obj"
        }

        Transform_NextGen {
            id: trans_tbt_shadow_L

            default_px:   -1.0
            default_py: 0.1
            default_pz: 0.0

            default_rx:   0.0
            default_ry:   0.0
            default_rz:   0.0

            default_s :   1.0
        }

        Material_ColorFactor_Tbt{
            id: material_tbt_shadow_L

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_shadow_L.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_tbt_shadow_RF
        property int current_id: parent.current_id
        property real material_alpha: 0.0
        components: [object_tbt_shadow_RF,trans_tbt_shadow_RF,material_tbt_shadow_RF]

        Mesh {
            id: object_tbt_shadow_RF
            source: "qrc:/3DModelData/tbt_shadow.obj"
        }

        Transform_NextGen {
            id: trans_tbt_shadow_RF

            default_px:   -1.0
            default_py: 0.1
            default_pz: 0.0

            default_rx:   0.0
            default_ry:   0.0
            default_rz:   0.0

            default_s :   1.0
        }

        Material_ColorFactor_Tbt{
            id: material_tbt_shadow_RF

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_shadow_RF.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }
    Entity {
        id : distance_tbt_shadow_R
        property int current_id: parent.current_id
        property real material_alpha: 0.0
        components: [object_tbt_shadow_R,trans_tbt_shadow_R,material_tbt_shadow_R]

        Mesh {
            id: object_tbt_shadow_R
            source: "qrc:/3DModelData/tbt_shadow.obj"
        }

        Transform_NextGen {
            id: trans_tbt_shadow_R

            default_px: -1.0
            default_py: 0.1
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            default_s : 1.0
        }

        Material_ColorFactor_Tbt{
            id: material_tbt_shadow_R

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_shadow_R.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_tbt_LF
        property int current_id:parent.current_id
        property real material_alpha: 0.0
        components: [object_tbt_LF,trans_tbt_LF,material_tbt_LF]

        Mesh {
            id: object_tbt_LF
            source: "qrc:/3DModelData/tbt.obj"
        }

        Transform_NextGen {
            id: trans_tbt_LF

            //-----init-----//
            default_px: -1.0
            default_py: 0.5//0.11
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            scale_x :   1.0
        }
        Material_ColorFactor_Tbt{
            id: material_tbt_LF

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_LF.png"


            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }
    Entity {
        id : distance_tbt_L
        property int current_id:parent.current_id
        property real material_alpha: 0.0

        components: [object_tbt_L,trans_tbt_L,material_tbt_L]

        Mesh {
            id: object_tbt_L
            source: "qrc:/3DModelData/tbt.obj"
        }

        Transform_NextGen {
            id: trans_tbt_L

            default_px: -1.0
            default_py: 0.5
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            scale_x :   1.0
        }
        Material_ColorFactor_Tbt{
            id: material_tbt_L

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_L.png"


            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_tbt_RF
        property int current_id:parent.current_id
        property real material_alpha: 0.0

        components: [object_tbt_RF,trans_tbt_RF,material_tbt_RF]

        Mesh {
            id: object_tbt_RF
            source: "qrc:/3DModelData/tbt.obj"
        }

        Transform_NextGen {
            id: trans_tbt_RF

            default_px: -1.0
            default_py: 0.5
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            scale_x :   1.0
        }
        Material_ColorFactor_Tbt{
            id: material_tbt_RF

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_RF.png"


            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }

    Entity {
        id : distance_tbt_R
        property int current_id:parent.current_id
        property real material_alpha: 0.0

        components: [object_tbt_R,trans_tbt_R,material_tbt_R]

        Mesh {
            id: object_tbt_R
            source: "qrc:/3DModelData/tbt.obj"
        }

        Transform_NextGen {
            id: trans_tbt_R

            default_px: -1.0
            default_py: 0.5
            default_pz: 0.0

            default_rx: 0.0
            default_ry: 0.0
            default_rz: 0.0

            scale_x :   1.0
        }
        Material_ColorFactor_Tbt{
            id: material_tbt_R

            property real u_red             : 1.0
            property real u_green           : 1.0
            property real u_blue            : 1.0
            property real u_alpha           : 0

            property url u_texture_name : "qrc:/3DModelTexture/TbT_R.png"

            u_rgbFactor     : Qt.rgba(u_red,u_green,u_blue, 1)
            u_alphaFactor   : u_alpha
            u_Texture       : u_texture_name
        }
    }
}
