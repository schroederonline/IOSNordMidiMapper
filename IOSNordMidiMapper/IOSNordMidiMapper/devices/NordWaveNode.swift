//
//  NordWaveNode.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

/**
 * Nord Wave
 *
 * @author marcel
 */
public class NordWaveNode : GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgram1_1To8_128(mapperModel: model));
        
        super.init(name: "Nord Wave", mapperModel: model, midiCcName: "nordwave_midicc.txt");
    }

}
