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
    @Published var midicc: [String]
    @Published var isLowerMidi: Bool = true;
    
    init(device: GenericDeviceModel){
        self.device = device
        let modes =  device.getMapperModel().getModeList()
        let selected = device.getMapperModel().getSelectedMode()
        self.selectedModeIndex = modes.firstIndex{$0 === selected}!
        device.getMapperModel().setSelectedMode(mode: selected)
        
        let defaultIsLowerMidi = true;
        self.isLowerMidi = defaultIsLowerMidi;
        let mapperModel = device.getMapperModel()
        var p = mapperModel.getProgram();
        if(defaultIsLowerMidi){
            p -= 1;
        }
        self.program = String(p)
        var s = mapperModel.getSubBank();
        if(defaultIsLowerMidi){
            s -= 1;
        }
        self.subBank = String(s)
        var b = mapperModel.getBank();
        if(defaultIsLowerMidi){
            b -= 1;
        }
        self.bank = String(b)
        self.nordProgram = mapperModel.getCurrentText()
        self.oldNordProgram = mapperModel.getCurrentText()
        self.midicc = loadFile(fileName: device.getMidiCCFileName())
        
    }
    
    
    func normalize(midi: Int) -> Int{
        if(isLowerMidi){
            return midi - 1;
        }
        return midi;
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
    
    /**
     *  Textfeld für Nor-spezifisches Namensschema wie A:11
     */
    var nordTextField : some View{
        HStack(){
            let modes =  vModel.device.getMapperModel().getModeList()
            let defaultText = vModel.device.getMapperModel().getSelectedMode().toDefault();
            TextField(defaultText, text: $vModel.nordProgram).disableAutocorrection(true).padding(.horizontal, 5)
            Picker(selection: $vModel.selectedModeIndex, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                ForEach(0 ..< modes.count) {i in
                    let mode = modes[i];
                    Text(mode.getName()).tag(i)
                }
            }.font(.title2)
        }.padding(8).background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.red, lineWidth: 1))
    }
    
    /**
     * Umschalt Button für MIDI-Darstellung
     */
    var midi127Or128SwitchButton : some View{
        Button(action: {
            vModel.isLowerMidi.toggle()
            updateVModel()
        }){
            Text(getMidiTitle())
        }
    }
    
    var programCalculatorLabel: some View{
        HStack{
            VStack{
                Text("Program Calculator").foregroundColor(Color.gray)
            }
            Spacer()
        }
    }
    
    func midiField(hintText: String, defaultText: String, binding: Binding<String>) -> some View{
        HStack(){
            TextField(defaultText, text: binding).disableAutocorrection(true) .keyboardType(.numberPad).padding(.horizontal, 5)
            Text(hintText).foregroundColor(Color.gray)
        }.padding(9)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray, lineWidth: 1))
    }
    
    var midiControllerButton : some View{
        NavigationLink(destination: MidiCCView( vModel: vModel)) {
            Text("MIDI Controller")
        }
    }
    
    var body: some View {
        
            VStack {
                VStack(alignment: .leading) {
                    programCalculatorLabel
                    nordTextField
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    midi127Or128SwitchButton
                    midiField(hintText: "Bank", defaultText: vModel.getDefaultMidiValue(), binding: $vModel.bank)
                    midiField(hintText: "SubBank", defaultText: vModel.getDefaultMidiValue(), binding: $vModel.subBank)
                    midiField(hintText: "Program", defaultText: vModel.getDefaultMidiValue(), binding: $vModel.program)
                }.padding(.horizontal)
                midiControllerButton
                Spacer()
         }
            .navigationTitle(vModel.device.getName()).navigationBarTitleDisplayMode(.inline)
           
           .onChange(of: vModel.program) { newValue in
               let mapperModel = vModel.device.getMapperModel();
               let mode = mapperModel.getSelectedMode();
               if (!vModel.isLowerMidi && NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setProgram(program: Int(newValue)!);
                   vModel.program = newValue;
               }else if (vModel.isLowerMidi && NordNumberUtil.isNumber0To127(x: newValue)) {
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
                      if(vModel.isLowerMidi){
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
               if (!vModel.isLowerMidi && NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setSubBank(subBank: Int(newValue)!);
                   vModel.subBank = newValue;
               }else if (vModel.isLowerMidi && NordNumberUtil.isNumber0To127(x: newValue)) {
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
               if (!vModel.isLowerMidi && NordNumberUtil.isNumber1To128(x: newValue)) {
                   mapperModel.setBank(bank: Int(newValue)!);
                   vModel.bank = newValue;
                   if(oldValue != Int(newValue)!){
                       updateVModel();
                   }
               }else if (vModel.isLowerMidi && NordNumberUtil.isNumber0To127(x: newValue)) {
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
        if(vModel.isLowerMidi){
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
        if(vModel.isLowerMidi){
            return "Midi (0-127)" ;
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
