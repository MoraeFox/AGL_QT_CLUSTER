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
