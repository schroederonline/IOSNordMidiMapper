//
//  MapperModelNord.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation


public class MapperModelNord: MidiModel{

    private var modeCollection: ModeCollection;

    public override init(){
        self.modeCollection = ModeCollection();
    }
    
    public func addMode(mode: Mode) -> Void {
        modeCollection.addMode(mode: mode);
    }

    public func getModeCollection() -> ModeCollection {
        return modeCollection;
    }

    public func getModeList() -> Array<Mode> {
        return getModeCollection().getModes();
    }

    public func setSelectedMode( mode: Mode)-> Void {
        let isChanged = mode.getId() != getSelectedMode().getId();
        if (isChanged) {
            getModeCollection().setSelectedMode(mode: mode);
            setDefault();
            updateMidiToWhatEver();
        }
    }

    public func getSelectedMode() -> Mode {
        return getModeCollection().getSelectedMode();
    }

    public func setDefault()-> Void {
        let mode = getSelectedMode();
        mode.getProgramConsumer().accept(t: mode.toDefault());
    }

    /**
     * gibt den aktuelen Wert für das Textfeld zurück
     */
    public func getCurrentText() -> String {
        return getSelectedMode().getCurrentText();
    }

    
    public override func updateMidiToWhatEver() -> Void{
        let modes = getModeList();
        let banks = modes.map{
            (s) -> Int in
            s.toBank();
        };
        let count = Set<Int>(banks).count;
        if(count > 1){
            for mode in modes {
                if(mode.bank == getBank()){
                    if(mode.getId() != getSelectedMode().getId()){
                        setSelectedMode(mode: mode);
                    }
                }
            }
        }
        getSelectedMode().getUpdateMidiToWhatEver().run();
    }

}
