//
//  ModeLive1To5Bank7.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation

public class ModeLive1To5Bank7: ModeLive1ToXBank7{
    
    private static var KEYS: Int = 5;

    init(mapperModel: MapperModelNord){
        super.init(mapperModel: mapperModel, maxKeys: ModeLive1To5Bank7.KEYS);
    }

}
