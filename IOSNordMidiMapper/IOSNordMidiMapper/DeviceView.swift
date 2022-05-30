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
                       let modes =  self.device.getMapperModel().getModeList();
                       NordTextFieldImpl( mapperModel: self.mapperModelNord);
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
                   Text("")
                   Text("")
                   
                   HStack(){
                       MidiTextFieldBank(midiModel: self.device.getMapperModel())
                       Text("Bank").font(.title2)
                   }
                   Text("")
                   Text("")
                   
                   HStack(){
                       MidiTextFieldSubBank(midiModel: self.device.getMapperModel())
                       Text("SubBank").font(.title2)
                   }
                   Text("")
                   Text("")
                   HStack(){
                       MidiTextFieldProgram(midiModel: self.device.getMapperModel())
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



struct NordTextFieldImpl: View{
    @StateObject var model: TextFieldViewModel;
    var hintText = "";
    public init(mapperModel: MapperModelNord){
       self._model = StateObject(wrappedValue: TextFieldViewModel( mapperModel: mapperModel));
       let selectedMode = mapperModel.getSelectedMode();
        self.hintText = selectedMode.toDefault();
   }

    var body: some View {
        TextField(hintText, text: $model.text).font(.title2)
    }
}

public class TextFieldViewModel: ObservableObject{
    @Published var text = "";
    private var cancels = Set<AnyCancellable>();
    
    init(mapperModel: MapperModelNord ){
        $text.sink { (newValue) in
            print(newValue)
            let result = mapperModel.getSelectedMode().onTextChanged(oldValue: mapperModel.getSelectedMode().getCurrentText(), newValue: newValue);
            if(result != nil){
                print("setNordProgram " + result!)
                mapperModel.getSelectedMode().setNordProgram(s: result!);
            }
        }.store(in: &cancels)
    }
}

struct MidiTextFieldBank: View{
    @StateObject var bankModel: BankTextFieldViewModel;
    var hintText = "";
    public init(midiModel: MidiModel){
       self._bankModel = StateObject(wrappedValue: BankTextFieldViewModel( midiModel: midiModel));
        self.hintText = String( midiModel.getBank());
   }
    var body: some View {
        TextField(hintText, text: $bankModel.text).font(.title2).keyboardType(.numberPad)
    }
}

public class BankTextFieldViewModel: ObservableObject{
    @Published var text = "";
    private var cancels = Set<AnyCancellable>();
    init(midiModel: MidiModel ){
        $text.sink { (newValue) in
            print("New Bank Value" + newValue)
        }.store(in: &cancels)
    }
}


struct MidiTextFieldSubBank: View{
    @StateObject var subBankModel: SubBankTextFieldViewModel;
    var hintText = "";
    public init(midiModel: MidiModel){
       self._subBankModel = StateObject(wrappedValue: SubBankTextFieldViewModel( midiModel: midiModel));
        self.hintText = String( midiModel.getSubBank());
   }
    var body: some View {
        TextField(hintText, text: $subBankModel.text).font(.title2).keyboardType(.numberPad)
    }
}

public class SubBankTextFieldViewModel: ObservableObject{
    @Published var text = "";
    private var cancels = Set<AnyCancellable>();
    init(midiModel: MidiModel ){
        $text.sink { (newValue) in
            print("New SubBank Value" + newValue)
        }.store(in: &cancels)
    }
}

struct MidiTextFieldProgram: View{
    @StateObject var programModel: ProgramTextFieldViewModel;
    var hintText = "";
    public init(midiModel: MidiModel){
       self._programModel = StateObject(wrappedValue: ProgramTextFieldViewModel( midiModel: midiModel));
        self.hintText = String( midiModel.getProgram());
   }
    var body: some View {
        TextField(hintText, text: $programModel.text).font(.title2).keyboardType(.numberPad)
    }
}

public class ProgramTextFieldViewModel: ObservableObject{
    @Published var text = "";
    private var cancels = Set<AnyCancellable>();
    init(midiModel: MidiModel ){
        $text.sink { (newValue) in
            print("New Program Value" + newValue)
        }.store(in: &cancels)
    }
}


