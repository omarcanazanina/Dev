//
//  FormDataQrView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI

struct FormDataQrView: View {
    @ObservedObject var userDataVM = UserDataViewModel()
    @ObservedObject var qrPaymentVM = QrPaymentViewModel()
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
        VStack{
            if self.type == "Seleccionar" || self.expiration == "Seleccionar" || self.money == "Seleccionar" || self.monto == ""{
                Button(action: {
                    print(self.type)
                    print(self.expiration)
                    print(self.money)
                    print(self.monto)
               
                }){
                    Text("Generar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .padding()
                    
                    /*NavigationLink(destination: QrChargeView(dataUserlog: self.userDataVM.user, dataString: ""), tag: 1, selection: self.$action) {
                        EmptyView()
                    }*/
                }.disabled(true)
                .opacity(0.5)
            }else{
                Button(action: {
                    print(self.type)
                    print(self.expiration)
                    print(self.money)
                    print(self.monto)
                    self.action = 1
                    self.qrPaymentVM.generateQrData(tipocobro: self.type, vencimiento: "2021-10-04T02:42:52.226Z", tipomoneda: self.money, monto: self.monto, descripcion: self.descripcion)
                }){
                    Text("Generar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .padding()
                    
                    NavigationLink(destination: QrChargeView(dataQr: self.qrPaymentVM.generateQr, montoQr: self.monto) , tag: 1, selection: self.$action) {
                        EmptyView()
                    }
                }.disabled(false)
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
           /* HStack(){
                VStack(){
                    Text("Vencimiento")
                        .textStyle(TitleStyle())
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Button(action: {
                        self.action = 44
                       // self.qrPayment.obtenerQr(id_qr: "6160b6502319e611418d95b5")
                    }){
                        Text("v")
                    }.frame(maxWidth:.infinity, alignment: .leading)
                }.frame(maxWidth:.infinity, alignment: .leading)
                NavigationLink(destination: CalendarView(), tag: 44, selection: self.$action) {
                     EmptyView()
                 }
                Spacer()
                VStack(){
                    Text("50.00 Bs.")
                }
            }.padding()*/
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
                    .keyboardType(.numberPad)
                    .introspectTextField { (textField) in
                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                        let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                     doneButton.tintColor = .darkGray
                        toolBar.items = [flexButton, doneButton]
                        toolBar.setItems([flexButton, doneButton], animated: true)
                        textField.inputAccessoryView = toolBar
                     }
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
        }.navigationBarTitle(Text("Cobro"), displayMode: .inline)
        
    }
}

struct FormDataQrView_Previews: PreviewProvider {
    static var previews: some View {
        FormDataQrView()
    }
}
