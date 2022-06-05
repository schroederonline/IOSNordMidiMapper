//
//  NordElectro5Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

public class NordElectro5Node: GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgram1_1To8_50(mapperModel: model));
        super.init(name: "Nord Electro 5", mapperModel: model, midiCcName: "nordelectro5_midicc.txt");
    }

}
