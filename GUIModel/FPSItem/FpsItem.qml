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
