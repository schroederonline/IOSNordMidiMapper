//
//  NordStage2Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

//FIXME Funktioniert braucht aber noch optimierungen bei der Eingabe	
public class NordStage2Node: GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgramA_01_1ToD_20_5(mapperModel: model));
        model.addMode(mode: ModeLive1To5Upper100Program(mapperModel: model));
        super.init(name: "Nord Stage 2",  mapperModel: model, midiCcName: "nordstage2_midicc.txt");
    }

}
