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
import QtQuick.Window 2.14

Rectangle {
    id: root
    property int frameCounter: 0
    property int frameCounterAvg: 0
    property int counter: 0
    property int fps: 0
    property int fpsAvg: 0
    property string part
    property int maxFPS: 0
    property int minFPS: 60

    property real dp:Screen.pixelDensity * 25.4/160

    color: "black"
    width:  spinnerImage.width + 10*dp;
    height: spinnerImage.height + 10*dp;

    Image {
        id: spinnerImage
        anchors.verticalCenter: parent.verticalCenter
        x: 4 * dp
        width: 36 * dp
        height: 36 * dp
        source: "qrc:/FPSItem/spinner.png"
        NumberAnimation on rotation {
            from:0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }
        onRotationChanged: frameCounter++;
    }


    Text {
        id: text1
        anchors.left: spinnerImage.right
        anchors.leftMargin: 8 * dp
        anchors.verticalCenter: spinnerImage.verticalCenter
        color: "#c0c0c0"
        font.pixelSize: 25 * dp
        text: "Ø " + root.part + " | fps " + root.fps +  " | Avg (/10s) " + root.fpsAvg +" | MAX " + root.maxFPS + " | MIN " + root.minFPS
    }


    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            frameCounterAvg += frameCounter;
//            console.info("frameCounter = ",frameCounter);
//            console.info(childrenRect.width, childrenRect.height);
            root.fps = frameCounter;
            counter++;
            frameCounter = 0;
            if (counter >= 10) {
                root.fpsAvg = frameCounterAvg/(counter)
                frameCounterAvg = 0;
                counter = 0;
            }
            if (root.maxFPS <= root.fps){
                root.maxFPS = root.fps
            }
            if (root.fps != 0){
                if(root.minFPS >= root.fps){
                  root.minFPS = root.fps
                }
            }
        }
    }
}
