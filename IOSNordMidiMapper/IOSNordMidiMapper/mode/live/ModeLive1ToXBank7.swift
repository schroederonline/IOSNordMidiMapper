//
//  ModeLive1ToXBank7.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation

public class ModeLive1ToXBank7: GenericMode{
    
    private var keyImpl: NumberKeyLimitation;

    public init( mapperModel: MapperModelNord,  maxKeys: Int) {
        self.keyImpl = NumberKeyLimitation(numberOfKeys: maxKeys);
        super.init(mapperModel: mapperModel, name: "Live Mode", defaultProgram: "1", bank: 7);
    }

    public override func  midiToNordProgram()-> Void {
        getMidiModel().setBank(bank: 7);
        var p = getMidiModel().getProgram();
        if (p < 1 || p > keyImpl.getMaxNumberKeys()) {
            p = 1;
        }
        setCurrentText(currentText: String(p));
    }

    public override func setNordProgram( s: String) -> Void{
        
        
        var text = s;
        if (text.count != 1) {
            text = toDefault();
        }
        getMidiModel().setBank(bank: toBank());
        getMidiModel().setSubBank(subBank: 1);
        getMidiModel().setProgram(program: Int(text)!);
        let isChanged = setCurrentText(currentText: text);
        if (isChanged) {
            getMidiModel().update();
        }
    }


    /**
     * Format "1";
     */
    public override func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
            if (oldValue == newValue) {
                return oldValue;
            }
//            if (!getSelectedModeSupplier().get().equals(this)) {
//                return;
//            }
        let given: String  = newValue.toUpperCase();
        var result: String = given;
            if (result.length() > 1) {
                result = result.substring(fromIndex: 0, toIndex: 1);
            }
            if (result.length() == 1) {
                if(NordNumberUtil.isNumber(x: result[0], from: 1, to: keyImpl.getMaxNumberKeys())){
                    result = result.substring(fromIndex: 0, toIndex: 1);
                } else {
                    result = "";
                }
            }
        setNordProgram(s: result);
        return result;
//    };
    }

}
