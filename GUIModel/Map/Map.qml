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
import QtMultimedia 5.14
import QtGraphicalEffects 1.14

Item {
    id: map
    x:1920 - 1200
    y:0
    width : 1200
    height : 720
    Component.onCompleted: {
        mapVideo.play()
    }

    Connections{
        target: rootItem
        onTransNormalToAdas:{
        }

        onTransAdasToMap:{
            adasToMapAnimationMap.start()
        }

        onTransMapToNormal:{
            mapToNormalAnimationMap.start()
        }
    }

    Item{
        id: mapParts
        visible:false
        anchors.fill: parent
        Video {
            id: mapVideo
            autoLoad: true
            anchors.fill: parent
            visible: true
            loops: MediaPlayer.Infinite
            source: "gst-pipeline: filesrc location=" + CurDirPath + "/map_movie.mp4 ! decodebin ! videoconvert ! qtvideosink"
        }

        Item{
            id:mapMask
            x: 0
            y: 0
            Image{
                width: 1200
                height: 720
                source: "qrc:/Images/ADASView/MAP/map_mask.ktx"
            }

            Image{ source:"qrc:/Images/ADASView/MAP/acc_cover.ktx"; width:1412; height:98; x:508-map.x; y:622 }
        }
   }

    SequentialAnimation{
        id:adasToMapAnimationMap
        onStarted: rootItem.focus=false
        onStopped: rootItem.focus=true

        PauseAnimation {
            duration: 330
        }

        PropertyAnimation {
            target: mapParts
            property: "visible"
            duration: 0
            to: true
        }

        PropertyAnimation{
            target: mapParts
            property: "opacity"
            duration: 330
            from:0
            to:1
        }
    }

    SequentialAnimation{
        id:mapToNormalAnimationMap
        onStarted: rootItem.focus=false
        PauseAnimation {
            duration: 254
        }


        PropertyAnimation{
            target: mapParts
            property: "opacity"
            duration: 330
            from: 1
            to: 0
        }

        PropertyAnimation {
            target: mapParts
            property: "visible"
            duration: 0
            to: false
        }
    }


}
