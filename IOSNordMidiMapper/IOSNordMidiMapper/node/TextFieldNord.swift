////
////  TextFieldNord.swift
////  IOSNordMidiMapper
////
////  Created by Marcel Schröder on 28.05.22.
////
//
//import Foundation
//
//public class TextFieldNord: TextFieldImpl{
//
//
//    private let  mapperModel: MapperModelNord;
//
//    public init(mapperModel: MapperModelNord) {
//        self.mapperModel = mapperModel;
////        FIXME
////        for (Mode mode : mapperModel.getModeList()) {
////            textProperty().addListener(mode.getTextFieldListener().apply(this));
////        }
////        addEventHandler(KeyEvent.KEY_PRESSED, keyEvent -> {
////            if (keyEvent.getCode() == KeyCode.ESCAPE) {
////                Platform.runLater(this::clear);
////                setDefaultValue();
////            }
////        });
////        setDefaultValue();
//    }
//
//    public func setDefaultValue() -> Void{
//        super.clear();
////        Platform.runLater(this::clear);
//        mapperModel.setDefault();
//        setPromptText(promtText: mapperModel.getSelectedMode().toDefault());
//    }
//
//}
