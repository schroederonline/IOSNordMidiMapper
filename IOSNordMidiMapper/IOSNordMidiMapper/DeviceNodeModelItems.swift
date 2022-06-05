//
//  DeviceNodeModelItems.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 28.05.22.
//

import Foundation

public class DeviceNodeModelItems {
    
    private let allDeviceModels :Array<GenericDeviceModel>  = [NordStage3Node(),
                                                               NordStage2Node(),
                                                               NordStage2EXNode(),
                                                               NordElectro6Node(),
                                                               NordElectro5Node(),
                                                               NordGrandNode(),
                                                               NordWave2Node(),
                                                               NordWaveNode(),
                                                               NordPiano5Node()
                                                               

    ];
//    FIXME
//            .asList(new NordStage3Node(), new NordStage2Node(), new NordElectro6Node(), new NordElectro5Node(),
//                    new NordElectro4Node(), new NordLeadA1Node(), new NordLead4Node(), new NordWave2Node(),
//                    new NordWaveNode(), new NordGrandNode(), new NordPiano4Node(), new NordPiano5Node(), new NordStage2EXNode(),
//                    new NordPiano3Node())
//            .stream().sorted(Comparator.comparing(GenericDeviceModel::getName)).collect(Collectors.toList());
//    private final ObservableList<DeviceNodeModel> items = FXCollections.observableArrayList();
//    private static final String propertyKey = "devices";

    public init(
//        Settings settings
    ) {
//        String devices = settings.getStringValue(propertyKey, "");
//        items.addAll(fromString(devices));
//        items.addListener(new ListChangeListener<DeviceNodeModel>() {
//
//            @Override
//            public void onChanged(Change<? extends DeviceNodeModel> c) {
//                String s = toStringValue(items);
//                settings.setStringValue(propertyKey, s);
//            }
//        });
    }

    public func getAvailableDeviceModels() -> Array<GenericDeviceModel>{
        return allDeviceModels;
    }

//    public ObservableList<DeviceNodeModel> getItems() {
//        return items;
//    }

//    private func toStringValue( devs: Array<GenericDeviceModel>) -> String{
//        StringBuilder sb = new StringBuilder("");
//        for (String name : devs.stream().map(DeviceNodeModel::getName).collect(Collectors.toList())) {
//            sb.append(name).append(",");
//        }
//        String s = sb.toString();
//        if (s.endsWith(",")) {
//            s = s.substring(0, s.length() - 1);
//        }
//        return s;
//
//    }

//    private List<DeviceNodeModel> fromString(String s) {
//        String[] split = s.split(",");
//        return Arrays.asList(split).stream()
//                .map(name -> allDeviceModels.stream().filter(d -> d.getName().equals(name)).findFirst().orElse(null))
//                .filter(Objects::nonNull).collect(Collectors.toList());
//    }

}
