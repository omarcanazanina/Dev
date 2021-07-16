//
//  Cards.swift
//  fastgi
//
//  Created by Hegaro on 30/06/2021.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class Cards: ObservableObject {
    private let storage = UserDefaults.standard
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    //lista cards
    @Published var getCardsResponse:GetCardsResponse?
    //loading
    @Published var isloading = false
    @Published var cardResponse:CardModel?
    func saveCard(card_nombre:String, card_number:String, card_expiry_date:String, card_cvn: String, card_type:String){
        self.isloading = true
        let parametros : Parameters = [
            //"id": storage.string(forKey: idKey)!,
            "card_nombre": card_nombre,
            "card_number": card_number,
            "card_expiry_date": card_expiry_date,
            "card_cvn": card_cvn,
            "card_type": card_type
              ]
        
         // creando headers
        var headers: HTTPHeaders = [
               "Accept": "application/json"
         ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        let idusu = storage.string(forKey: idKey)!
         
        guard let url = URL(string: "https://api.fastgi.com/tarejetasrecargas/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                     debugPrint(response)       
                    //print(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a SmsResponse
                        if let decodedResponse = try? JSONDecoder().decode(CardResponse.self, from: data) {
                            print("entro a la recarga")
                            print(decodedResponse.afiliado)
                            self.isloading=false
                            //self.control = decodedResponse.recarga.empresa
                            //self.recargaResponse = decodedResponse.recarga
                            //print(self.recargaResponse!)
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorRecargaResponse.self, from: data) {
                            print(decodedResponse.err.message)
                            //  self.ErrorRes = decodedResponse.err.message
                            return
                        }
                    case let .failure(error):
                        self.isloading = false
                        print(error)
                    }
            }
        }
        
    }
    
    func ListCards(){
          // creando headers
          var headers: HTTPHeaders = [
              "Accept": "application/json"
          ]
          if let token = storage.string(forKey: tokenKey){
              headers.add(name: "token", value: token)
          }
          //"5f56de014e834e3bc4c02059"
          let idusu = storage.string(forKey: idKey)!
              guard let url = URL(string: "https://api.fastgi.com/tarejetasrecarga/\(idusu)") else { return }
              DispatchQueue.main.async {
                  AF.request(url,method:.post,headers: headers )
                      //.validate(contentType: ["application/json"])
                      .responseData{response in
                       //debugPrint(response)
                          switch response.result {
                          case let .success(data):
                              //Cast respuesta a MeResponce
                              if let decodedResponse = try? JSONDecoder().decode(GetCardsResponse.self, from: data) {
                                self.getCardsResponse=decodedResponse
                                //self.recargaResponse = decodedResponse.recarga
                                //print(self.getCardsResponse?.Tarejetas ?? "")
                                  return
                              }
                          case let .failure(error):
                              print(error)
                          }
                  }
              }
      }
    
    func deleteCard(id_card:String){
        self.isloading = true
          // creando headers
          var headers: HTTPHeaders = [
              "Accept": "application/json"
          ]
          if let token = storage.string(forKey: tokenKey){
              headers.add(name: "token", value: token)
          }
          //"5f56de014e834e3bc4c02059"
         // let idusu = storage.string(forKey: idKey)!
              guard let url = URL(string: "https://api.fastgi.com/tarejetasrecarga/\(id_card)") else { return }
              DispatchQueue.main.async {
                AF.request(url,method:.delete ,headers: headers )
                      //.validate(contentType: ["application/json"])
                      .responseData{response in
                       //debugPrint(response)
                          switch response.result {
                          case let .success(data):
                              //Cast respuesta a MeResponce
                              if let decodedResponse = try? JSONDecoder().decode(DeleteCardResponse.self, from: data) {
                                print(decodedResponse)
                                self.isloading=false
                                // self.getCardsResponse=decodedResponse
                               //print(self.getCardsResponse?.tarejetas ?? "")
                                  return
                              }
                          case let .failure(error):
                            self.isloading = false
                              print(error)
                          }
                  }
              }
      }
    
    
}
