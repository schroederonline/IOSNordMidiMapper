//
//  ModeSong1_01_1To3_49_5Bank2.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 07.06.22.
//

import Foundation


/**
 * SongMode vom NordStage3
 * <p>
 * Format: "1:01-1" bis "3:49-5" vielleicht auch noch mehr?
 * <p>
 * <p>
 * FIXME wenn man als subbank 4 eingibt crashed die app
 *
 * FIXME nab 2:01-1 wird es buggy
 * @author marcel
 */
public class ModeSong1_01_1To3_49_5Bank2: GenericMode {

    private static let MAX_NUMBER_KEYS: Int = 5;
    private static let GREATESTCOMMON_DEVISOR: Int = 125;

    public init( mapperModel: MapperModelNord) {
        super.init(mapperModel: mapperModel, name: "Song Mode", defaultProgram: "1:01-1", bank: 2);
    }

    /**
     * Format "1:01-1"
     */
    
    public override func midiToNordProgram() -> Void{

        var result: String = String(toSongIndexPart(subBank: getMidiModel().getSubBank())) + ":";
        var songNumberPart: Int = toSongNumberPart(subBank: getMidiModel().getSubBank(), program: getMidiModel().getProgram());
        if (songNumberPart < 10) {
            result += "0";
        }
        result += String(songNumberPart);
        result += "-";
        result += String(toSongProgramPart(program: getMidiModel().getProgram()));
        setCurrentText(currentText: result);
    }

    /**
     * @param text Format: "1:01-1"
     */
    
    public override func setNordProgram(s: String) -> Void{
        var text = s;
        if (text.length() != 6) {
            text = toDefault();
        }
        let isChanged: Bool = setCurrentText(currentText: text);
        getMidiModel().setBank(bank: toBank());
        var songIndex: Int = Int(text.substring(fromIndex: 0, toIndex: 1))!;
        var songNumber: Int = Int(text.substring(fromIndex: 2, toIndex: 4))!;
        var subBank: Int = (songNumber - 1) / (ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS * ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS);
        if (songIndex >= 2) {
            subBank += songIndex - 1;
        }
        getMidiModel().setSubBank(subBank: subBank + songIndex);
        var programIndex: Int = Int(text.substring(fromIndex: 5, toIndex: 6))!;
        getMidiModel().setProgram(program: (songNumber - 1) * ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS % ModeSong1_01_1To3_49_5Bank2.GREATESTCOMMON_DEVISOR + programIndex);
        if (isChanged) {
            getMidiModel().update();
        }
    }

    /**
     * Format: "1:01-1"
     */
    public override func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
        if (oldValue == newValue) {
            return oldValue;
        }
        var given: String = newValue.toUpperCase();
        var result: String = given;
        //FIXME hier ist was fischig! war vorher  NordNumberUtil.isNordNumber1To8(given.charAt(0));
        var isFirstNumber1Or2: Bool = given.length() >= 1 && NordNumberUtil.isNordNumber1To2(x: given[0]);
        if (!isFirstNumber1Or2) {
            return "";
        }
        if (!oldValue.contains(":")) {
            if (given.length() == 1 && isFirstNumber1Or2) {
                result = result + ":";
            }
        } else if (given.length() == 1 && oldValue.length() == 2) {
            return "";
        }
        if (result.length() == 3) {
            if (!NordNumberUtil.isNordNumber0To9(x: result[2])) {
                result = result.substring(fromIndex: 0, toIndex: 2);
            }
        }
        if (result.length() == 4) {
            if (!NordNumberUtil.isNordNumber0To9(x: result[3])) {
                result = result.substring(fromIndex: 0, toIndex: 3);
            }
        }
        if (!oldValue.contains("-")) {
            if (given.length() == 4) {
                result = result + "-";
            } else if (result.length() == 5) {
                if (!(result.substring(fromIndex: 4, toIndex: 5) == "-") ) {
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
        return result;
    }

    
    public func toSongIndexPart( subBank: Int) -> Int{
        return ((subBank - 1) / 2) + 1 % 8;
    }


    public func toSongNumberPart( subBank: Int,  program: Int) -> Int{
        var number: Int = ((program - 1) / ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS) + 1;
        if (subBank % 2 == 0) {
            number += ((subBank - 1) * (ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS * ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS));
        }
        return number;
    }


    public func toSongProgramPart( program: Int) -> Int {
        let programIndex: Int = ((program - 1) % ModeSong1_01_1To3_49_5Bank2.MAX_NUMBER_KEYS) + 1;
        return programIndex;
    }

}
