//
//  ListExpirationView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI

struct ListExpirationView: View {
    @Binding var showingSheet:Bool
    @Binding var card:String
    
    var list:some View{
        List{
         
            Button(action: {
                self.showingSheet = false
                self.card = "unasemana"
            })
            {
                HStack(){
                    Text("Vence en 1 Semana")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "unmes"
            })
            {
                HStack(){
                    Text("Vence en 1 Mes")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "unaño"
            })
            {
                HStack(){
                    Text("Vence en 1 Año")
                }
            }
            
            }
        }
    
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige vencimiento"), displayMode: .inline)
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

struct ListExpirationView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var card: String = ""
    static var previews: some View {
        ListExpirationView(showingSheet: $showingSheet,card: $card)
    }
}
