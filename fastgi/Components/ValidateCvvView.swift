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
    //navigation back
    @EnvironmentObject var authState:AuthState
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 8){
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
                    }
                    
                }){
                    Text("\(self.cardNumber)Aceptar \(self.validateCvv)")
                        .foregroundColor(Color.white)
                        .frame(maxWidth:.infinity)
                        .padding(8)
                        .background(Color("primary"))
                        .clipShape(Capsule())
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                }
                /*VStack {
                    Text("View 2")
                        .font(.headline)
                    Button(action: {
                        self.authState.moveToDashboard = true
                    }) {
                        Text("Move to Dashboard")
                        .font(.headline)
                    }
                }*/
            }
        }
    }
}

struct ValidateCvvView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateCvvView(validateCvv: "", cardNumber: .constant("") )
    }
}
