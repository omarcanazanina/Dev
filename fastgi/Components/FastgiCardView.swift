//
//  FastgiCardView.swift
//  fastgi
//
//  Created by Hegaro on 30/09/2021.
//

import SwiftUI

struct FastgiCardView: View {
    var logo : String? = "logo_fastgi"
    var bank : String? = ""
    var dateExp : String? = "00/00"
    var number : String? = "0000"
    var id_card: String? = ""
    @State private var sizeChanged = false
    @State var delete = false
    
    var body: some View {
        VStack{
            HStack{
                Image("chip")
                    .resizable()
                    .scaledToFit()
                    .frame(height:50)
                    .padding(.top,25)
                //.background(Color.green.opacity(0.5))
                Spacer()
                Image(self.logo!)
                    .resizable()
                    .scaledToFit()
                    .frame(height:35)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
                //.background(Color.green.opacity(0.5))
            }
            //.background(Color.red.opacity(0.5))
            HStack{
                Text("****")
                    //.font(.custom("AmericanTypewriter", size: 12))
                    .kerning(4)
                Text("****")
                    .kerning(4)
                Text("****")
                    .kerning(4)
                Text(self.number!)
                    .kerning(2)
            }
            
            .foregroundColor(Color("primary"))
            HStack{
                Text(self.bank!)
                    .font(.caption)
                Text("Fastgi")
                    .font(.caption)
                Spacer()
                Text("Vence: \(self.dateExp!)")
                    .font(.caption)
                
                /*Button(action: {
                    self.delete.toggle()
                    print("menu")
                }){
                    VStack{
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.trailing,6)
                    }
                }
                NavigationLink(destination: DeleteCardView(idCard: self.id_card ?? "") , isActive: $delete) {
                    EmptyView()
                }*/
                    
            }
            
            .padding(.horizontal)
            .foregroundColor(Color("primary"))
            .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
      
        .padding(.bottom,8)
        .padding(.horizontal)
        .frame(minWidth: 280, idealWidth: 280, maxWidth: 280, minHeight: 180, idealHeight: 180, maxHeight: 180, alignment: .center)
        .background(Color(.white))
        .cornerRadius(18)
        .foregroundColor(Color("primary"))
        .overlay(
        RoundedRectangle(cornerRadius: 18)
            .stroke(Color("primary"), lineWidth: 1))
        .padding()
        /*
         Animation
         .scaleEffect(sizeChanged ? 0.2 : 1.0)
         .onTapGesture{
         withAnimation(.default){
         self.sizeChanged.toggle()
         }
         }*/
    }
}

struct FastgiCardView_Previews: PreviewProvider {
    static var previews: some View {
        FastgiCardView()
    }
}
