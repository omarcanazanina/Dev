//
//  ValidateCvvView.swift
//  fastgi
//
//  Created by Hegaro on 20/07/2021.
//

import SwiftUI

struct ValidateCvvView: View {
    @State var card_cvv: String = ""
    var validateCvv: String
    @Binding var cardNumber: String
    @Binding var idCard: String
    //navigation back
    @EnvironmentObject var authState:AuthState
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    var body: some View {
        ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    Text("Ingrese cvv")
                        .textStyle(TitleStyle())
                    TextField("123", text:  self.$card_cvv)
                        .textFieldStyle(Input())
                    Button(action: {
                        if self.validateCvv == self.card_cvv{
                            print("iguales\(self.card_cvv)")
                            //self.presentationMode.wrappedValue.dismiss()
                            self.authState.moveToDashboard = true
                        }else{
                            print("no son iguales \(self.card_cvv)")
                            self.alertState = true
                        }
                    }){
                        Text("Aceptar")
                            .foregroundColor(Color.white)
                            .frame(maxWidth:.infinity)
                            .padding(8)
                            .background(Color("primary"))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    }
                }
            .alert(isPresented:  self.$alertState){
                self.alerts
            }
        }   .padding()
    }
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Cvv es incorrecto."), dismissButton: .default(Text("Aceptar"), action: {
            //self.presentationMode.wrappedValue.dismiss()
        }))
    }
}

struct ValidateCvvView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateCvvView(validateCvv: "", cardNumber: .constant(""), idCard: .constant("") )
    }
}
