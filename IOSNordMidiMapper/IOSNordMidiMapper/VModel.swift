//
//  VModel.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 24.06.22.
//

import Foundation



class VModel: ObservableObject{
    
    @Published var nordProgram: String
    @Published var oldNordProgram: String
    @Published var program: String
    @Published var subBank: String
    @Published var bank: String
    @Published var device: GenericDeviceModel
    @Published var selectedModeIndex: Int
    @Published var midicc: [String]
    @Published var isLowerMidi: Bool = true;
    
    init(device: GenericDeviceModel){
        self.device = device
        let modes =  device.getMapperModel().getModeList()
        let selected = device.getMapperModel().getSelectedMode()
        self.selectedModeIndex = modes.firstIndex{$0 === selected}!
        device.getMapperModel().setSelectedMode(mode: selected)
        
        let defaultIsLowerMidi = true;
        self.isLowerMidi = defaultIsLowerMidi;
        let mapperModel = device.getMapperModel()
        var p = mapperModel.getProgram();
        if(defaultIsLowerMidi){
            p -= 1;
        }
        self.program = String(p)
        var s = mapperModel.getSubBank();
        if(defaultIsLowerMidi){
            s -= 1;
        }
        self.subBank = String(s)
        var b = mapperModel.getBank();
        if(defaultIsLowerMidi){
            b -= 1;
        }
        self.bank = String(b)
        self.nordProgram = mapperModel.getCurrentText()
        self.oldNordProgram = mapperModel.getCurrentText()
        self.midicc = loadFile(fileName: device.getMidiCCFileName())
        
    }
    
    func normalize(midi: Int) -> Int{
        if(isLowerMidi){
            return midi - 1;
        }
        return midi;
    }

    func getDefaultMidiValue() -> String {
        if(isLowerMidi){
            return "0";
        }
        return "1";
    }
    
}
