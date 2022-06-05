//
//  ModeLive1To4Bank7.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

/**
 *
 * LiveMode des NordElectro6
 *
 * Format "1" bis "4"
 *
 *
 *
 * @author marcel
 *
 */
public class ModeLive1To4Bank7 : ModeLive1ToXBank7 {

    init(mapperModel: MapperModelNord){
        super.init(mapperModel: mapperModel, maxKeys: 4);
    }

}
