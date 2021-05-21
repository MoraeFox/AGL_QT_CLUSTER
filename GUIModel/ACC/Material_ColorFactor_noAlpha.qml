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
import Qt3D.Render 2.14

Material{
    id: root
    property color u_rgbFactor          : Qt.rgba(1,1,1,1)
    property real  u_alphaFactor        : 1.0
    property url u_Texture

    parameters: [
        Parameter{name:"u_rgbFactor"    ; value: Qt.vector3d(root.u_rgbFactor.r,root.u_rgbFactor.g,root.u_rgbFactor.b)  },
        Parameter{name:"u_alphaFactor"  ; value: root.u_alphaFactor },
        Parameter{
            name:"u_Texture";
            value: Texture2D{
                id:shaderTexture
                minificationFilter: Texture.LinearMipMapLinear
                magnificationFilter: Texture.Linear
                generateMipMaps: true
                maximumAnisotropy: 4.0
                TextureImage{
                    source: u_Texture
                }
            }
        }
    ]

    effect: Effect{

        techniques: [
            Technique {
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGLES
                    profile: GraphicsApiFilter.NoProfile
                    majorVersion: 2
                    minorVersion: 0
                }

                filterKeys: [ FilterKey { name: "renderingStyle"; value: "forward" } ]

                renderPasses: [
                    RenderPass {
                        shaderProgram: ShaderProgram {
                            vertexShaderCode    : loadSource("qrc:/Shaders/vert/RefTrans_Qt.vert")
                            fragmentShaderCode  : loadSource("qrc:/Shaders/frag/RefTexRefColorFactor_Qt.frag")
                        }
                        renderStates: [

                            CullFace{mode:CullFace.Back},
                            ScissorTest{
                                left: 200;
                                bottom: 250;
                                width:winl.width-ddditem.x-100;
                                height: winl.height-100
                            }
                        ]
                    }
                ]
            }
        ]
    }
}
