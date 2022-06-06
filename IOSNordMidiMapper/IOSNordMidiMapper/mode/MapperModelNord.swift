//
//  MapperModelNord.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation
import Combine
import SwiftUI

public class MapperModelNord: MidiModel {
    

    var modeCollection: ModeCollection;

    var currentText = "";
    
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
        getModeCollection().setSelectedMode(mode: mode);
        setDefault();
        updateMidiToWhatEver();
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

    
   /* protected void updateMidiToWhatEver() {
            if (getModeList().stream().map(x -> x.toBank()).distinct().count() > 1) {
                getModeList().stream().filter(m -> m.toBank() == getBank()).findFirst().ifPresent(nextMode -> {
                    if (!nextMode.equals(getSelectedMode())) {
                        setSelectedMode(nextMode);
                    }
                });
            }
            getSelectedMode().getUpdateMidiToWhatEver().run();
        }*/
    
    public override func updateMidiToWhatEver() -> Void{
        let modes: Array<Mode> = getModeList();
        let banks: [Int] = modes.map{
            (s) -> Int in
            return s.toBank();
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
        currentText = getCurrentText();
    }

}
