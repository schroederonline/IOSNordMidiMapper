//
//  DeviceView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//
import Combine
import SwiftUI

var isLowerMidi: Bool = true;

func normalize(midi: Int) -> Int{
    if(isLowerMidi){
        return midi - 1;
    }
    return midi;
}


class VModel: ObservableObject{
    
    @Published var nordProgram: String
    @Published var oldNordProgram: String
    @Published var program: String
    @Published var subBank: String
    @Published var bank: String
    @Published var device: GenericDeviceModel
    @Published var selectedModeIndex: Int
    @Published var midicc: [String]
    
    init(device: GenericDeviceModel){
        self.device = device
        let modes =  device.getMapperModel().getModeList()
        let selected = device.getMapperModel().getSelectedMode()
        self.selectedModeIndex = modes.firstIndex{$0 === selected}!
        device.getMapperModel().setSelectedMode(mode: selected)
        
        let mapperModel = device.getMapperModel()
        self.program = String(normalize(midi: mapperModel.getProgram()))
        self.subBank = String(normalize(midi: mapperModel.getSubBank()))
        self.bank = String(normalize(midi: mapperModel.getBank()))
        self.nordProgram = mapperModel.getCurrentText()
        self.oldNordProgram = mapperModel.getCurrentText()
        self.midicc = loadFile(fileName: device.getMidiCCFileName())
        
    }
    
    func getDefaultMidiValue() -> String {
        if(isLowerMidi){
            return "0";
        }
        return "1";
    }
    
    
}

func loadFile(fileName: String) -> [String]{
    let name = fileName.substring(fromIndex: 0, toIndex: fileName.length()-4);
    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            let contents = try? String(contentsOfFile: filepath)
       return  contents!.split(separatedBy: "\n")
    } else {
        return [];// not found!
    }
}

struct DeviceView: View {
    
    @StateObject var vModel: VModel;
    
    var body: some View {
        
            VStack {
                VStack(alignment: .leading) {
                    HStack{
                        VStack{
                            Text("Program Calculator").foregroundColor(Color.gray)
                        }
                        Spacer()
                    }
                    
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
                    Text(getMidiTitle()).foregroundColor(Color.gray)
                    HStack(){
                        TextField(vModel.getDefaultMidiValue(), text: $vModel.bank).disableAutocorrection(true) .keyboardType(.numberPad)
                        Text("Bank").foregroundColor(Color.gray)
                    }.padding(9)
                        .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                    HStack(){
                        TextField(vModel.getDefaultMidiValue(), text: $vModel.subBank).disableAutocorrection(true).keyboardType(.numberPad)
                        Text("SubBank").foregroundColor(Color.gray)
                    }.padding(9)
                        .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                     .stroke(Color.gray, lineWidth: 1)
                                )
                    HStack(){
                        TextField(vModel.getDefaultMidiValue(), text: $vModel.program).disableAutocorrection(true).keyboardType(.numberPad)
                        Text("Program").foregroundColor(Color.gray)
                    }.padding(9)
                        .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                }.padding(.horizontal)
                NavigationLink(destination: MidiCCView( vModel: vModel)) {
                    Text("MIDI Controller")
                }
                Spacer()
         }
            .navigationTitle(vModel.device.getName()).navigationBarTitleDisplayMode(.inline)
           
           .onChange(of: vModel.program) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               if (!isLowerMidi && NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setProgram(program: Int(newValue)!);
                   vModel.program = newValue;
               }else if (isLowerMidi && NordNumberUtil.isNumber0To127(x: newValue)) {
                   mapperModel.setProgram(program: (Int(newValue)! + 1) );
                   vModel.program = newValue;
               } else {
                   vModel.program = "";
               }
                vModel.nordProgram = mode.getCurrentText();
           }
           .onChange(of: vModel.nordProgram) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               let oldValue  = vModel.oldNordProgram;
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
                      let p = mapperModel.getProgram();
                      if(isLowerMidi){
                          vModel.program = String(p - 1)
                      }else{
                          vModel.program = String(p)
                      }
                      
                      if(newValue.length() > 0){
                          vModel.nordProgram = result
                      }
                  }
              }
           }.onChange(of: vModel.subBank) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               if (!isLowerMidi && NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setSubBank(subBank: Int(newValue)!);
                   vModel.subBank = newValue;
               }else if (isLowerMidi && NordNumberUtil.isNumber0To127(x: newValue)) {
                   mapperModel.setSubBank(subBank: (Int(newValue)! + 1));
                   vModel.subBank = newValue;
               }else {
                   vModel.subBank = "";
               }
               vModel.nordProgram = mode.getCurrentText();
           }.onChange(of: vModel.bank) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               let oldValue = mapperModel.getBank();
               if (!isLowerMidi && NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setBank(bank: Int(newValue)!);
                   vModel.bank = newValue;
                   if(oldValue != Int(newValue)!){
                       updateVModel();
                   }
               }else if (isLowerMidi && NordNumberUtil.isNumber0To127(x: newValue)) {
                   mapperModel.setBank(bank: (Int(newValue)! + 1));
                   vModel.bank = newValue;
                   if(oldValue != (Int(newValue)! + 1)){
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
        if(isLowerMidi){
            vModel.program = String(vModel.device.getMapperModel().getProgram() - 1)
            vModel.subBank = String(vModel.device.getMapperModel().getSubBank() - 1)
            vModel.bank = String(vModel.device.getMapperModel().getBank() - 1)
        }else{
            vModel.program = String(vModel.device.getMapperModel().getProgram())
            vModel.subBank = String(vModel.device.getMapperModel().getSubBank())
            vModel.bank = String(vModel.device.getMapperModel().getBank())
        }
        
   
        let modes =  vModel.device.getMapperModel().getModeList();
        let selected = vModel.device.getMapperModel().getSelectedMode()
        vModel.selectedModeIndex = modes.firstIndex{$0 === selected}!
    }
    
    func getMidiTitle() -> String {
        if(isLowerMidi){
            return "Midi (1-127)" ;
        }
        return "Midi (1-128)" ;
    }
}


struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        let m = NordStage3Node();
        DeviceView(vModel: VModel( device: m))
    }
}
