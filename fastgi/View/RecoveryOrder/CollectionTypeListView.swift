//
//  CollectionTypeListView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI

struct CollectionTypeListView: View {
    @Binding var showingSheet:Bool
    @Binding var card:String
    
    var list:some View{
        List{
         
            Button(action: {
                self.showingSheet = false
                self.card = "unicouso"
            })
            {
                HStack(){
                    Text("Único uso")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "masdeunuso"
            })
            {
                HStack(){
                    Text("Más de un uso")
                }
            }
            
            }
        }
    
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige un tipo de cobro"), displayMode: .inline)
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

struct CollectionTypeListView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var card: String = ""
    static var previews: some View {
        CollectionTypeListView(showingSheet: $showingSheet,card: $card)
    }
}
