//
//  DeleteCardView.swift
//  fastgi
//
//  Created by Hegaro on 07/07/2021.
//

import SwiftUI

struct DeleteCardView: View {
    var idCard: String
    @ObservedObject var cardsVM = CardsViewModel()
    //alert
    @State var alertState: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            List {
                Button(action: {
                    print(self.idCard)
                    self.alertState = true
                    self.cardsVM.deleteCardVM(id_card: self.idCard)
                }) {
                    HStack{
                        Image(systemName: "pencil")
                        Text("Eliminar tarjeta")
                        Spacer()
                    }
                }
            }
            if self.cardsVM.isloading == true{
                Loader()
            }
            
        }
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
      }
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Se elimino exitosamente."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
           // self.navigationRoot.setRootView()
        }))
    }
}

struct DeleteCardView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteCardView(idCard: "")
    }
}
