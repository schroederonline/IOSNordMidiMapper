//
//  ModeProgram1_1To8_128.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation


/**
 * Program Mode Format 1:1 bis 8:128
 * <p>
 * sehr einfacher Mode, die erste Zahl gibt die SubBank (1-8) and, die zweite
 * Zahl das Programm (1-128)
 * <p>
 * <p>
 * <p>
 * Wird verendet um NordWave
 *
 * @author marcel
 */
public class ModeProgram1_1To8_128 : GenericMode {

    public init( mapperModel: MapperModelNord) {
        super.init(mapperModel: mapperModel, name: "Program Mode", defaultProgram: "1:1", bank: 1);
    }

    /**
     * macht aus bank, subBank und program einen String im Format 1:3
     */
    public override func midiToNordProgram() -> Void{
        let page: Int = getMidiModel().getSubBank();
        let pNumber: Int = getMidiModel().getProgram();
        var result: String = "";
        result += String(page);
        result += ":";
        result += String(pNumber);
        setCurrentText(currentText: result);
    }

    /**
     * @param s Format 1:1 bis 8:128
     */
    public override func setNordProgram( s: String) -> Void{
        let isChanged: Bool = setCurrentText(currentText: s);
        getMidiModel().setBank(bank: 1);
        let split = s.split(separatedBy: ":");
        if(split.count == 2){
            let page: Int = Int(split[0])!;
            getMidiModel().setSubBank(subBank: page);
            let program: Int = Int(split[1])!;
            getMidiModel().setProgram(program: program);
            if (isChanged) {
                getMidiModel().update();
            }
        }
    }

    /**
     * Format "1:1" oder "2:16" bis max "8:128";
     */
    public override func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
        
        if (oldValue == newValue) {
            return oldValue;
        }
            
        var given: String = newValue.toUpperCase();
        given = NordNumberUtil.replacePlaceHolderString(x: given);
        var result: String = given;
        let isFirstNumber: Bool = given.length() >= 1 && NordNumberUtil.isNordNumber1To8(x: given[0]);
        if (!isFirstNumber) {
            return "";
        }
        if (given.length() == 1 && !oldValue.contains(":")) {
            result += ":";
        }
        if (result.length() == 3) {
            if (!NordNumberUtil.isNordNumber0To9(x: result[2])) {
                result = result.substring(fromIndex: 0, toIndex: 1);
            }
        }
        if (result.length() == 4) {
            if (!NordNumberUtil.isNordNumber0To9(x: result[3])) {
                result = result.substring(fromIndex: 0, toIndex: 3);
            }
        }
        if (result.length() == 5) {
            if (!NordNumberUtil.isNordNumber0To9(x: result[4])) {
                result = result.substring(fromIndex: 0, toIndex: 3);
            }
        }
        if (result.length() > 5) {
            result = result.substring(fromIndex: 0, toIndex: 5);
        }

            if (result.contains(":")) {
                let split = result.split(separatedBy: ":");
                if (split.count == 2) {
                    let numberPart: String = split[1];
                    if (!NordNumberUtil.isNumber1To128(x: numberPart)) {
                        result = oldValue;
                    }
                }
            }
//            if (result.length() >= 3) {
//                getProgramConsumer().accept(result);
//            }
//            textfield.setText(result);
        return result;
    }
}
