//
//  HomeView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import Introspect
//lectorqr
import CodeScanner
import Foundation
import UIKit
struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var navigationRoot = NavigationRoot()
   
       @ObservedObject var login = Login()
       @ObservedObject var loginVM = LoginViewModel()
       @Binding var currentBtnEm: BtnEm
       //pagoQR
       @ObservedObject var qrPayment = QrPayment()
       @ObservedObject var qrPaymentVM = QrPaymentViewModel()
       @ObservedObject var userData = UserData()
       @ObservedObject var userDataVM = UserDataViewModel()
       @ObservedObject var contactsVM = ContactsViewModel()
       //lector qr
       @State private var showScannerTeleferico = false
       @State private var showScannerTransporte = false
       @State private var showScannerScan = false
       @State private var resultado = ""
       @State private var resultadosScan = ""
       //lector con monto
       @State private var idconmonto = ""
       @State private var montoQR = ""
       
       @State private var action:Int? = 0
     //lector modulo PAGO con monto
       @State private var montoPagoQR = ""
       @State private var montoCobroQR = ""
       //modal test
       @State private var showScannerTransporte1 = false
       @State var modal = false
     
       //calendar
       //@State private var birthdate = Date()
    
       // compartir img
       @State var items : [Any] = []
       @State var sheet = false
    
    @State var alertState: Bool = false
    
   
    //test de recuperar nro recien intalado la app
    //@ObservedObject var updateVM = UpdateUserViewModel()
    
   // @State private var dataUserLog = UpdateUserModel(role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "", apellidos: "", correo: "", direccion: "", nit: "", nombrenit: "", nombres: "", ci: "")
    //alert
   /* @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false*/
    
    init(currentBtnEm: Binding<BtnEm>) {
        self._currentBtnEm = currentBtnEm
       //self.telefono = Telefono
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        //self.contactsVM.getContacts()
        self.userDataVM.DatosUser()

        //print("init del home \(self.userDataVM.user._id)")
        /*self.updateVM.updateUser(ci: self.userDataVM.user.ci, correo: self.userDataVM.user.correo, nombres: self.userDataVM.user.nombres, apellidos: self.userDataVM.user.apellidos, direccion: self.userDataVM.user.direccion, nombrenit: self.userDataVM.user.nombrenit, nit: self.userDataVM.user.nit)*/
        //self.userDataVM.DatosUser()
    }
    
    /*var btnTeleferic:some View{
        Button(action: {
            self.showScannerTeleferico = true
        }){
            VStack{
                Image("Mi_teleferico")
                    .resizable()
                    .frame(width:80, height: 80)
                    .padding(10)
            }
            .background(Color("card"))
            .cornerRadius(10)
            .frame(maxWidth:.infinity)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
        }
        //.background(Color.red.opacity(0.5))
        .sheet(isPresented: self.$showScannerTeleferico) {
            CodeScannerView(codeTypes: [.qr]){ result in
                switch result {
                case .success(let codigo):
                    print("teleferico")
                    self.resultado = codigo
                    self.showScannerTeleferico = false
                    //self.action = 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
               /* NavigationLink(destination: QrGeneratorView( dataUserlog: self.dataUserLog), tag: 1, selection: self.$action) {
                    EmptyView()
            }*/
            }
        }
    }
    
    var btnTransport:some View{
        HStack{
            Button(action: {
                self.showScannerTransporte = true
                self.action = 1
               
            }){
                HStack{
                    Image("Transport")
                        .resizable()
                        .frame(width:80, height: 80)
                        .padding(10)
                }
                .background(Color("card"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
            //.background(Color.blue.opacity(0.5))
            .sheet(isPresented: self.$showScannerTransporte) {
                CodeScannerView(codeTypes: [.qr]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultado = codigo
                        if self.resultado.count > 24 {
                            self.idconmonto = String(self.resultado.prefix(24))
                            print("tiene monto \(self.idconmonto)")
                            self.montoQR = String(self.resultado.dropFirst(24))
                            print("el monto \(self.montoQR)")
                            self.qrPaymentVM.userAfiliacion(id_afiliado: self.idconmonto)
                            self.showScannerTransporte = false
                        }else{
                            print("no tiene monto")
                            self.qrPaymentVM.userAfiliacion(id_afiliado: self.resultado)
                            self.showScannerTransporte = false
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            .onReceive(self.qrPaymentVM.$afiliado) { (afiliado) in
                if afiliado == true {
                    print("entro onreceive")
                    self.userDataVM.DatosUserPago(id_usuario: self.resultado)
                    if self.idconmonto == ""{
                        self.userDataVM.DatosUserPago(id_usuario: self.resultado)
                    }else{
                        self.userDataVM.DatosUserPago(id_usuario: self.idconmonto)
                    }
                  
                }
            }
          
            NavigationLink(destination: PayView(User: self.userDataVM.userResponsePago, montoQR: self.$montoQR), isActive: self.$userDataVM.nextPagoview) {
                EmptyView()
            }
        }
      
    }
     */
    
   
    var btnScan:some View{
        HStack{
            Button(action: {
                self.showScannerScan = true
                //self.action = 2
               
            }){
                HStack{
                    VStack{
                        Image(systemName: "viewfinder")
                            .resizable()
                            .frame(width:35, height: 35)
                            .padding(15)
                            .foregroundColor(Color.white)
                        Text("Scan")
                            .foregroundColor(Color.white)
                            .font(.headline)
                    }
                    
                }
                 .frame(width:100, height: 100)
                 .background(Color("primary"))
                 .cornerRadius(10)
                 .padding(5)
                 //
                
                 .frame(maxWidth:.infinity)
                 //.shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
            }
            //.background(Color.blue.opacity(0.5))
            .sheet(isPresented: self.$showScannerScan) {
                CodeScannerView(codeTypes: [.qr,.code128]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultadosScan = codigo
                        //aqui
                        if self.resultadosScan.hasPrefix("pagar"){
                            let scanDividido: [Substring] = self.resultadosScan.split(separator: ",")
                            if scanDividido.count == 2 {
                                self.userDataVM.DatosUserPay(id_usuario: String(scanDividido[1]))
                                 self.showScannerScan = false
                                 self.action = 10
                                print("A PAGAR SIN MONTO")
                            }else{
                                self.userDataVM.DatosUserPay(id_usuario: String(scanDividido[1]))
                                 self.showScannerScan = false
                                 self.action = 10
                                self.montoPagoQR = String(scanDividido[2])
                              /* print("el primero \(scanDividido[0])")
                                print("el segundo \(scanDividido[1])")
                                print("el tercero \(scanDividido[2])")*/
                                print("A PAGAR CON MONTO")
                            }
                            
                        }else{
                            let scanDivididoCobrar: [Substring] = self.resultadosScan.split(separator: ",")
                            if scanDivididoCobrar.count == 1{
                                print("no tiene pagar \(self.resultadosScan)")
                                self.userDataVM.DatosUserPay(id_usuario: String(scanDivididoCobrar[0]))
                                self.showScannerScan = false
                                self.action = 11
                                print("A COBRAR SIN MONTO")
                            }else{
                                self.userDataVM.DatosUserPay(id_usuario: String(scanDivididoCobrar[0]))
                                self.showScannerScan = false
                                self.action = 11
                                self.montoCobroQR = String(scanDivididoCobrar[1])
                                print("A COBRAR CON MONTO")
                            }
                            
                        }
                       // self.userDataVM.DatosUserPay(id_usuario: self.resultadosScan)
                       // print("aki \(self.userDataVM.userResponsePay)")
                        self.showScannerScan = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            .onReceive(self.userDataVM.$userResponsePay) { (userPay) in
                if userPay._id == "ObjectId"{
                    print("no hay user")
                }else{
                    print("usuario existe")
                  
                }
              
            }
            NavigationLink(destination: ChargeView(dataUserPay: self.userDataVM.userResponsePay, dataUser: self.userDataVM.user, montoCobroQR: self.$montoCobroQR), tag: 11, selection: self.$action) {
                EmptyView()
            }
            NavigationLink(destination: PayScanView(dataUserPay: self.userDataVM.userResponsePay, dataUser: self.userDataVM.user, montoPagoQR: self.$montoPagoQR), tag: 10, selection: self.$action) {
                EmptyView()
            }
           /* NavigationLink(destination: ChargeView(dataUserPay: self.userDataVM.userResponsePay), isActive: self.$userDataVM.nextPayview) {
                EmptyView()
            }*/
        }
    }
        
    
    var btnPay:some View{
            HStack{
                Button(action: {
                    self.action = 4
                }){
                    HStack{
                        VStack{
                            Image(systemName: "qrcode")
                                .resizable()
                                .frame(width:35, height: 35)
                                .padding(15)
                                .foregroundColor(Color.white)
                           // Text("Pagar")
                            Text("Cobro")
                                .foregroundColor(Color.white)
                                .font(.headline)
                        }
                        
                    }
                     .frame(width:100, height: 100)
                     .background(Color("primary"))
                     .cornerRadius(10)
                     .padding(5)
                     //
                    
                     .frame(maxWidth:.infinity)
                     .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                }
                NavigationLink(destination: FormDataQrView(), tag: 4, selection: self.$action) {
                    EmptyView()
                }
               //vi\1
                /*NavigationLink(destination: QrChargeView(dataUserlog: self.userDataVM.user, dataString: ""), tag: 4, selection: self.$action) {
                    EmptyView()
                }*/
            }
        }
   
    var btnIngresar:some View{
            HStack{
                Button(action: {
                    self.action = 3
                }){
                    HStack{
                        VStack{
                            Image(systemName: "viewfinder")
                                .resizable()
                                .frame(width:35, height: 35)
                                .padding(15)
                                .foregroundColor(Color.white)
                            Text("Pago")
                                .foregroundColor(Color.white)
                                .font(.headline)
                        }
                        
                    }
                    .frame(width:100, height: 100)
                    .background(Color("primary"))
                    .cornerRadius(10)
                    .padding(5)
                    //
                   
                    .frame(maxWidth:.infinity)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                }
                NavigationLink(destination: OptionPayQrView(), tag: 3, selection: self.$action) {
                     EmptyView()
                 }
               /* NavigationLink(destination: QrPayView( dataUserlog: self.userDataVM.user), tag: 3, selection: self.$action) {
                    EmptyView()
                }*/
            }
        }
    
    var btnMovimientos:some View{
            HStack{
                Button(action: {
                    self.action = 12
                }){
                    HStack{
                        VStack{
                            Image(systemName: "arrow.left.arrow.right.square")
                                .resizable()
                                .frame(width:35, height: 35)
                                .padding(15)
                                .foregroundColor(Color.white)
                            Text("Mov")
                                .foregroundColor(Color.white)
                                .font(.headline)
                        }
                        
                    }
                    .frame(width:100, height: 100)
                    .background(Color("primary"))
                    .cornerRadius(10)
                    .padding(5)
                    //
                   
                    .frame(maxWidth:.infinity)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                }
                 NavigationLink(destination: HistoryQrView(), tag: 12, selection: self.$action) {
                     EmptyView()
                 }
               /* NavigationLink(destination: QrPayView( dataUserlog: self.userDataVM.user), tag: 3, selection: self.$action) {
                    EmptyView()
                }*/
            }
        }
    
    var btnCard:some View{
        Button(action: {
            self.action = 2
        }){
            VStack{
                Image("logo_fastgi")
                    .resizable()
                    .frame(width:80, height: 80)
                    .padding(10)
            }
            .background(Color("card"))
            .cornerRadius(10)
            .frame(maxWidth:.infinity)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
            NavigationLink(destination: FormLoadInternalCardView(MontoRecarga1: .Btn30) , tag: 2, selection: self.$action) {
            EmptyView()
            }
        }
    }
    
    
    var home:some View{
        ScrollView{
            HStack(spacing:10){
                //self.btnMovimientos
                //self.btnPay
                //self.btnIngresar
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            VStack{
                Text("Recarga de línea pre pago ")//\(self.userDataVM.testid)\\self.contactsVM.listContacts.count
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack{
                    CardServiceHomeView( logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                    CardServiceHomeView(logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                    CardServiceHomeView(logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            //tarjeta interna
            /*VStack{
                Text("Tarjeta interna")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack(spacing:10){
                    self.btnCard
                    Spacer()
                    .frame(maxWidth:.infinity)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)*/
            ////////
            /*VStack{
                Text("Transportes")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack(spacing:10){
                    self.btnTeleferic
                    self.btnTransport
                        Spacer()
                            .frame(maxWidth:.infinity)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                //pruebas
                HStack{
                    if self.userDataVM.isloading == true || self.qrPaymentVM.isloading == true{
                        Loader()
                    }
                }
            
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)*/
          
  
        }
        .padding()
    }
    
   /* var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Usuario no afiliado."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }*/
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Datos modificados correctamente."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
            //self.navigationRoot.setRootView()
        }))
    }
    
    var body: some View {
        VStack{
            self.home
            //test de registro de tarjetas
             VStack{
                 Button(action: {
                     print("home")
                    self.qrPayment.generarQr(tipocobro: "cobro", vencimiento: "2021-10-04T02:42:52.226Z", tipomoneda: "Bs", monto: "10", descripcion: "pago de servicio")
                   // self.alertState = true
                    //self.cards.saveCard(card_nombre: "Banco App", card_number: "123123123123123", card_expiry_date: "11-2022", card_cvn: "312", card_type: "111")
                 }){
                    // Text("test1")
                 }
                 //.sheet(isPresented: $showingSheet) {
                   // DeleteCardView()
                // }
             }
         
            // test button
           /* VStack{
                Button(action: {
                    self.action = 44
                   // self.qrPayment.obtenerQr(id_qr: "6160b6502319e611418d95b5")
                  
                }){
                    Text("test")
                }
             
                NavigationLink(destination: QrPayView(dataUserlog: self.userDataVM.user), tag: 44, selection: self.$action) {
                    EmptyView()
                }
                /*NavigationLink(destination: ToastView(), tag: 44, selection: self.$action) {
                    EmptyView()
                }*/
            }*/
            
        }
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
        /*.alert(isPresented:  self.$qrPaymentVM.alertNoAfiliado){
            self.alerts
        }*/
        }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
            
    }
}

//retorno de cambio de variables ViewModel
/*  .onReceive(self.qrPaymentVM.$noafiliado) {
      if $0 == nil{
          self.alertState = true
      }
  }
  .onReceive(self.qrPaymentVM.$enespera) {
      if $0 == "false"{
          self.alertState = true
      }
  }*/
