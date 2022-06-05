//
//  NordElectro6Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

public class NordElectro6Node : GenericDeviceModel {

    public init() {
        
        let model = MapperModelNord();
        model.addMode(mode: ModeProgramA_11ToZ_44(mapperModel: model));
        model.addMode(mode: ModeLive1To4Bank7(mapperModel: model));
        super.init(name: "Nord Electro 6",  mapperModel: model, midiCcName: "nordelectro6_midicc.txt");
        
    }

}
