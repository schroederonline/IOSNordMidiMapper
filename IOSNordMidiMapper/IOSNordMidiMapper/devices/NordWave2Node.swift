//
//  NordWave2Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

public class NordWave2Node: GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgramA_11ToZ_55(mapperModel: model));
        model.addMode(mode: ModeLive1To5Bank7(mapperModel: model));
        
        super.init(name: "Nord Wave 2",mapperModel: model,midiCcName: "nordwave2_midicc.txt");

    }

}
