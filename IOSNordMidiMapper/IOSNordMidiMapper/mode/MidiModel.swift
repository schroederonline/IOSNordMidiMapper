//
//  MidiModel.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation


class  MidiModel{
    
//    FIXME
//    private final Set<InvalidationListener> listeners = new HashSet<>();
    
    var bank: Int = 1;
    var subBank: Int = 1;
    var program: Int = 1;
    
    func getBank() -> Int {
        return bank;
    }
    
    func setBank(bank: Int) -> Void{
        setBank( bank2: bank, updateOnChange: true);
    }
    
    func getSubBank() -> Int {
        return subBank;
    }
    
    func setSubBank(subBank: Int) -> Void{
        setSubBank(subBank2: subBank, updateOnChange: true);
    }
    
    func getProgram() -> Int {
        return program;
    }
    
    func setProgram(program: Int) -> Void{
        setProgram(program: program, updateOnChange: true);
    }
    
    
    public func setProgram( program:Int,  updateOnChange: Bool)->Bool {
        var next: Int = toMidiNumber(given2: program);
        var isChanged:Bool = next != getProgram();
        self.program = next;
        if (updateOnChange && isChanged) {
            update();
        }
        return isChanged;
    }
    
    
    public func setSubBank( subBank2: Int,  updateOnChange:Bool)->Bool {
        var subBank = subBank2;
        if (subBank < 1 || subBank > 8) {
            subBank = 1;
        }
        var next = toMidiNumber(given2: subBank);
        var isChanged = next != getSubBank();
        self.subBank = next;
        if (updateOnChange && isChanged) {
            update();
        }
        return isChanged;
    }
    
    public func setBank( bank2: Int,  updateOnChange: Bool) ->Bool{
        var bank = bank2;
        if (bank < 1 || bank > 8) {
            bank = 1;
        }
        var isChanged = bank != getBank();
        self.bank = bank;
        if (updateOnChange && isChanged) {
            update();
        }
        return isChanged;
    }
    
    private func toMidiNumber(given2: Int) -> Int {
        var given = given2;
        if (given < 1 || given > 128) {
            given = 1;
        }
        return given;
    }
    
    func updateMidiToWhatEver() -> Void {
        //muss überschrieben werden
    };
    
    func update() -> Void {
            updateMidiToWhatEver();
        //FIXME
        //listeners.forEach(l -> l.invalidated(this));
    }
    
    
//    FIXME
//    @Override
//    public void addListener(InvalidationListener listener) {
//        listeners.add(listener);
//    }

//    @Override
//    public void removeListener(InvalidationListener listener) {
//        listeners.remove(listener);
//    }


    
    
    
    func  replacePlaceHolderString( text: String)-> String  {
        var s = text;
        s = s.replacingOccurrences(of: ".", with: ":");
        s = s.replacingOccurrences(of: ",", with: ":");
        s = s.replacingOccurrences(of: "-", with: ":");
        s = s.replacingOccurrences(of: " ", with: ":");
        return s;
    }
}
