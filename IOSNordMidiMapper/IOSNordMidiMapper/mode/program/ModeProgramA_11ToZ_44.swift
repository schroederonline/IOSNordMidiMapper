//
//  ModeProgramA_11ToZ_44.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation


/**
 * A:11 bis Z:44
 *
 * Wird im NordElectro6 verwendet
 *
 *
 * @author marcel
 *
 */
public class ModeProgramA_11ToZ_44: ModeProgramA_11ToZ_XX {

    public init( mapperModel: MapperModelNord) {
        super.init(mapperModel: mapperModel, numberOfKeys: 4);
    }

}
