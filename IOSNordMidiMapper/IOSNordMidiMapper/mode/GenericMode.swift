//
//  GenericMode.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation

public protocol ModeSupplier{
    func get() -> Mode;
}


public class ModeSupplierImpl: ModeSupplier{
    
    let mapperModelNord :MapperModelNord;
    
    init( mapperModelNord :MapperModelNord){
        self.mapperModelNord =  mapperModelNord;
    }
    
    public func get() -> Mode {
       return mapperModelNord.getSelectedMode();
    }
}


public class RunnableImpl: Runnable{

    let gm: GenericMode;
    init(gm: GenericMode){
        self.gm = gm;
    }
    
    public func run() {
        gm.midiToNordProgram();
    }
}

class StringConsumerImpl2: StringConsumer{
    let gm: GenericMode;
    init(gm: GenericMode){
        self.gm = gm;
    }
    public func accept(t: String) {
        gm.setNordProgram(s: t);
    }
    
    
}

public class GenericMode: Mode{
    
    
    let midiModel: MidiModel;
    let selectedModeSupplier: ModeSupplier;

    public init( mapperModel: MapperModelNord,  name: String,  defaultProgram: String,  bank: Int) {
        self.midiModel = mapperModel;
        self.selectedModeSupplier = ModeSupplierImpl(mapperModelNord: mapperModel);
//        FIXME
//        setTextFieldListener(this::createNordProgramListener);
        
        super.init(name: name, defaultProgram:defaultProgram, bank: bank);
        setUpdateMidiToWhatEver(updateMidiToWhatEver: RunnableImpl(gm: self));
        setProgramConsumer(consumer: StringConsumerImpl2(gm: self));
    }

//    abstract
    public func midiToNordProgram()->Void{
//        override me
    }

//    abstract
    public override func setNordProgram(s: String)->Void{
//       override me
    }

//    FIXME
//    public abstract ChangeListener<? super String> createNordProgramListener(TextField textfield);
    public override func onTextChanged(oldValue: String, newValue: String) -> String?{
//     override me
        return nil;
    }

    
//    abstract
//    public func onTextChanged(text: String) -> String{
//
//    }
    
    public func getMidiModel()-> MidiModel {
        return midiModel;
    }

    public func getSelectedModeSupplier()-> ModeSupplier {
        return selectedModeSupplier;
    }

    
}
