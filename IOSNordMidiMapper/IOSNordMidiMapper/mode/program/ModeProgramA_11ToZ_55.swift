//
//  ModeProgramA_11ToZ_55.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 04.06.22.
//

import Foundation


/**
 * A:11 bis Z:55
 * <p>
 * Wird verwendet in NordStage3, NordWave2
 *
 * @author marcel
 */
public class ModeProgramA_11ToZ_55: ModeProgramA_11ToZ_XX {

    public init ( mapperModel: MapperModelNord) {
        super.init(mapperModel: mapperModel, numberOfKeys: 5);
    }

}
