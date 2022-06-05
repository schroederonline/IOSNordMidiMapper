//
//  ModeLive1To5Upper100Program.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 05.06.22.
//

import Foundation

/**
 * Format 1 bis 5
 * <p>
 * es werden einfach die Programme 101 bis 105 verwendet
 * <p>
 * Verwendet im Nord Stage 2
 *
 * @author marcel
 */
public class ModeLive1To5Upper100Program: GenericMode {

    public init( mapperModel: MapperModelNord) {
        super.init(mapperModel: mapperModel, name: "Live Mode", defaultProgram: "1", bank: 1)
    }

    /**
     * macht aus bank, subBank und program einen String im Format 1
     */
    
    public override func midiToNordProgram() -> Void{
        var p: Int = getMidiModel().getProgram();
        if (p < 101 || p > 105) {
            p = 101;
        }
        setCurrentText(currentText: String(p - 100));
    }

    /**
     * @param s Format 1
     */
    
    public override func setNordProgram(s: String) -> Void{
        var nordProgram = s;
        if (nordProgram.length() != 1) {
            nordProgram = toDefault();
        }
        var isChanged: Bool = setCurrentText(currentText: nordProgram);
        getMidiModel().setBank(bank: 1);
        getMidiModel().setSubBank(subBank: 1);
        getMidiModel().setProgram(program: 100 + Int(nordProgram.substring(fromIndex: 0, toIndex: 1))!);
        if (isChanged) {
            getMidiModel().update();
        }
    }

    /**
     * Format: "1"
     */
//    @Override
//    public ChangeListener<? super String> createNordProgramListener(TextField textfield) {
    public override func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
        
        if (oldValue == newValue) {
            return oldValue;
        }
        
        var result: String = newValue;
        var isFirstNumber1Or2: Bool = newValue.length() >= 1 && NordNumberUtil.isNordNumber0To9(x: newValue[0]);
        if (!isFirstNumber1Or2) {
            return "";
        }
        if (result.length() > 1) {
            result = result.substring(fromIndex: 0, toIndex: 1);
        }
//            getProgramConsumer().accept(result);
//            textfield.setText(result);
        return result;
    }

}
