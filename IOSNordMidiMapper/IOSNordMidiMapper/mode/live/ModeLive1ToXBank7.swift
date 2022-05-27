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

//  FIXME
//    /**
//     * Format "1";
//     */
//    @Override
//    public ChangeListener<? super String> createNordProgramListener(TextField textfield) {
//        return (ov, oldValue, newValue) -> {
//            if (Objects.equal(oldValue, newValue)) {
//                return;
//            }
//            if (!getSelectedModeSupplier().get().equals(this)) {
//                return;
//            }
//            final String given = newValue.toUpperCase();
//            String result = given;
//            if (result.length() > 1) {
//                result = result.substring(0, 1);
//            }
//            if (result.length() == 1) {
//                if (keyImpl.isNordNumber1ToX(result.charAt(0))) {
//                    result = result.substring(0, 1);
//                } else {
//                    Platform.runLater(() -> textfield.clear());
//                    return;
//                }
//            }
//            getProgramConsumer().accept(result);
//            textfield.setText(result);
//        };
//    }

}
