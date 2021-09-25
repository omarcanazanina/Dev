//
//  ListMoneyView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI

struct ListMoneyView: View {
    @Binding var showingSheet:Bool
    @Binding var card:String
    
    var list:some View{
        List{
         
            Button(action: {
                self.showingSheet = false
                self.card = "bolivianos"
            })
            {
                HStack(){
                    Text("Bolivianos (Bs)")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "dolares"
            })
            {
                HStack(){
                    Text("Dolares Americanos ($us)")
                }
            }
            
            }
        }
    
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige la moneda"), displayMode: .inline)
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

struct ListMoneyView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var card: String = ""
    static var previews: some View {
        ListMoneyView(showingSheet: $showingSheet,card: $card)
    }
}
