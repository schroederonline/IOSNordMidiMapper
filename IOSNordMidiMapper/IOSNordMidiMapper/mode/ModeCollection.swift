//
//  ModeCollection.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation

public class ModeCollection :  ObservableObject{

    var modes: [Mode] = [];
    var selected: Mode? = nil;
    
    
    public init() {
    }

    public func addMode( mode: Mode) -> Void{
        modes.append(mode);
        selected = modes[0];
    }

    public func getModes() -> [Mode]  {
        return modes;
    }

    public func getSelectedMode() -> Mode {
        return selected!;
    }

    public func setSelectedMode(mode: Mode) -> Void {
        selected = mode;
    }

}
