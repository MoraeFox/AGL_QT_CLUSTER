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
                                left: 500;
                                bottom: 450;
                                width:500;
                                height: 500
                            },
                            BlendEquationArguments{
                                sourceRgb: BlendEquationArguments.SourceAlpha
                                destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
                                sourceAlpha: BlendEquationArguments.OneMinusDestinationAlpha
                                destinationAlpha: BlendEquationArguments.One
                            }
                        ]
                    }
                ]
            }
        ]
    }
}
