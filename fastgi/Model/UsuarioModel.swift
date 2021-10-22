//
//  UsuarioModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct Usuario : Codable {
    var role: String
    var estado: Bool
    var _id: String
    var telefono: String
    var pin: String
    var fecha: String
}

struct UsuarioPassword : Codable {
    var user: String
    var role: String
    var estado: Bool
    var _id: String
    var telefono: String
    var pin: String
    var fecha: String
}

struct UsuarioCorreoPassword : Codable {
    var img: String
    var role: String
    var estado: Bool
    var _id: String
    var telefono: String
    var correo: String
    var pin: String
    var fecha: String
}
