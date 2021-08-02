//
//  RecargaViewModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class RecargaViewModel: ObservableObject {
    @Published var control: String = ""
    var RecargaResponse=Recargas()
    private var disposables: Set<AnyCancellable> = []
    //recarga exitosa
    @Published var recargaData = RecargaModel(_id: "", empresa: "", recarga: "", telefono: "", id_usuario: "", id_tarjeta: "", fecha: "")
    // lista de recargas
    @Published var ListRecargas : [RecargaListModel] = []
    @Published var isloading: Bool = false
    
    private var TestPublished: AnyPublisher<String, Never> {
        RecargaResponse.$control
            .receive(on: RunLoop.main)
            .map { response in
               // print("MVrecarga\(response)")
                return response
        }
        .eraseToAnyPublisher()
    }
    //DataRecarga
    private var RecargaDataPublisher: AnyPublisher<RecargaModel, Never> {
       RecargaResponse.$recargaResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return self.recargaData
                }
                return response
        }
        .eraseToAnyPublisher()
    }
    
    private var isListRecargaPublisher: AnyPublisher<[RecargaListModel], Never> {
           RecargaResponse.$getRecargasResponse
                .receive(on: RunLoop.main)
                .map { response in
                    guard let response = response else {
                        return self.ListRecargas
                    }
                    return response.recarga
            }
            .eraseToAnyPublisher()
        }
        
    private var isLoadingPublished: AnyPublisher<Bool, Never> {
        RecargaResponse.$isloading
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    init(){
            TestPublished
            .receive(on: RunLoop.main)
                 .assign(to: \.control, on: self)
                 .store(in: &disposables)
            //DataUser
            RecargaDataPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.recargaData, on: self)
                .store(in: &disposables)
            
            isListRecargaPublisher
                 .receive(on: RunLoop.main)
                 .assign(to: \.ListRecargas, on: self)
                 .store(in: &disposables)
            
        isLoadingPublished
            .receive(on: RunLoop.main)
            .assign(to: \.isloading, on: self)
            .store(in: &disposables)
        
            //listRecargas()
        }
        
    func listRecargas() {
        print("repite listrecargas")
           self.RecargaResponse.ListRecargas()
       }
       
    /*   func SendRecarga(empresa:BtnEm,recarga:BtnCA,telefono:String) {
           RecargaResponse.sendRecarga(empresa:empresa, recarga:recarga, telefono: telefono)
       }*/
    func SendRecarga(empresa:BtnEm,recarga:String,telefono:String, text: String, tarjetaid:String) {
           RecargaResponse.sendRecarga(empresa:empresa, recarga:recarga, telefono: telefono, text:text, tarjetaid: tarjetaid)
       }
    
    
}
