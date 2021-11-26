//
//  TermsAndConditionsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView{
            Text("Bienvenidos a Fastgi.com el uso de nuestros servicios a través de Fastgi.com manifiesta la aceptación de estos términos y condiciones de uso. Por favor leer este documento cuidadosamente. el presente contrato describe los términos y condiciones generales aplicables al uso (ejemplo: visita, registro, compra, recarga, transferencia e inicio de sesión) de los diferentes servicios brindados por Fastgi, en adelante el 'servicio', servicios brindados en este sitio web www.fastgi.com o su aplicación mobile (app), en adelante 'Fastgi.com' o el 'sitio', la persona natural o juridica que haga uso de los servicios brindados por el sitio.")
            Spacer()
            Text("En adelante sera mencionada como el 'usuario'. adicionalmente a los servicios de compra de crédito, pago de servicio, transferencia de crédito anteriormente mencionados, Fastgi.com podra ofrecer otros tipos de servicios los cuales estarán igualmente sujetos a los términos y condiciones generales de uso y a las condiciones particulares y aplicables al servicio.")
            Spacer()
            Text("Cualquier persona que desee acceder y/o usar el servicio, podra hacerlo sujetandose a los términos y condiciones del uso del sitio o aplicación mobile, las políticas de privacidad del sitio o aplicación mobile, y cada una de las cláusulas que se presentan y que en adelante se detalla.")
            Text("CUALQUIER PERSONA NATURAL O JURÍDICA QUE NO ACEPTE LO ANTERIORMENTE MENCIONADO Y LO QUE SE DETALLA A CONTINUACIÓN, LO CUAL TIENE UN CARÁCTER OBLIGATORIO Y VINCULANTE, DEBERA ABSTENERSE DE UTILIZAR EL SERVICIO DE FASTGI.COM")
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .padding()
            
            Link("Saber más",
                  destination: URL(string: "https://www.fastgi.com")!)
                .foregroundColor(Color("primary"))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding()
        }
    }
}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}
