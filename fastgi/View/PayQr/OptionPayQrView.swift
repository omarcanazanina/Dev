//
//  OptionPayQrView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI

struct OptionPayQrView: View {
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "qrcode")
                    .resizable()
                    .frame(width:200, height: 200)
                    .padding(15)
            }
            VStack{
            Button(action: {
            }){
                Text("Leer Qr")
            }.foregroundColor(Color.white)
            .frame(maxWidth:.infinity)
            .padding(8)
            .background(Color("primary"))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
            .padding()
                
            }
            Button(action: {
                //self.navigationRoot.setRootView()
            })
            {
                Text("Cargar Qr")
            }.foregroundColor(Color.white)
            .frame(maxWidth:.infinity)
            .padding(8)
            .background(Color("primary"))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
            .padding()
            }.navigationBarTitle(Text("Pago"), displayMode: .inline)
            }
      
    
}

struct OptionPayQrView_Previews: PreviewProvider {
    static var previews: some View {
        OptionPayQrView()
    }
}
