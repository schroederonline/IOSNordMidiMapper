//
//  ModeProgramA_11ToZ_XX.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

//abstract
public class ModeProgramA_11ToZ_XX: GenericMode {

    private let keyImpl: NumberKeyLimitation;

    public init( mapperModel: MapperModelNord, numberOfKeys:  Int) {
        keyImpl = NumberKeyLimitation(numberOfKeys: numberOfKeys);
        super.init(mapperModel: mapperModel, name: "Program Mode", defaultProgram: "A:11", bank: 1);

    }

    /**
     * macht aus bank, subBank und program einen String im Format A:32
     */
    public override func midiToNordProgram() -> Void{
        let MAX_NUMBER_KEYS = keyImpl.getMaxNumberKeys();
        let p: Int = getMidiModel().getProgram();
        var pOffset = Int( (p - 1) / (MAX_NUMBER_KEYS * MAX_NUMBER_KEYS));
        let s = getMidiModel().getSubBank();
        if(MAX_NUMBER_KEYS == 4){
            pOffset += (s - 1) * MAX_NUMBER_KEYS ;
        }
        var charIndex = Int( ((s - 1) * MAX_NUMBER_KEYS ) + pOffset);
        if (charIndex > NordNumberUtil.NORD_CHARS.count - 1) {
            charIndex = NordNumberUtil.NORD_CHARS.count - 1;
        }
        let result:String = NordNumberUtil.NORD_CHARS[charIndex] + ":";
        let index: Int = Int(((p - 1) % (MAX_NUMBER_KEYS * MAX_NUMBER_KEYS)));
        let indexOf:String = keyImpl.getNumberKeyValues()[index];
        setCurrentText(currentText: result +  indexOf );
    }

    /**
     * @param text Format A:12
     */
    public override func setNordProgram(s: String)->Void{
        var text: String = s;
        if (text.count != 4) {
            text = toDefault();
        }
        let isChanged: Bool = setCurrentText(currentText: text);
        getMidiModel().setBank(bank2: toBank(), updateOnChange: false);
        let MAX_NUMBER_KEYS: Int = keyImpl.getMaxNumberKeys();
        var firstChar: String = text[0];
        let charIndex: Int = NordNumberUtil.indexOf(needle: firstChar, amount:NordNumberUtil.NORD_CHARS);
        var subBank: Int = 1;
        if (MAX_NUMBER_KEYS == 5) {
            subBank = (charIndex / MAX_NUMBER_KEYS) + 1;
        } else if (MAX_NUMBER_KEYS == 4) {
            subBank = (charIndex / (MAX_NUMBER_KEYS * 2)) + 1;
        }
        getMidiModel().setSubBank(subBank2: subBank, updateOnChange: false);
        var charoffset: Int = (charIndex * (MAX_NUMBER_KEYS * MAX_NUMBER_KEYS));
        
        var up: Int = Int(text[2])!;
        var low: Int = Int(text[3])!;
        let program: Int = (charoffset % (keyImpl.getGreatestCommonDevisor()) + low + ((up - 1) * MAX_NUMBER_KEYS)) % (keyImpl.getGreatestCommonDevisor() + 1);
        getMidiModel().setProgram(program: program, updateOnChange: false);
        if (isChanged) {
            getMidiModel().update();
        }
    }

    /**
     * Format "A:11";
     */
    public override func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
        if (oldValue == newValue) {
            return "";
        }
        let given: String = newValue.uppercased();
        var result: String = given;
        let isFirstChar: Bool = given.length() >= 1 && NordNumberUtil.isNordChar(x: given[0]);
        if (!isFirstChar) {
            return "";
        }
        if(oldValue.length() == 4 && newValue.length() == 3){
            return newValue[0] + ":" ;
        }
        
        if (!oldValue.contains(needle: ":")) {
            if (given.length() == 1 && isFirstChar) {
                result = result + ":";
            }
        } else if (given.length() == 1 && oldValue.length() == 2) {
            return "";
        } else if (given.length() == 2 && oldValue.length() == 4 && !given.contains(needle: ":")){
            if(NordNumberUtil.isNumber(x: result[1], from: 1, to: keyImpl.getMaxNumberKeys())){
                result = result[0] + ":" + result[1];
            }else if (result[2] != ":"){
                result = result[0] + ":"
            }
        }
        if (result.length() == 3) {
            if(!NordNumberUtil.isNumber(x: result[2], from: 1, to: keyImpl.getMaxNumberKeys())){
                result = result.substring(fromIndex: 0, toIndex: 2);
            }
        }
        if (result.length() == 4) {
            if(!NordNumberUtil.isNumber(x: result[3], from: 1, to: keyImpl.getMaxNumberKeys())){
                result = result.substring(fromIndex: 0, toIndex: 3);
            }
        }
        if (result.length() > 4) {
            result = result.substring(fromIndex: 0, toIndex: 4);
        }
        return result;
    }

}
