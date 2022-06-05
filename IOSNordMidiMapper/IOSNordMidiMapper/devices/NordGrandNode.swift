//
//  NordGrandNode.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation
public class NordGrandNode: GenericDeviceModel {

    public init() {
        let model = MapperModelNord();
        model.addMode(mode: ModeProgramA_11ToZ_55(mapperModel: model));
        model.addMode(mode: ModeLive1To5Bank7(mapperModel: model));
        super.init(name: "Nord Grand", mapperModel: model, midiCcName: "nordgrand_midicc.txt");
    }

}
