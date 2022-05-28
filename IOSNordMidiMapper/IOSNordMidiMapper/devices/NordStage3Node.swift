//
//  NordStage3Node.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

public class NordStage3Node : GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeLive1To5Bank7(mapperModel: model));
//        FIXME  MapperModelNord(ModeProgramA_11ToZ_55::new, ModeSong1_01_1To3_49_5Bank2::new, ModeLive1To5Bank7::new)
        
        super.init(name: "Nord Stage 3",  mapperModel: model, midiCcName: "nordstage3_midicc.txt");
    }
    

}
