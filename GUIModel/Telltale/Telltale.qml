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

Item {
    id: telltale

    property bool telltaleMasterWarn: false
    property bool telltaleGeneralWarn: false
    property bool telltaleBrakeEnergyRecovOff: false
    property bool telltaleBrakeEnergyRecovLv: false
    property bool telltaleMotorWarn: false
    property bool telltalePopupHoodWarn: false
    property bool telltaleDecharge: false
    property bool telltaleEvSystemWarn: false
    property bool telltaleChargingPlugWarn: false
    property bool telltaleLowBatt: false
    property bool telltaleBattWarn: false
    property bool telltaleBattTempWarn: false
    property bool telltaleHighVoltBattCut: false
    property bool telltaleAeb: false
    property bool telltaleLdw: false
    property bool telltaleBsd: false
    property bool telltaleSrsAirbag: false
    property bool telltaleEpsOff: false
    property bool telltaleBrake: false
    property bool telltaleAbsWarn: false
    property bool telltaleEspAct: false
    property bool telltaleHillDescent: false
    property bool telltaleAutoParking: false
    property bool telltaleTpmsInd: false
    property bool telltaleImmobi: false
    property bool telltaleDoor: false
    property bool telltaleSeatbelt: false
    property bool telltaleSeatbelt2: false
    property bool telltaleEpbWarn: false
    property bool telltaleEps: false
    property bool telltaleHighbeamAssist: false
    property bool telltaleHighbeam: false
    property bool telltaleRearFog: false
    property bool telltaleLowbeam: false
    property bool telltalePosition: false


    Image{
      id:masterWarn
      source: "qrc:/Images/Telltale/telltale1.png"
      x:191
      y:115
      width:500
      height:500
      visible: telltaleMasterWarn
    }
    Image{
      id:generalWarn
      source: "qrc:/Images/Telltale/telltale2.png"
      x:130
      y:149
      width:52
      height:52
      visible: telltaleGeneralWarn
    }
    Image{
      id:brakeEnergyRecovOff
      source: "qrc:/Images/Telltale/telltale3.png"
      x:75
      y:204
      width:52
      height:52
      visible: telltaleBrakeEnergyRecovOff
    }
    Image{
      id:brakeEnergyRecovLv
      source: "qrc:/Images/Telltale/telltale4.png"
      x:130
      y:204
      width:52
      height:52
      visible: telltaleBrakeEnergyRecovLv
    }
    Image{
      id:motorWarn
      source: "qrc:/Images/Telltale/telltale5.png"
      x:26
      y:262
      width:52
      height:52
      visible: telltaleMotorWarn
    }
    Image{
      id:popupHoodWarn
      source: "qrc:/Images/Telltale/telltale6.png"
      x:83
      y:262
      width:52
      height:52
      visible: telltalePopupHoodWarn
    }
    Image{
      id:decharge
      source: "qrc:/Images/Telltale/telltale7.png"
      x:83
      y:317
      width:52
      height:52
      visible: telltaleDecharge
    }
    Image{
      id:evSystemWarn
      source: "qrc:/Images/Telltale/telltale8.png"
      x:26
      y:317
      width:52
      height:52
      visible: telltaleEvSystemWarn
    }
    Image{
      id:chargingPlugWarn
      source: "qrc:/Images/Telltale/telltale9.png"
      x:83
      y:372
      width:52
      height:52
      visible: telltaleChargingPlugWarn
    }
    Image{
      id:lowBatt
      source: "qrc:/Images/Telltale/telltale10.png"
      x:26
      y:372
      width:52
      height:52
      visible: telltaleLowBatt
    }
    Image{
      id:battWarn
      source: "qrc:/Images/Telltale/telltale11.png"
      x:83
      y:427
      width:52
      height:52
      visible: telltaleBattWarn
    }
    Image{
      id:battTempWarn
      source: "qrc:/Images/Telltale/telltale12.png"
      x:26
      y:427
      width:52
      height:52
      visible: telltaleBattTempWarn
    }
    Image{
      id:highVoltBattCut
      source: "qrc:/Images/Telltale/telltale13.png"
      x:44
      y:482
      width:52
      height:52
      visible: telltaleHighVoltBattCut
    }
    Image{
      id:aeb
      source: "qrc:/Images/Telltale/telltale14.png"
      x:62
      y:543
      width:52
      height:52
      visible: telltaleAeb
    }
    Image{
      id:ldw
      source: "qrc:/Images/Telltale/telltale15.png"
      x:113
      y:600
      width:52
      height:52
      visible: telltaleLdw
    }
    Image{
      id:bsd
      source: "qrc:/Images/Telltale/telltale16.png"
      x:173
      y:629
      width:52
      height:52
      visible: telltaleBsd
    }
    Image{
      id:srsAirbag
      source: "qrc:/Images/Telltale/telltale17.png"
      x:1738
      y:204
      width:52
      height:52
      visible: telltaleSrsAirbag
    }
    Image{
      id:epsOff
      source: "qrc:/Images/Telltale/telltale18.png"
      x:1794
      y:204
      width:52
      height:52
      visible: telltaleEpsOff
    }
    Image{
      id:brake
      source: "qrc:/Images/Telltale/telltale19.png"
      x:1718
      y:259
      width:52
      height:52
      visible: telltaleBrake
    }
    Image{
      id:absWarn
      source: "qrc:/Images/Telltale/telltale20.png"
      x:1774
      y:259
      width:52
      height:52
      visible: telltaleAbsWarn
    }
    Image{
      id:espAct
      source: "qrc:/Images/Telltale/telltale21.png"
      x:1830
      y:259
      width:52
      height:52
      visible: telltaleEspAct
    }
    Image{
      id:hillDescent
      source: "qrc:/Images/Telltale/telltale22.png"
      x:1718
      y:314
      width:52
      height:52
      visible: telltaleHillDescent
    }
    Image{
      id:autoParking
      source: "qrc:/Images/Telltale/telltale23.png"
      x:1774
      y:314
      width:52
      height:52
      visible: telltaleAutoParking
    }
    Image{
      id:tpmsInd
      source: "qrc:/Images/Telltale/telltale24.png"
      x:1830
      y:314
      width:52
      height:52
      visible: telltaleTpmsInd
    }
    Image{
      id:immobi
      source: "qrc:/Images/Telltale/telltale25.png"
      x:629
      y:648
      width:52
      height:52
      visible: telltaleImmobi
    }
    Image{
      id:door
      source: "qrc:/Images/Telltale/telltale26.png"
      x:685
      y:648
      width:52
      height:52
      visible: telltaleDoor
    }
    Image{
      id:seatbelt
      source: "qrc:/Images/Telltale/telltale27.png"
      x:1196
      y:648
      width:52
      height:52
      visible: telltaleSeatbelt
    }
    Image{
      id:seatbelt2
      source: "qrc:/Images/Telltale/telltale28.png"
      x:1252
      y:648
      width:52
      height:52
      visible: telltaleSeatbelt2
    }
    Image{
      id:epbWarn
      source: "qrc:/Images/Telltale/telltale29.png"
      x:1308
      y:648
      width:52
      height:52
      visible: telltaleEpbWarn
    }
    Image{
      id:eps
      source: "qrc:/Images/Telltale/telltale30.png"
      x:1364
      y:648
      width:52
      height:52
      visible: telltaleEps
    }
    Image{
      id:highbeamAssist
      source: "qrc:/Images/Telltale/telltale31.png"
      x:1420
      y:648
      width:52
      height:52
      visible: telltaleHighbeamAssist
    }
    Image{
      id:highbeam
      source: "qrc:/Images/Telltale/telltale32.png"
      x:1476
      y:648
      width:52
      height:52
      visible: telltaleHighbeam
    }
    Image{
      id:rearFog
      source: "qrc:/Images/Telltale/telltale33.png"
      x:1532
      y:648
      width:52
      height:52
      visible: telltaleRearFog
    }
    Image{
      id:lowbeam
      source: "qrc:/Images/Telltale/telltale34.png"
      x:1588
      y:648
      width:52
      height:52
      visible: telltaleLowbeam
    }
    Image{
      id:position
      source: "qrc:/Images/Telltale/telltale35.png"
      x:1644
      y:648
      width:52
      height:52
      visible: telltalePosition
    }
}
