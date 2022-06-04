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
    @Published var device: GenericDeviceModel;
    
    init(device: GenericDeviceModel){
        self.device = device;
        self.program = String(device.getMapperModel().getProgram());
        self.nordProgram = device.getMapperModel().getCurrentText()
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
                       let modes =  vModel.device.getMapperModel().getModeList();
                       TextField("1", text: $vModel.nordProgram)
                       
                       Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                           ForEach(0 ..< modes.count) {
                               let mode = modes[$0];
                               Text(mode.getName()).tag($0)
                           }
//                           Text("Song Mode").tag(2)
//                           Text("Live Mode").tag(3)
                       }.font(.title2)
                          
                   }
                   Text("")
                   Text("")
                   Divider()
               }.padding()
               
               
               VStack(alignment: .leading) {
                   
                   Text("Midi (1-128)" ).foregroundColor(Color.gray)
                   
                   HStack(){
                       //FIXME
                       TextField("bank", text: $vModel.nordProgram)
                       Text("Bank").font(.title2)
                   }
                   HStack(){
                       //FIXME
                       TextField("SubBank", text: $vModel.nordProgram)
                       Text("SubBank").font(.title2)
                   }
                   HStack(){
                       TextField("1", text: $vModel.program);
                       Text("Program").font(.title2)
                   }
                   
               }.padding()
             
               Spacer()
           }.onChange(of: vModel.nordProgram) { newValue in
               let mapperMode = vModel.device.getMapperModel();
               let mode = mapperMode.getSelectedMode();
               let oldValue  = mode.getCurrentText();
               print("newValue = " + newValue)
               print("oldValue = " + oldValue)
              if(newValue != oldValue){
                 let result = mode.onNordProgramTextChanged(oldValue: oldValue, newValue: newValue);
//                  mode.setNordProgram(s: newValue)
                  let changed =  result != oldValue || result != newValue;
                 // let changed = mode.setCurrentText(currentText: newValue)
                  print("changed = " + String(changed))
                  if(changed){
                      //mapperMode.updateMidiToWhatEver()
                      let next = result;
//                      if(next != oldValue){
                          let p =  String( mapperMode.getProgram());
                          print("p = " + p)
                          if(newValue.length() > 0){
                              print("nordProgram next " + next)
                              vModel.nordProgram = next
                          }
                          vModel.program = String(mapperMode.getProgram())
//                      }
                  }
              }
           }.onChange(of: vModel.program) { newValue in
               print("program changed " + newValue)
           }
        
       }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        let m = NordStage3Node();
        DeviceView(vModel: VModel( device: m))
    }
}
