//
//  ListCityView.swift
//  fastgi
//
//  Created by Hegaro on 25/06/2021.
//

import SwiftUI

struct ListCityView: View {
    @Binding var showingSheet:Bool
    @Binding var city:String
    var list:some View{
        List{
            Button(action: {
                self.showingSheet = false
                self.city = "Tarija"
            })
            {
                HStack(){
                    Text("Tarija")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "La Paz"
            })
            {
                HStack(){
                    Text("La Paz")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Santa Cruz"
            })
            {
                HStack(){
                    Text("Santa Cruz")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Oruro"
            })
            {
                HStack(){
                    Text("Oruro")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Potosi"
            })
            {
                HStack(){
                    Text("Potosi")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Beni"
            })
            {
                HStack(){
                    Text("Beni")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Pando"
            })
            {
                HStack(){
                    Text("Pando")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Sucre"
            })
            {
                HStack(){
                    Text("Sucre")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.city = "Cochabamba."
            })
            {
                HStack(){
                    Text("Cochabamba")
                }
            }
        }
    }
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige una ciudad"), displayMode: .inline)
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

struct ListCityView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var city: String = ""
        static var previews: some View {
            ListCityView(showingSheet: $showingSheet,city: $city)
        }
}
