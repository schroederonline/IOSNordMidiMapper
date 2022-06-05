//
//  DeviceView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//
import Combine
import SwiftUI


class VModel: ObservableObject{
    
    @Published var nordProgram: String ;
    @Published var program: String;
    @Published var subBank: String;
    @Published var bank: String;
    @Published var device: GenericDeviceModel;
    @Published var selectedModeIndex: Int;
    @Published var selectedMode: Mode;
   
    
    init(device: GenericDeviceModel){
        self.device = device;
        let mapperModel = device.getMapperModel();
        self.program = String(mapperModel.getProgram());
        self.subBank = String(mapperModel.getSubBank());
        self.bank = String(mapperModel.getBank());
        self.nordProgram = mapperModel.getCurrentText()
        
        let modes =  device.getMapperModel().getModeList();
        let selected = device.getMapperModel().getSelectedMode()
        self.selectedModeIndex = modes.firstIndex{$0 === selected}!
        selectedMode = selected;
        
    }
    
}


struct DeviceView: View {
    
    @StateObject var vModel: VModel;
    
    var body: some View {
           VStack {
               VStack(alignment: .leading) {
                   Text(vModel.device.getName())
                       .font(.title)
                   Text("Program Calculator").foregroundColor(Color.gray)
                   Text("")
                   Text("")
                   HStack(){
                       let modes =  vModel.device.getMapperModel().getModeList()
                       TextField("1", text: $vModel.nordProgram)
                       Picker(selection: $vModel.selectedModeIndex, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                           ForEach(0 ..< modes.count) {i in
                               let mode = modes[i];
                               Text(mode.getName()).tag(i)
                           }
                       }.font(.title2)
                       
                          
                   }
                   Text("")
                   Text("")
                   Divider()
               }.padding()
               VStack(alignment: .leading) {
                   Text("Midi (1-128)" ).foregroundColor(Color.gray)
                   HStack(){
                       TextField("bank", text: $vModel.bank)
                       Text("Bank").font(.title2)
                   }
                   HStack(){
                       TextField("SubBank", text: $vModel.subBank)
                       Text("SubBank").font(.title2)
                   }
                   HStack(){
                       TextField("1", text: $vModel.program);
                       Text("Program").font(.title2)
                   }
               }.padding()
               Spacer()
           }.onChange(of: vModel.nordProgram) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               let oldValue  = mode.getCurrentText();
              if(newValue != oldValue){
                  let result = mode.onNordProgramTextChanged(oldValue: oldValue, newValue: newValue);
                  let changed =  result != oldValue || result != newValue;
                  if(changed){
                      if(newValue.length() > 0){
                          vModel.nordProgram = result
                      }
                      vModel.program = String(mapperModel.getProgram())
                  }
              }
           }.onChange(of: vModel.program) { newValue in
//               print("program changed " + newValue)
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               if (NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setProgram(program: Int(newValue)!);
                   vModel.program = newValue;
               } else {
                   vModel.program = "";
               }
               vModel.nordProgram = mode.getCurrentText();
           }.onChange(of: vModel.selectedModeIndex) { newValue in
               print("vModel.selectedModeIndex changed " + String(newValue))
               let modes =  vModel.device.getMapperModel().getModeList()
               let nextMode = modes[newValue]
               print("nextMode " + String(nextMode.getName()))
               
               vModel.device.getMapperModel().setSelectedMode(mode: nextMode)
               vModel.nordProgram = nextMode.getCurrentText();
               vModel.program = String( vModel.device.getMapperModel().getProgram())
               
           }
        
       }
    
    
    
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        let m = NordStage3Node();
        DeviceView(vModel: VModel( device: m))
    }
}
