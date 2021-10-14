//
//  OptionPayQrView.swift
//  fastgi
//
//  Created by Hegaro on 24/09/2021.
//

import SwiftUI
import AVFoundation
import CodeScanner
import Foundation
struct OptionPayQrView: View {
 /*   @State private var showSheet:Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @ObservedObject var imageVM = ImageViewModel()
    @State private var image : UIImage? = nil*/
    //funciona
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: Image? = Image("")
    //scan qr
    @State private var showScannerScan = false
    @State private var resultadosScan = ""
    @ObservedObject var qrPayment = QrPayment()
    
    var btnLeer:some View{
        HStack{
            Button(action: {
                self.showScannerScan = true
                //self.action = 2
            }){
                HStack{
                    VStack{
                        Image(systemName: "viewfinder")
                            .resizable()
                            .frame(width:35, height: 35)
                            .padding(15)
                            .foregroundColor(Color.white)
                        Text("Scan")
                            .foregroundColor(Color.white)
                            .font(.headline)
                    }
                    
                }
                 .frame(width:100, height: 100)
                 .background(Color("primary"))
                 .cornerRadius(10)
                 .padding(5)
                 //
                
                 .frame(maxWidth:.infinity)
                 //.shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
            }
            //.background(Color.blue.opacity(0.5))
            .sheet(isPresented: self.$showScannerScan) {
                CodeScannerView(codeTypes: [.qr,.code128]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultadosScan = codigo
                        self.qrPayment.obtenerQr(id_qr: self.resultadosScan)
                        //aqui
                       // self.userDataVM.DatosUserPay(id_usuario: self.resultadosScan)
                       // print("aki \(self.userDataVM.userResponsePay)")
                        self.showScannerScan = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
         
         
           /* NavigationLink(destination: ChargeView(dataUserPay: self.userDataVM.userResponsePay), isActive: self.$userDataVM.nextPayview) {
                EmptyView()
            }*/
        }
    }

    //funcion para la img
    
    var btnSubir:some View{
            HStack{
                Button(action: {
                   // self.showImagePicker.toggle()
                    // self.showSheet = true
                }){
                    HStack{
                        VStack{
                            Image(systemName: "qrcode")
                                .resizable()
                                .frame(width:35, height: 35)
                                .padding(15)
                                .foregroundColor(Color.white)
                           // Text("Pagar")
                            Text("Subir QR")
                                .foregroundColor(Color.white)
                                .font(.headline)
                        }
                        
                    }
                     .frame(width:100, height: 100)
                     .background(Color("primary"))
                     .cornerRadius(10)
                     .padding(5)
                     //
                    
                     .frame(maxWidth:.infinity)
                     .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                }
            }
        }
    
    var body: some View {
        VStack{
            HStack{
                //self.selectedImage?.resizable().scaledToFit()
                  Text("scan \(self.resultadosScan)")
            }
            HStack{
                self.btnLeer
                self.btnSubir
                Button(action: {
                    //QRToString()
                  /*  if let features = detectQRCode(self.selectedImage as? UIImage), !features.isEmpty{
                        for case let row as CIQRCodeFeature in features{
                            print(row.messageString ?? "nope")
                        }
                    }else{
                        print("no entro a la funcion")
                    }*/
                   // UIImage(imageLiteralResourceName: "test")
                }){
                    //Text("asd")
                }
               
            }
            
        }.navigationBarTitle(Text("Pago"), displayMode: .inline)
        //funciona para la img
        /*.sheet(isPresented: $showImagePicker,content:{
            ImagePicker1(image: self.$selectedImage)
          
        })*/
        
        
        /*.actionSheet(isPresented: self.$showSheet) {
            ActionSheet(title: Text("Opciones"), buttons: [
                .default(Text("Galeria")) {
                    print("entro galeria")
                    self.showImagePicker = true
                    self.sourceType = .photoLibrary
                   
                },
              /*  .default(Text("Camara")) {
                    print("camara")
                    //self.showImagePicker = true
                    //self.sourceType = .camera
                },*/
                .cancel()
            ])
        }*/
    }
    /*func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features

        }
        return nil
    }*/
    
    
}
/*
struct OptionPayQrView_Previews: PreviewProvider {
    static var previews: some View {
        OptionPayQrView(.constant(.Entel))
    }
}*/



extension UIImage {
    func parseQR() -> [String] {
        guard let image = CIImage(image: self) else {
            return []
        }

        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let features = detector?.features(in: image) ?? []

        return features.compactMap { feature in
            return (feature as? CIQRCodeFeature)?.messageString
        }
    }
}

class QRToString {

    func string(from image: UIImage) -> String {

        var qrAsString = ""
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                        context: nil,
                                        options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
            let ciImage = CIImage(image: image),
            let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {
                return qrAsString
        }

        for feature in features {
            guard let indeedMessageString = feature.messageString else {
                continue
            }
            qrAsString += indeedMessageString
        }

        return qrAsString
    }
}
