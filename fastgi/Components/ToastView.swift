//
//  ToastView.swift
//  fastgi
//
//  Created by Hegaro on 18/08/2021.
//

import SwiftUI
import PopupView

struct ToastView: View {
    @State var isShowingPopUp = false
    var body: some View {
        VStack{
            Button(action: {
                self.isShowingPopUp = true
            })
            {
                Text("test")
                
            } .popup(isPresented: $isShowingPopUp, type: .floater(verticalPadding: 80), position: .top, animation: .easeIn, autohideIn: 3, closeOnTap: true, closeOnTapOutside: false, view: {
                Toast()
            })
        }
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView()
    }
}

struct Toast : View {
    var body: some View {
        ZStack{
            Color.green
            HStack{
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 35,height: 35,alignment: .center)
                    .foregroundColor(Color.white )
                    .padding()
                Text("Esta es una notificacion ")
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 45)
        .cornerRadius(12)
        .padding()
    }
}
