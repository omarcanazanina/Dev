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
            /*Text("Ingrese su correo y contraseña")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.bottom)
              */
            VStack{
                
                TextField("Correo", text: self.$correo)
                    .keyboardType(.numberPad)
                    .padding(12)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .frame(width:220)
                    .introspectTextField { (textField) in
                        textField.becomeFirstResponder()
                     }
                HStack{
                    TextField("Password", text: self.$password)
                        .keyboardType(.numberPad)
                        .padding(12)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .frame(width:220)
                        .introspectTextField { (textField) in
                            textField.becomeFirstResponder()
                         }
                }
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
