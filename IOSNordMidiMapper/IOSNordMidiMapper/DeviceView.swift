//
//  DeviceView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//
import Combine
import SwiftUI

struct DeviceView: View {
    
    @State private var device: GenericDeviceModel;
    @State private var mapperModelNord: MapperModelNord;
    
    @State private var selectedModeIndex = 0
    
    
    
    init(device: GenericDeviceModel){
        self.device = device;
        self.mapperModelNord = device.getMapperModel();
    }
    
    var body: some View {
           VStack {
              

               VStack(alignment: .leading) {
                   Text(self.device.getName())
                       .font(.title)

                   
                   Text("Program Calculator").foregroundColor(Color.gray)
                   Text("")
                   Text("")
                   HStack(){
                       
                       let selectedMode = self.device.getMapperModel().getSelectedMode();
                       let hintText = selectedMode.toDefault();
                       let value = selectedMode.getCurrentText();
                      
//                       self.device.getNordTextfield();
                       let modes =  self.device.getMapperModel().getModeList();
//                       TextFieldImpl(mapperModel: self.device.getMapperModel());
                     
                       
                       NordTextFieldImpl( mapperModel: self.mapperModelNord);
                       Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                           
                           ForEach(0 ..< modes.count) {
                               let mode = modes[$0];
                               Text(mode.getName()).tag($0)
                           }
                           
                           
//                           Text("Song Mode").tag(2)
//                           Text("Live Mode").tag(3)
                       }.font(.title2)
                       
//                           .onChange(of:$selectedModeIndex.property, perform: { [oldValue = $selectedModeIndex.property] newValue in
//                           print("Old value was \(oldValue), new value is \(newValue)")
//                         }
                           
                           
//                           .onChange(of: selectedModeIndex) { newValue in
//                           self.device.getMapperModel().setSelectedMode(mode:  modes[newValue]);
//                           selectedModeIndex = newValue;
//                       }
                          
                   }
                   Text("")
                   Text("")
                   Divider()
               }.padding()
               
               
               VStack(alignment: .leading) {
                   
                   Text("Midi (1-128)" ).foregroundColor(Color.gray)
                   Text("")
                   Text("")
                   
                   HStack(){
                       TextField("1", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Text("Bank").font(.title2)
                   }
                   Text("")
                   Text("")
                   
                   HStack(){
                       TextField("1", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Text("SubBank").font(.title2)
                   }
                   Text("")
                   Text("")
                   HStack(){
                       TextField("1", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Text("Program").font(.title2)
                   }
                   
               }.padding()
             
               

               Spacer()
           }
       }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(device :NordStage3Node())
    }
}


//struct TextFieldImpl: View, TextFieldInterface {
//    @StateObject var model = TextFieldViewModel();
//    private let  mapperModel: MapperModelNord;
//
//    public init(mapperModel: MapperModelNord){
//        self.mapperModel = mapperModel;
//        model.setTextFieldImpl(textFieldImpl: self);
//        let selectedMode = mapperModel.getSelectedMode();
//        let hintText = selectedMode.toDefault();
//        model.hintText = hintText;
//        let value = selectedMode.getCurrentText();
//        setText(text: value);
//    }
//
//    var body: some View {
//        TextField(getHintText(), text: $model.text).font(.title2)
//    }
//
//    public func clear() -> Void{
//        model.text = "";
//    }
//    public func setPromptText(promtText : String) -> Void{
//        model.hintText = promtText;
//    }
//
//    public func setText (text: String) -> Void {
//        let next = mapperModel.getSelectedMode().onTextChanged(oldValue: model.text, newValue: text)
//        if(next != nil){
//            model.text = text;
//            print("I need to set the Program " + text)
//        }
//
//
//    }
//
//    public func getHintText()->String{
//        return model.hintText;
//    }
//    public func getText() ->String{
//        return model.text;
//    }
//
//
//}

struct NordTextFieldImpl: View{
    
    @StateObject var model: TextFieldViewModel;

       public init(mapperModel: MapperModelNord){
           self._model = StateObject(wrappedValue: TextFieldViewModel( mapperModel: mapperModel));
//           model = TextFieldViewModel(mapperModel: mapperModel);
           let selectedMode = mapperModel.getSelectedMode();
           let hintText = selectedMode.toDefault();
           model.hintText = hintText;
           let value = selectedMode.getCurrentText();
//           setText(text: value);
       }
    
        var body: some View {
            TextField("hintText", text: $model.text).font(.title2)
        }
}


public class TextFieldViewModel: ObservableObject{
    @Published var text = "";
    @Published var hintText:String = "";
    private var cancels = Set<AnyCancellable>();
    
    init(mapperModel: MapperModelNord ){
        $text.sink { (newValue) in
            print(newValue)
            let result = mapperModel.getSelectedMode().onTextChanged(oldValue: mapperModel.getSelectedMode().getCurrentText(), newValue: newValue);
            
            if(result != nil){
//                fixme setNordProgram
//                TODO auch prüfen ob es der richtige Mode ist
                print("setNordProgram " + result!)
                mapperModel.getSelectedMode().setNordProgram(s: result!);
                
            }
        
            

        }.store(in: &cancels)
    }
}
