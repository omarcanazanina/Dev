//
//  CardResponse.swift
//  fastgi
//
//  Created by Hegaro on 30/06/2021.
//

import Foundation

struct CardResponse : Codable {
    let ok : Bool
    let afiliado : CardModel
}

struct GetCardsResponse : Codable {
    let ok :Bool
    let Tarejetas: [CardModel]
}

struct DeleteCardResponse : Codable{
    let ok : Bool
    let usuario : deleteCardModel
    let mensaje : String
}
