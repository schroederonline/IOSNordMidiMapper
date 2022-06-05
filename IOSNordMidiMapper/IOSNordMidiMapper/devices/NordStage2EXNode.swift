//
//  NordStage2EXNode.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation


public class NordStage2EXNode: GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgramA_01_1ToD_20_5(mapperModel: model));
        model.addMode(mode: ModeLive1To5Upper100Program(mapperModel: model));
        super.init(name: "Nord Stage 2 EX",  mapperModel: model, midiCcName: "nordstage2_midicc.txt");
    }

}
