//
//  ListCardsView.swift
//  fastgi
//
//  Created by Hegaro on 05/07/2021.
//

import SwiftUI

struct ListCardsView: View {
    @Binding var showingSheet:Bool
    @Binding var card:String
    
    var list:some View{
        List{
         
            Button(action: {
                self.showingSheet = false
                self.card = "visa"
            })
            {
                HStack(){
                    Text("Visa")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "mastercard"
            })
            {
                HStack(){
                    Text("Mastercard")
                }
            }
            
            }
        }
    
    
var body: some View {
    NavigationView {
        self.list
            .navigationBarTitle(Text("Elige una card"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showingSheet = false
            }) {
                Text("Cerrar")
                    .bold()
                    .foregroundColor(Color("primary"))
            })
    }
}
}

struct ListCardsView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var card: String = ""
        static var previews: some View {
            ListCardsView(showingSheet: $showingSheet,card: $card)
        }
}
