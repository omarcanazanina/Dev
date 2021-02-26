//
//  DataUserResponse.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct DataUserResponse : Codable {
    let usuario : UpdateUserModel
}

struct UserResponse : Codable {
    let usuario : UserModel
}

/*struct DataUserResponse1 : Codable {
    let usuario : UserLogModel
}*/


struct DataUserPagoResponse : Codable {
    var ok: Bool
    var usuario : UpdateUserPagoModel
}

struct ErrorDataUserResponse : Codable {
    var ok : Bool
    var err : ErrorUpdateUser
}
