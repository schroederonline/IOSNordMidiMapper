//
//  ModeProgramA_01_1ToD_20_5.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

/**
 * Verwendet von NordStage 2
 * <p>
 * <p>
 * Format "A:01-1" bis "D:20-5"
 *
 * @author marcel
 */
public class ModeProgramA_01_1ToD_20_5: GenericMode {

    public init( mapperModel: MapperModelNord) {
        super.init(mapperModel: mapperModel, name: "Program Mode", defaultProgram: "A:01-1", bank: 1);
    }

    /**
     * macht aus bank, subBank und program einen String im Format A:01-1
     */
    public override func midiToNordProgram() -> Void{
        var sub: Int = getMidiModel().getSubBank();
        if (sub < 1 || sub > 4) {
            sub = 1;
        }
        var result: String = NordNumberUtil.NORD_CHARS_A_TO_D[(sub - 1)];
        result += ":";
        var program2 :Int = getMidiModel().getProgram();
        var middle: Int = (program2 / 5) + 1;
        if (middle <= 9) {
            result += "0";
        }
        result += String(middle);
        result += "-";
        var lastPart: Int = program2 % 5;
        result += String(lastPart);
        setCurrentText(currentText: result);

    }

    /**
     * @param p Format A:01-1
     */
    
    public override func setNordProgram( s: String) -> Void {
        var nordProgram = s;
        if (nordProgram.length() != 6) {
            nordProgram = toDefault();
        }
        var isChanged:Bool = setCurrentText(currentText: s);
        getMidiModel().setBank(bank: 1);
        var needle = nordProgram.substring(fromIndex: 0, toIndex: 1);
        var index: Int = NordNumberUtil.indexOf(needle: needle, amount: NordNumberUtil.NORD_CHARS_A_TO_D)
        var subBank: Int = index + 1;
        if (subBank < 1 || subBank > 4) {
            subBank = 1;
        }
        getMidiModel().setSubBank(subBank: subBank);
        var middlePart: Int = Int(nordProgram.substring(fromIndex: 2, toIndex: 4))! - 1;
        var lastPart: Int = Int(nordProgram.substring(fromIndex: 5, toIndex: 6))!;
        getMidiModel().setProgram(program: (middlePart * 5) + lastPart);
        if (isChanged) {
            getMidiModel().update();
        }
    }

    /**
     * Format "A:20-1";
     */
    public override func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
        if (oldValue == newValue) {
            return oldValue;
        }
        var given: String = newValue.toUpperCase();
        var result: String = given;
        var isFirstChar: Bool = given.length() >= 1 && NordNumberUtil.isNordCharAToD(x: given[0]);
        if (!isFirstChar) {
            return "";
        }
        if (!oldValue.contains(":")) {
            if (given.length() == 1 && isFirstChar) {
                result = result + ":";
            }
        } else if (given.length() == 1 && oldValue.length() == 2) {
            return "";
        }
        if (result.length() == 3) {
            if (!NordNumberUtil.isNordNumber0To2(x: result[2])) {
                result = result.substring(fromIndex: 0, toIndex: 2);
            }
        }
        if (result.length() == 4) {
            if (!NordNumberUtil.isNordNumber0To9(x: result[3])) {
                result = result.substring(fromIndex: 0, toIndex: 3);
            }
        }
        if (result.length() == 4) {
            // limit to 20
            var sub: String = result.substring(fromIndex: 2, toIndex: 4);
            var number: Int = Int(sub)!;
            if (number > 20) {
                result = result.replace(of: sub, with: "20");
            }
        }
        if (!oldValue.contains("-")) {
            if (given.length() == 4) {
                result = result + "-";
            } else if (result.length() == 5) {
                if (!(result.substring(fromIndex: 4, toIndex: 5) == "-")) {
                    var tmp: String = result.substring(fromIndex: 4, toIndex: 5);
                    result = result.substring(fromIndex: 0, toIndex: 4) + "-" + tmp;
                }
            }
        }
        if (result.length() == 6) {
            if (!NordNumberUtil.isNordNumber1To5(x: result[5])) {
                result = result.substring(fromIndex: 0, toIndex: 5);
            }
        }
        if (result.length() > 6) {
            result = result.substring(fromIndex: 0, toIndex: 6);
        }
//            if (result.length() == 6) {
//                getProgramConsumer().accept(result);
//            }
        return result;
//            textfield.setText(result);
        
    }

}
