//
//  RegisterUserCorreoPasswordView.swift
//  fastgi
//
//  Created by Hegaro on 15/10/2021.
//

import SwiftUI

struct RegisterUserCorreoPasswordView: View {
    //test login correo password
    @ObservedObject var login = Login()
    @State var correo: String = ""
    @State var password: String = ""
    @State var telefono: String = ""
    var body: some View {
        VStack(spacing:20) {
            Text("Fastgi")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 8){
                Text("CORREO ELECTRÓNICO")
                    .textStyle(TitleStyle1())
                TextField("user@email.com", text: self.$correo)
                    .textFieldStyle(Input())
                    .keyboardType(.emailAddress)
            }
            
            VStack(alignment: .leading, spacing: 8){
                Text("PASSWORD")
                    .textStyle(TitleStyle1())
                TextField("password", text: self.$password)
                    .textFieldStyle(Input())
                    .keyboardType(.alphabet)
            }
            VStack(alignment: .leading, spacing: 8){
                Text("TELÉFONO")
                    .textStyle(TitleStyle1())
                TextField("telefono", text: self.$telefono)
                    .textFieldStyle(Input())
                    .keyboardType(.alphabet)
            }
            Button(action: {
                self.login.userRegisterPassword(correo: self.correo, password: self.password, telefono: self.telefono)
            })
            {
                Text("Registrarse")
                    .textStyle(TextButtonLoginStyle())
            }
            
            Spacer()
           /* NavigationLink(destination: RegisterUserCorreoPasswordView(), tag: 1, selection: self.$action) {
               EmptyView()
            }*/
        }
    
        .padding([.top, .leading, .trailing])
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color("primary"))
        .edgesIgnoringSafeArea(.top)
    }
}

struct RegisterUserCorreoPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUserCorreoPasswordView()
    }
}
