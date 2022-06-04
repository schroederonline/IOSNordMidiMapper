//
//  GenericDeviceModel.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation
import Combine

//abstract
public  class GenericDeviceModel: ObservableObject
//FIXME
//implements DeviceNodeModel
{
    
    

//    public final static double BORDER = 16.0d;
//    public final static double TEXT_FIELED_WIDTH = 60.0d;
//    public final static double CHOICEBOX_WIDTH = 150.0d;

    private let name: String;
//    private ControllerTableModel controllerTableModel;
    private let  mapperModel: MapperModelNord;
//    FIXME
    //    private final ObservableList<Mode> mode;
//    private var nordTextField: TextFieldImpl;
//    FIXME
    //    private final ChoiceBox<Mode> modeChoiceBox;
    private let midiCcName: String;

    
    
    public init( name: String,  mapperModel: MapperModelNord,  midiCcName: String) {
        self.name = name;
        self.mapperModel = mapperModel;
        self.midiCcName = midiCcName;
//        fixme
//        mode = FXCollections.observableArrayList(mapperModel.getModeList());
//        modeChoiceBox = new ChoiceBox<>(mode);
//        nordTextField = TextFieldImpl(mapperModel: mapperModel);
    }

//    @Override
    public func getMidiCCFileName() -> String{
        return midiCcName;
    }
    

//    FIXME
//    @Override
//    public func getFirstMode() -> Mode{
//        return mode.get(0);
//    }

//    @Override
    public func getMapperModel() -> MapperModelNord {
        return mapperModel;
    }

//    FIXME
//    @Override
//    public Node getNode() {
//        Group root = new Group();
//        HBox nordBox = new HBox(BORDER);
//        root.getChildren().add(nordBox);
//        getMapperModel().addListener(update -> {
//            getChoiceBox().setValue(getMapperModel().getSelectedMode());
//            onMidiModelChanged();
//        });
//        getChoiceBox().getSelectionModel().selectedItemProperty().addListener((ov, oldValue, newValue) -> {
//            getMapperModel().setSelectedMode(newValue);
//            getNordTextfield().setDefaultValue();
//            getMapperModel().update();
//        });
//
//        getNordTextfield().setPrefWidth(TEXT_FIELED_WIDTH);
//        nordBox.getChildren().add(getNordTextfield());
//        getChoiceBox().setValue(getFirstMode());
//        getChoiceBox().setPrefWidth(CHOICEBOX_WIDTH);
//        nordBox.getChildren().add(getChoiceBox());
//        return root;
//    }

    public func onMidiModelChanged()->Void {
        let currentText = getMapperModel().getCurrentText();
//        let text = getNordTextfield().getText();
//        if (text != currentText) {
//            getNordTextfield().setText(text: currentText);
//        }
    }

//    FIXME
//    public ChoiceBox<Mode> getChoiceBox() {
//        return modeChoiceBox;
//    }

//    func getNordTextfield() -> TextFieldImpl{
//        return nordTextField;
//    }

//    @Override
    public func focusTextfield() -> Void{
//        getNordTextfield().requestFocus();
    }

//    @Override
//    public func clearTextfield() -> Void {
//        getNordTextfield().clear();
//    }

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
