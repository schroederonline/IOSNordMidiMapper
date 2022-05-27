//
//  NumberKeyLimitation.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation


/**
 * Abhängig davon ob es 5 oder 4 Programm Tasten gibt
 *
 * @author marcel
 *
 */
public class NumberKeyLimitation {
    
    private let maxNumberKeys: Int;
    private let greatestCommonDevisor: Int;
    private let numberKeyValues: Array<String>;

    
    public init( numberOfKeys: Int) {
        self.maxNumberKeys = numberOfKeys;
        if (maxNumberKeys == 4) {
            greatestCommonDevisor = 128;
            numberKeyValues = NordNumberUtil.NORD_NUMBER_VALUES_1_TO_4;
        } else if (maxNumberKeys == 5) {
            greatestCommonDevisor = 125;
            numberKeyValues = NordNumberUtil.NORD_NUMBER_VALUES_1_TO_5;
        } else {
            
//           TODO eigenlich sollte hier eine exception geworfen werden
            greatestCommonDevisor = 125;
            numberKeyValues = NordNumberUtil.NORD_NUMBER_VALUES_1_TO_5;
//            throw MyError.runtimeError("numberOfKeys wird nicht unterstützt: ");
//            throw new IllegalArgumentException("numberOfKeys wird nicht unterstützt: " + numberOfKeys);
        }

    }

    public func getMaxNumberKeys() -> Int {
        return maxNumberKeys;
    }

    public func getGreatestCommonDevisor() -> Int{
        return greatestCommonDevisor;
    }

    public func getNumberKeyValues() -> Array<String>{
        return numberKeyValues;
    }

    public func isNordNumber1ToX( x: String) -> Bool{
        return NordNumberUtil.isElementOf(x: x, amount: numberKeyValues);
    }

}
