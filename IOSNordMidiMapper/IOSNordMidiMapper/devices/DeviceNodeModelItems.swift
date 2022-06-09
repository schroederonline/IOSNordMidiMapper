//
//  DeviceNodeModelItems.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

public class DeviceNodeModelItems {
    
    private let allDeviceModels :Array<GenericDeviceModel>  = [NordStage3Node(),
                                                               NordStage2Node(),
                                                               NordStage2EXNode(),
                                                               NordElectro6Node(),
                                                               NordElectro5Node(),
                                                               NordGrandNode(),
                                                               NordWave2Node(),
                                                               NordWaveNode(),
                                                               NordPiano5Node(),
                                                               NordPiano4Node()
                                                               

    ];


    public func getAvailableDeviceModels() -> Array<GenericDeviceModel>{
        return allDeviceModels;
    }

}
