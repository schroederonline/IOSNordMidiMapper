//
//  GenericDeviceModel.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation
import Combine

public  class GenericDeviceModel{
    
    private let name: String;
    private let mapperModel: MapperModelNord;
    private let midiCcName: String;

    
    public init( name: String,  mapperModel: MapperModelNord,  midiCcName: String) {
        self.name = name;
        self.mapperModel = mapperModel;
        self.midiCcName = midiCcName;
    }

    public func getMidiCCFileName() -> String{
        return midiCcName;
    }
    
    public func getMapperModel() -> MapperModelNord {
        return mapperModel;
    }


    public func onMidiModelChanged()->Void {
        let currentText = getMapperModel().getCurrentText();
//        let text = getNordTextfield().getText();
//        if (text != currentText) {
//            getNordTextfield().setText(text: currentText);
//        }
    }


//    @Override
    public func getName() -> String{
        return name;
    }

//    @Override
    public func toString() -> String{
        return getName();
    }

//    FIXME
//    @Override
//    public ControllerTableModel getControllerTableModel() {
//        if (controllerTableModel == null) {
//            controllerTableModel = new ControllerTableModel(getMidiCCFileName());
//        }
//        return controllerTableModel;
//    }

}
