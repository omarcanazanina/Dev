//
//  FormLoadCreditView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import Introspect

struct FormLoadCreditView: View {
    //var nombreUsu : String
    var contContacts : Int
    var empresa: String
    @State  var selectEm :BtnEm
    @State private  var telefono = ""
    @State var MontoRecarga1: BtnCA
    @State  var MontoRecarga = ""
    @ObservedObject var RecargaVM = RecargaViewModel()
    //card number
    @State private  var cardNumber = ""
    @State private  var idCard = ""
    //contacts
    @ObservedObject var contactsVM1 = ImportContactsViewModel()
    @ObservedObject var contactsVM = ContactsViewModel()
    @ObservedObject var contacts = Contacts()
    //navegation
    @State private var action:Int? = 0
    //
    @State var showingSheet = false
    @State private  var nombreContact = ""
    
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    
    //***navigation back two views
    @EnvironmentObject var authState: AuthState
    @State var isView1Active: Bool = false
    //****
    
    /*init(SelectEm: Binding<BtnEm>, Empresa: String, MontoRecarga1: Binding<BtnCA>, montorecarga: String) {
        self._selectEm = SelectEm
        self.empresa = Empresa
        self._MontoRecarga1 = MontoRecarga1
        self.MontoRecarga = montorecarga
        //self.contactsVM.getContacts()
        //print("INIT DEL FORMLOADCREDIT \(self.contactsVM.listContacts.count)")
    }*/
    
    var home: some View {
        ScrollView{
            //botones de la empresa
            HStack{
                BtnsEmView(currentBtnEm: $selectEm)
            }.padding()
            VStack{
                //campo para ingresar numero de contacto
                HStack{
                    TextField("Número de teléfono", text: $telefono)
                        .padding(.horizontal,12)
                        .padding(.vertical,8)
                        .keyboardType(.numberPad)
                        //.cornerRadius(25)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                         doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                         }
                    Button(action: {
                            //if self.contactsVM.listContacts.count == 0{
                            if self.contContacts == 0{
                                print("no hay contactos")
                               // print(self.contContacts)
                                self.contactsVM.importContacts()
                                self.contactsVM.getContacts()
                            
                            }else{
                                print("si hay contactos")
                                //print(self.contContacts)
                                self.showingSheet.toggle()
                            }
                    })
                    {
                        Image(systemName: "person.2")
                            .foregroundColor(Color("primary"))
                            .padding(12)
                    }
                    .onReceive(self.contactsVM.$controlContacts) { (contacts) in
                        if contacts == true {
                            print("entro onreceive e importo")
                            self.contactsVM.getContacts()
                        }
                    }
                    //ListcontactsView
                    .sheet(isPresented: $showingSheet) {
                        ListContactsView(showingSheet: self.$showingSheet, telefono: self.$telefono, nombre: self.$nombreContact, modal: self.$showingSheet)//, listAllContacts: self.$contactsVM.listContacts
                    }
                    //end
                }.background(Color("input"))
                //.border(Color.white, width: 2)
                //.cornerRadius(25)
                //.clipShape(Capsule())
            }.padding()
            //Card select
            if self.contactsVM.isloading == true{
                Loader()
            }
            
            NavigationLink(destination: SelectCreditCardView( cardNumber1: $cardNumber, idCard1: $idCard) , isActive: $isView1Active) {
                HStack{
                    TextField("Seleccionar tarjeta", text: $cardNumber)
                        .padding(.horizontal,12)
                        .padding(.vertical,8)
                   /* Text("Seleccionar tarjeta \(self.cardNumber)")//\(self.contactsVM.listContacts.count)
                        .foregroundColor(Color.primary)
                        .padding(.horizontal,12)
                        .padding(.vertical,8)*/
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(Color("input"))
                        .clipShape(Capsule())
                .padding(.horizontal)
            }
            .isDetailLink(false)
            .onReceive(self.authState.$moveToDashboard) { moveToDashboard in
                if moveToDashboard {
                    print("Move to dashboard: \(moveToDashboard)")
                    self.isView1Active = false
                    self.authState.moveToDashboard = false
                }
            }
            
            // amounts select
           //lista de contactos
            //if self.contactsVM.listComplete == false {
              //  Loader()
            //}
            VStack{
                ContentButtonsView(currentBtn: $MontoRecarga1, text: "", montoRecarga: $MontoRecarga)
                Button(action: {
                    print(self.selectEm)
                    print(self.MontoRecarga1)
                    print(self.MontoRecarga)
                    print(self.telefono)
                    print(self.idCard)
                   
                    if  self.telefono == "" {
                        self.alertState = true
                    }else{
                        if self.MontoRecarga == ""{
                            self.RecargaVM.SendRecarga(empresa: self.selectEm, recarga: "30", telefono: self.telefono,  text: "", tarjetaid: self.idCard)
                        }else{
                            self.RecargaVM.SendRecarga(empresa: self.selectEm, recarga: self.MontoRecarga, telefono: self.telefono,  text: "", tarjetaid: self.idCard)
                        }
                            self.action = 1
                    }
                }){
                    Text("Aceptar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .padding()
                        
                }
                
            }
            if self.RecargaVM.isloading == true{
                Loader()
            }
            //end
            if self.RecargaVM.control != ""{
                NavigationLink(destination: TransactionDetailView(fecha: "", hora: "", empresa:  self.RecargaVM.recargaData.empresa, phone: self.RecargaVM.recargaData.telefono, monto: self.RecargaVM.recargaData.recarga, control: 1, fechaFormat: "", horaFormat: ""), tag: 1, selection: self.$action) {
                        EmptyView()
                }
                
            }
            
          /*  VStack {
                Text("Content View")
                    .font(.headline)
                
                NavigationLink(destination: SelectCreditCardView(cardNumber: $cardNumber, idCard: $idCard) , isActive: $isView1Active) {
                    Text("View 1")
                        .font(.headline)
                }
                .isDetailLink(false)
            }
            .onReceive(self.authState.$moveToDashboard) { moveToDashboard in
                if moveToDashboard {
                    print("Move to dashboard: \(moveToDashboard)")
                    self.isView1Active = false
                    self.authState.moveToDashboard = false
                }
            }*/
            
        }
    }
    
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Ingrese todos los campos por favor."), dismissButton: .default(Text("Aceptar"), action: {
            //self.presentationMode.wrappedValue.dismiss()
            //self.presentationMode.wrappedValue.dismiss()
        }))
    }
    
    
    var body: some View {
        VStack{
            /*if self.contactsVM.listComplete == false{
                self.home
                    .padding(.leading)
                    .padding(.top,80)
                    .disabled(true)
            }else{*/
                self.home
                    .padding(.leading)
                    .padding(.top,80)
            //}
        }
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct FormLoadCreditView_Previews: PreviewProvider {
    static var previews: some View {
       // FormLoadCreditView(SelectEm: .Entel, montoRecarga1: .Btn10, montoRecarga: "")
        FormLoadCreditView( contContacts: 0, empresa: "", selectEm: .Tigo, MontoRecarga1: .Btn30, MontoRecarga: "")
    }
}
