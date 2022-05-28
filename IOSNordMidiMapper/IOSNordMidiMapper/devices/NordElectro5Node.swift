//
//  NordElectro5Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

public class NordElectro5Node: GenericDeviceModel {

    public init() {
        let mapperModel = MapperModelNord();
//        fixme
//        new MapperModelNord(ModeProgram1_1To8_50::new),
        super.init(name: "Nord Electro 5", mapperModel: mapperModel, midiCcName: "nordelectro5_midicc.txt");
    }

}
