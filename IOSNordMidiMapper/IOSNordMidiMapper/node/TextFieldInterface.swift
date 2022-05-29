//
//  TextField.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation
import SwiftUI


protocol TextFieldInterface {
    func setText (text: String) -> Void
}
/**
 * Portierung des JavaFX Textfields 
 */
//public class TextFieldImpl{
//    
//    private let textField : TextField?;
//    public init(textField: TextField?){
//        self.textField = textField;
//    }
//    
//    public func clear() -> Void{
//        textField.text = ""
//    }
//    
//    public func setPromptText(promtText : String)-> Void{
//        textField.placeholder = promtText;
//    }
//    
//    public func setText (text: String) -> Void {
//        textField.text = text;
//    }
//    
//    public func getText()-> String {
//        return  textField.text;
//    }
//    
//    public func requestFocus() ->Void{
//        textField.becomeFirstResponder();
//    }
//    
//    
//    
//}
