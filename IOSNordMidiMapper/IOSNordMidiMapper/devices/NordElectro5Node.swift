//
//  NordElectro5Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

public class NordElectro5Node: GenericDeviceModel {

    public init() {
        
        
        
//        FIXME, das ist nur zum Testen und gehört eigentlich nicht zum Electro5 !!!!!!!!!!!!!!!!!!!!!!! Nicht einchecken!!!!!!!!
        let model = MapperModelNord();
        
        
//        fixme
//        new MapperModelNord(ModeProgram1_1To8_50::new),
        super.init(name: "Nord Electro 5", mapperModel: model, midiCcName: "nordelectro5_midicc.txt");
    }

}
