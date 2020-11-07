//
//  ListContactsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct ListContactsView: View {
    
    @Binding var showingSheet:Bool
    //
    @ObservedObject private var contactsVM1 = ImportContactsViewModel()
    //envio numContact a formloadCredit
    @Binding var telefono : String
    @Binding var nombre : String
    @Binding var modal : Bool
    @ObservedObject private var contactsVM = ContactsViewModel()
    //test updateContacts
    @ObservedObject private var contactsA = Contacts()
    //referesh
    @State private var isShowingReferesh = false
    //search
    @State private var searchText : String = ""
    let contacts = ["Herlan Garzon", "Omar Canaza", "Elvin Mollinedo", "Agustin Ayaviri", "Daniel Jaimes", "Amilkar Dominguez"]
    var list:some View{
        VStack{
            //(contact:ContactModel) inSearchBar(text: $searchText, placeholder: "Buscar")
            List {
             //   ForEach(self.contacts.filter {
             //       self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
             //   }, id: \.self) { item in
                //
                ForEach(self.contactsVM.listContacts, id: \.self._id){ (contact:ContactModel) in
              
                    Button(action: {
                        self.telefono = contact.telefono
                        self.nombre = contact.nombre
                        self.modal.toggle()
                    })
                    {
                        HStack(){
                            
                            Spacer()
                                .frame(width:60)
                            VStack(spacing: 2){
                                Text(contact.nombre)
                                HStack(spacing: 2){
                                    Image(systemName: "phone")
                                        .foregroundColor(Color("normal-text").opacity(0.5))
                                    Text(contact.telefono)
                                        .foregroundColor(Color("normal-text").opacity(0.5))
                                }
                            }
                        }
                    }
                    .overlay(
                        HStack{
                            Image("user-default")
                                .resizable()
                                .frame(width:40,height: 40)
                                .clipShape(Circle())
                            Spacer()
                        }
                    )
                   
                }
               /* Button(action: {
                    self.contactsVM.updateContacts()
                }) {
                    Text("Update")
                    
                }
                //.onAppear{
                  //  self.contactsVM.getContacts()
                //}
                if self.contactsVM.isloading == true{
                            Loader()
                }else if self.contactsVM.messageError != ""{
                    Text(self.contactsVM.messageError)
                        .foregroundColor(.red)
                    //self.alert = true
                }*/
              
            }.pullToRefresh(isShowing: $isShowingReferesh) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isShowingReferesh = false
                    print("cargo")
                    self.contactsVM.updateContacts()
                }
              /* if self.contactsVM.isloading == true{
                            Loader()
                }else if self.contactsVM.messageError != ""{
                    Text(self.contactsVM.messageError)
                        .foregroundColor(.red)
                    //self.alert = true
                }*/
            }
            
       
            .alert(item: $contactsVM1.permissionsError) {_ in
                Alert(title: Text("Permiso denegado"), message: Text(contactsVM1.permissionsError?.description ?? "error no conocido"), dismissButton: .default(Text("Ok"),action: { self.contactsVM1.openSettings()}))
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
                self.list
                    .navigationBarItems(trailing: Button(action: {
                        print("Dismissing sheet view...")
                        self.showingSheet = false
                    }) {
                        Text("Cerrar").bold()
                            .foregroundColor(Color("primary"))
                    })
                    .navigationBarTitle(Text("Elige un contacto"), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        print("Dismissing sheet view...")
                        self.showingSheet = false
                    }) {
                        Text("Cerrar").bold()
                            .foregroundColor(Color("primary"))
                    })
           
           
            }.onAppear{
                self.contactsVM.getContacts()
          
            }
    }
}

struct ListContactsView_Previews: PreviewProvider {
    @State static var showingSheet = true
    static var previews: some View {
        //ListContactsView(showingSheet: $showingSheet, telefono: .constant(""), modal: .constant(false))
        ListContactsView(showingSheet: $showingSheet, telefono: .constant(""), nombre: .constant(""), modal: .constant(false))
    }
}



