//
//  CardModel.swift
//  fastgi
//
//  Created by Hegaro on 30/06/2021.
//

import Foundation

struct CardModel : Codable {
    let _id : String
    let card_number : String
    let card_nombre : String
    let card_expiry_date : String
    let card_cvn : String
    let card_type : String
    let id_usuario : String
    let fecha : String
}


struct deleteCardModel : Codable {
    let _id : String
    let card_number : String
    let card_nombre : String
    let card_expiry_date : String
    let card_cvn : String
    let card_type : String
    let id_usuario : String
    let fecha : String
}
