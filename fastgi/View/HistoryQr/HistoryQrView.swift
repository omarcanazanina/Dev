//
//  HistoryQrView.swift
//  fastgi
//
//  Created by Hegaro on 27/09/2021.
//

import SwiftUI

struct HistoryQrView: View {
    
    @State private var optionPicker:Int = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColorPrimary()
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var listCobros:some View{
        VStack{
            
                Button(action: {
                    
                })
                {
                    HStack(){
                        VStack(){
                            Text("Cobro")
                                .opacity(0.8)
                                .font(.caption)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            Text("Unico uso")
                                .font(.caption)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            Text("14/09/2020 16:50")
                                .frame(maxWidth:.infinity, alignment: .leading)
                        }.frame(maxWidth:.infinity, alignment: .leading)
                        Spacer()
                        VStack(){
                            Text("50.00 Bs.")
                        }
                    }
                }
                Button(action: {
                    
                })
                {
                    HStack(){
                        VStack(){
                            Text("Cobro")
                                .opacity(0.8)
                                .font(.caption)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            Text("Un mes")
                                .font(.caption)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            Text("18/09/2021 18:20")
                                .frame(maxWidth:.infinity, alignment: .leading)
                        }.frame(maxWidth:.infinity, alignment: .leading)
                        Spacer()
                        VStack(){
                            Text("100.00 Bs.")
                        }
                    }
                }
            
            
            
        }
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                Picker(selection: $optionPicker, label: Text("")) {
                    Text("Cobros").tag(0)
                    Text("Pagos").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                if(optionPicker==0){
                    self.listCobros
                    
                }
                if(optionPicker==1){
                    Text("list pagos")
                    
                }
            }.navigationBarTitle(Text("Movimientos"), displayMode: .inline)
        }
    }
}

struct HistoryQrView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryQrView()
    }
}
