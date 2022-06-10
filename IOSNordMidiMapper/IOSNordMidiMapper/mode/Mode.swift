//
//  Mode.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation


public protocol Runnable{
    func run() -> Void;
}

public protocol StringConsumer{
    func accept(t: String) -> Void;
}

public class StringConsumerImpl: StringConsumer{
    public func accept(t: String) {
        //dummy
    }
}

public class RunableImpl: Runnable{
    public func run() {
        //dummy
    }
}

public class Mode:  Identifiable{
    
    public let id: String;
    let name: String;
    var defaultProgram: String;
    var programConsumer: StringConsumer;
    var currentText: String;
    var updateMidiToWhatEver: Runnable;
    var bank: Int = 1;

    convenience init(name: String, defaultProgram: String){
        self.init(name: name, defaultProgram: defaultProgram, bank: 1);
    }
    
    init(name: String, defaultProgram: String, bank: Int){
        self.id = UUID().uuidString;
        self.name = name;
        self.defaultProgram = defaultProgram;
        self.currentText = defaultProgram;
        self.programConsumer = StringConsumerImpl();
        self.updateMidiToWhatEver = RunableImpl();
        self.bank = bank;
    }
    
    public func getName()->String{
        return name;
    }
    
    public func toBank()->Int{
        return self.bank;
    }
    
    public func getId()->String{
        return id;
    }
    
    public func toDefault() ->String{
        return defaultProgram;
    }
    
    public func getCurrentText() -> String{
        return currentText;
    }
    
    public func setCurrentText( currentText: String) -> Bool{
        let isChanged = self.currentText != currentText;
        self.currentText = currentText;
        return isChanged;
    }
    
    public func getUpdateMidiToWhatEver() -> Runnable{
        return updateMidiToWhatEver;
    }

    public func setUpdateMidiToWhatEver( updateMidiToWhatEver: Runnable)-> Void {
        self.updateMidiToWhatEver = updateMidiToWhatEver;
    }
    
    public func setProgramConsumer( consumer: StringConsumer) ->Void{
        self.programConsumer = consumer;
    }

    public func  getProgramConsumer() -> StringConsumer{
        return programConsumer;
    }

    public func onNordProgramTextChanged(oldValue: String, newValue: String) -> String{
//     override me
        return "";
    }

    public func setNordProgram(s: String)->Void{
//       override me
    }
}
