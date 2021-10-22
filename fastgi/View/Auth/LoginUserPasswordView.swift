//
//  LoginUserPasswordView.swift
//  fastgi
//
//  Created by Hegaro on 11/05/2021.
//

import SwiftUI

struct LoginUserPasswordView: View {
    @ObservedObject var login = Login()
    @State var correo: String = ""
    @State var password: String = ""
    @State private var action:Int? = 0
    var body: some View {
        NavigationView{
            VStack(spacing :40) {
               
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
                Button(action: {
                    self.action = 1
                }){
                    Text("Registrarse")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Button(action: {
                    self.login.userPassword(correo: self.correo, password: self.password)
                })
                {
                    Text("Ingresar")
                        .textStyle(TextButtonLoginStyle())
                }
                
                Spacer()
                NavigationLink(destination: RegisterUserCorreoPasswordView(), tag: 1, selection: self.$action) {
                   EmptyView()
                }
            }
        
            .padding([.top, .leading, .trailing])
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(Color("primary"))
            .edgesIgnoringSafeArea(.top)
        }
       
    }
}

struct LoginUserPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUserPasswordView()
    }
}
