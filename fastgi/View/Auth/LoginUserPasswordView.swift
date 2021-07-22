//
//  LoginUserPasswordView.swift
//  fastgi
//
//  Created by Hegaro on 11/05/2021.
//

import SwiftUI

struct LoginUserPasswordView: View {
    @State var correo: String = ""
    @State var password: String = ""
    var body: some View {
        VStack(spacing:10) {
           
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
                    Text("PASSWORD")
                        .textStyle(TitleStyle1())
                    TextField("password", text: self.$password)
                    .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                }
        
            Button(action: {
                
            })
            {
                Text("Ingresar")
                    .textStyle(TextButtonLoginStyle())
            }
            
            Spacer()
          /*  NavigationLink(destination: CodeView(number: "12121212", smstext: self.loginVM.smstext), tag: "idlogin", selection: self.$login.ruta) {
                EmptyView()
            }*/
        }
    
        .padding([.top, .leading, .trailing])
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color("primary"))
        .edgesIgnoringSafeArea(.top)
    }
}

struct LoginUserPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUserPasswordView()
    }
}
