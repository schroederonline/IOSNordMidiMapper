//
//  DeviceView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//
import Combine
import SwiftUI


class VModel: ObservableObject{
    
    @Published var nordProgram: String
    @Published var oldNordProgram: String
    @Published var program: String
    @Published var subBank: String
    @Published var bank: String
    @Published var device: GenericDeviceModel
    @Published var selectedModeIndex: Int
    
    @Published var midicc: String
   
    
    init(device: GenericDeviceModel){
        self.device = device
        let modes =  device.getMapperModel().getModeList()
        let selected = device.getMapperModel().getSelectedMode()
        print("selected " + selected.getName())
        self.selectedModeIndex = modes.firstIndex{$0 === selected}!
        device.getMapperModel().setSelectedMode(mode: selected)
        
        let mapperModel = device.getMapperModel()
        self.program = String(mapperModel.getProgram())
        self.subBank = String(mapperModel.getSubBank())
        self.bank = String(mapperModel.getBank())
        self.nordProgram = mapperModel.getCurrentText()
        self.oldNordProgram = mapperModel.getCurrentText()
        self.midicc = loadFile(fileName: device.getMidiCCFileName())
        
    }
    
}

func loadFile(fileName: String) -> String{
    let x = fileName.substring(fromIndex: 0, toIndex: fileName.length()-4);
    if let filepath = Bundle.main.path(forResource: x, ofType: "txt") {
            let contents = try? String(contentsOfFile: filepath)
            print(contents)
        return contents!;
    } else {
        // example.txt not found!
        return   " not found";
    }
    
}


struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct DeviceView: View {
    
    @StateObject var vModel: VModel;
    
    var body: some View {
           VStack {
               VStack(alignment: .leading) {
                   Text(vModel.device.getName())
                       .font(.title2)
                   Text("Program Calculator").foregroundColor(Color.gray)
                   HStack(){
                       let modes =  vModel.device.getMapperModel().getModeList()
                       let defaultText = vModel.device.getMapperModel().getSelectedMode().toDefault();
                       TextField(defaultText, text: $vModel.nordProgram).disableAutocorrection(true)
                       Picker(selection: $vModel.selectedModeIndex, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                           ForEach(0 ..< modes.count) {i in
                               let mode = modes[i];
                               Text(mode.getName()).tag(i)
                           }
                       }.font(.title2)
                   }.padding(9)
                       .background(
                                   RoundedRectangle(cornerRadius: 10, style: .continuous)
                                       .stroke(Color.red, lineWidth: 1)
                               )
               }.padding(.horizontal)
               VStack(alignment: .leading) {
                   Text("Midi (1-128)" ).foregroundColor(Color.gray)
                   HStack(){
                       TextField("1", text: $vModel.bank).disableAutocorrection(true) .keyboardType(.numberPad)
                       Text("Bank").foregroundColor(Color.gray)
                   }.padding(9)
                       .background(
                                   RoundedRectangle(cornerRadius: 10, style: .continuous)
                                       .stroke(Color.gray, lineWidth: 1)
                               )
                   HStack(){
                       TextField("1", text: $vModel.subBank).disableAutocorrection(true).keyboardType(.numberPad)
                       Text("SubBank").foregroundColor(Color.gray)
                   }.padding(9)
                       .background(
                                   RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color.gray, lineWidth: 1)
                               )
                   HStack(){
                       TextField("1", text: $vModel.program).disableAutocorrection(true).keyboardType(.numberPad)
                       Text("Program").foregroundColor(Color.gray)
                   }.padding(9)
                       .background(
                                   RoundedRectangle(cornerRadius: 10, style: .continuous)
                                       .stroke(Color.gray, lineWidth: 1)
                               )
               }.padding(.horizontal)
               Spacer()
               
               MidiCCView(vModel: vModel)
           }
           .onChange(of: vModel.program) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               if (NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setProgram(program: Int(newValue)!);
                   vModel.program = newValue;
               } else {
                   vModel.program = "";
               }
               if( mode.getCurrentText() != mode.toDefault()){
                   vModel.nordProgram = mode.getCurrentText();
               }
           }
           .onChange(of: vModel.nordProgram) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               let oldValue  = vModel.oldNordProgram;// mode.getCurrentText();
              if(newValue != oldValue){
                  let result = mode.onNordProgramTextChanged(oldValue: oldValue, newValue: newValue)
                  let changed =  result != oldValue
                  vModel.oldNordProgram = result
                  vModel.nordProgram = result
                  if(changed){
                      mode.setNordProgram(s: result)
                      if(mode.getCurrentText() != oldValue){
                            updateVModel()
                      }
                      vModel.program = String(mapperModel.getProgram())
                      if(newValue.length() > 0){
                          vModel.nordProgram = result
                      }
                  }
              }
           }.onChange(of: vModel.subBank) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               if (NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setSubBank(subBank: Int(newValue)!);
                   vModel.subBank = newValue;
               } else {
                   vModel.subBank = "";
               }
               vModel.nordProgram = mode.getCurrentText();
           }.onChange(of: vModel.bank) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               let oldValue = mapperModel.getBank();
               if (NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setBank(bank: Int(newValue)!);
                   vModel.bank = newValue;
                   if(oldValue != Int(newValue)!){
                       updateVModel();
                   }
               } else {
                   vModel.bank = "";
               }
               vModel.nordProgram = mode.getCurrentText();
           }.onChange(of: vModel.selectedModeIndex) { newValue in
               let modes =  vModel.device.getMapperModel().getModeList()
               let nextMode = modes[newValue]
               vModel.device.getMapperModel().setSelectedMode(mode: nextMode)
               updateVModel()
           }
       }
    
    
    func updateVModel() ->Void{
        vModel.program = String(vModel.device.getMapperModel().getProgram())
        vModel.subBank = String(vModel.device.getMapperModel().getSubBank())
        vModel.bank = String(vModel.device.getMapperModel().getBank())
        let modes =  vModel.device.getMapperModel().getModeList();
        let selected = vModel.device.getMapperModel().getSelectedMode()
        vModel.selectedModeIndex = modes.firstIndex{$0 === selected}!
    }
}


struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        let m = NordStage3Node();
        DeviceView(vModel: VModel( device: m))
    }
}
