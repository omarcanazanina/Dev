//
//  CardsViewModel.swift
//  fastgi
//
//  Created by Hegaro on 30/06/2021.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class CardsViewModel: ObservableObject {
    var CardsResponse = Cards()
    @Published var ListCards : [CardModel] = []
    private var disposables: Set<AnyCancellable> = []
    @Published var isloading: Bool = false
    
    private var isListCardsPublisher: AnyPublisher<[CardModel], Never> {
        CardsResponse.$getCardsResponse
                .receive(on: RunLoop.main)
                .map { response in
                    guard let response = response else {
                        return self.ListCards
                    }
                    return response.Tarejetas
            }
            .eraseToAnyPublisher()
        }
    
    
    private var isLoadingPublished: AnyPublisher<Bool, Never> {
        CardsResponse.$isloading
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    
    init(){
        isListCardsPublisher
             .receive(on: RunLoop.main)
             .assign(to: \.ListCards, on: self)
             .store(in: &disposables)
        
        isLoadingPublished
            .receive(on: RunLoop.main)
            .assign(to: \.isloading, on: self)
            .store(in: &disposables)
        
    }
    
    func saveCardVM(card_nombre: String, card_number: String, card_expiry_date: String, card_cvn: String, card_type: String){
        self.CardsResponse.saveCard(card_nombre: card_nombre, card_number: card_number, card_expiry_date: card_expiry_date, card_cvn: card_cvn, card_type: card_type)
    }
    
    func listCards() {
        self.CardsResponse.ListCards()
       }
    
    func deleteCardVM(id_card: String){
        self.CardsResponse.deleteCard(id_card: id_card)
    }
}
