//
//  NordPiano5Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

public class NordPiano5Node : GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgramA_11ToZ_55(mapperModel: model));
        model.addMode(mode: ModeLive1To5Bank7(mapperModel: model));
        
        super.init(name: "Nord Piano 5",mapperModel: model, midiCcName: "nordpiano5_midicc.txt");
    }

}
