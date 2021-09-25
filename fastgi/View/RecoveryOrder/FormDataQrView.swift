//
//  FormDataQrView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI

struct FormDataQrView: View {
    @ObservedObject var userDataVM = UserDataViewModel()
    @State var showingSheetType = false
    @State var type: String = "Seleccionar"
    @State var showingSheetExpiration = false
    @State var expiration: String = "Seleccionar"
    @State var showingSheetMoney = false
    @State var money: String = "Seleccionar"
    @State private  var monto = ""
    @State private  var descripcion = ""
    @State private var action:Int? = 0
    
    init(){
        self.userDataVM.DatosUser()
    }
    
    var pickerTypeCobro: some View{
        Button(action: {
            self.showingSheetType.toggle()
        }) {
            HStack{
                Text(self.type)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetType) {
            CollectionTypeListView(
                showingSheet: self.$showingSheetType,
                card: self.$type)
        }
    }
    
    var pickerVencimiento: some View{
        Button(action: {
            self.showingSheetExpiration.toggle()
        }) {
            HStack{
                Text(self.expiration)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetExpiration) {
            ListExpirationView(
                showingSheet: self.$showingSheetExpiration,
                card: self.$expiration)
        }
    }
    
    var pickerMoney: some View{
        Button(action: {
            self.showingSheetMoney.toggle()
        }) {
            HStack{
                Text(self.money)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetMoney) {
            ListMoneyView(
                showingSheet: self.$showingSheetMoney,
                card: self.$money)
        }
    }
    
    var buttonSuccess: some View{
            Button(action: {
                print(self.type)
                print(self.expiration)
                print(self.money)
                print(self.monto)
                self.action = 1
            }){
                Text("Generar")
                .foregroundColor(Color.white)
                .frame(maxWidth:.infinity)
                .padding(8)
                .background(Color("primary"))
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                .padding()
                NavigationLink(destination: QrChargeView(dataUserlog: self.userDataVM.user, dataString: ""), tag: 1, selection: self.$action) {
                    EmptyView()
                }
            }
    }
    var body: some View {
        ScrollView{
            VStack (alignment: .leading){
                Text("Tipo de Cobro")
                    .textStyle(TitleStyle())
                self.pickerTypeCobro
            }.padding()
            VStack (alignment: .leading){
                Text("Vencimiento")
                    .textStyle(TitleStyle())
                self.pickerVencimiento
            }.padding()
            VStack (alignment: .leading){
                Text("Moneda")
                    .textStyle(TitleStyle())
                self.pickerMoney
            }.padding()
         
            VStack(alignment: .leading, spacing: 8){
                Text("Monto")
                    .textStyle(TitleStyle())
                TextField("Ingrese el monto", text:  $monto)
                .textFieldStyle(Input())
            }.padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Descripción")
                    .textStyle(TitleStyle())
                TextField("Ingrese la descripción", text:  $descripcion)
                .textFieldStyle(Input())
            }.padding(.horizontal)
            VStack{
                self.buttonSuccess
            }
        }
        
    }
}

struct FormDataQrView_Previews: PreviewProvider {
    static var previews: some View {
        FormDataQrView()
    }
}
