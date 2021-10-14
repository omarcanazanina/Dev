//
//  QrChargeView.swift
//  fastgi
//
//  Created by Hegaro on 03/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import CarBode
struct QrChargeView: View {
    //navegation back
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    var navigationRoot = NavigationRoot()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var showBtn: Bool? = true
    
    var dataQr: QrGenerateModel
    
    var montoQr: String
    //barcode generator
    //@State var id = Strin
    @State var dataString : String = ""
    @State var barcodeType = CBBarcodeView.BarcodeType.barcode128
    @State var rotate = CBBarcodeView.Orientation.up
    @State var barcodeImage: UIImage?
    //alert
    @State private var showingAlert = false
    //modal para el monto
    @State var modal = false
    @State var monto = ""
    //compartir img
    @State var items : [Any] = []
    @State var sheet = false
    @State var testImg: UIImage?
    @State var contIntentos: Int = 0
    //
    //select card
    @State var showingSheetBank = false
    @State var bank: String = "* * * *  5 6 3 6"
    @State private var showingSheet = false
    
    func generarQR(text: String) -> UIImage{
        let data = Data(text.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let img = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage:img).resized(toWidth: 512) ?? UIImage()
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    

    
    var imageProfile:some View {
        HStack(alignment: .center){
                WebImage(url: URL(string: "https://i.postimg.cc/8kJ4bSVQ/image.jpg" ))
                    .onSuccess { image, data, cacheType in
                    }
                    .placeholder(Image( "user-default"))
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .overlay(
                        Circle()
                            .stroke(Color("card"), lineWidth: 2))
        }
    }
    
    var pickerCard: some View{
        Button(action: {
            self.showingSheetBank.toggle()
        }) {
            HStack{
                Text(self.bank)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetBank) {
            ListCardsView(
                showingSheet: self.$showingSheetBank,
                card: self.$bank)
        }
    }
    
    var vista:some View {
        ScrollView{
            VStack{
                Text("FASTGI")
                    .font(.subheadline)
                    .bold()
                    //qr
                    //Image(uiImage: generarQR(text: "\(self.dataUserlog._id),\(self.monto)"))
                Image(uiImage: generarQR(text: self.dataQr._id))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                
                    Text("\(self.montoQr) Bs.")
                        .font(.title)
            }
            .padding(30)
        }
    }
    
    var body: some View {
        ScrollView{
            VStack{
                self.vista
                Text("\(self.contIntentos)")
                    .foregroundColor(.clear)
                HStack{
                    Button(action: {
                        self.navigationRoot.setRootView()
                    })
                    {
                        Text("Aceptar")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
               
                    Button(action: {
                        self.contIntentos += 1
                        self.testImg = self.vista.snapshot()
                        self.showingSheet = true
                        //self.mode.wrappedValue.dismiss()
                       }) {
                           Text("Compartir")
                       }.buttonStyle(PrimaryButtonOutlineStyle())
                       .sheet(isPresented: $showingSheet,
                              content: {
                                ActivityView(activityItems: [self.testImg as Any], applicationActivities: nil)})
                }
               
            }.navigationBarTitle(Text("Pagar"), displayMode: .inline)
        }
    }
}

/*struct QrChargeView_Previews: PreviewProvider {
    static var previews: some View {
        QrChargeView(, dataUserlog: <#UpdateUserModel#>)
    }
}*/
// share



struct ActivityView: UIViewControllerRepresentable {
    //@Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {
        //self.mode.wrappedValue.dismiss()
    }
    
}


struct ShareSheet : UIViewControllerRepresentable {
    var items : [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}


/*
 var vista:some View {
     ScrollView{
         VStack{
            // self.imageProfile
          /*   if self.dataUserlog.nombres == Optional("") || self.dataUserlog.nombres == nil{
                 Text("+591 \(self.dataUserlog.telefono)")
                     .font(.subheadline)
                     //.bold()
             }else{
                 Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                     .font(.subheadline)
                     .bold()
             }*/
             Text("FASTGI")
                 .font(.subheadline)
                 .bold()
                 /*
                 CBBarcodeView(data: .constant("\(self.dataUserlog._id),\(self.monto)" ) ,// self.dataUserlog._id,//$dataString,
                     barcodeType: $barcodeType,
                     orientation: $rotate)
                     { image in
                         self.barcodeImage = image
                     }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .topLeading)//400
                 */
                 //qr
                 //Image(uiImage: generarQR(text: "\(self.dataUserlog._id),\(self.monto)"))
             Image(uiImage: generarQR(text: self.dataQr._id))
                     .interpolation(.none)
                     .resizable()
                     .scaledToFit()
                     .frame(width: 300, height: 300)
             
             
             if self.montoQr != ""{
                 Text("\(self.montoQr) Bs.")
                     .font(.title)
             }else{
                 
             }
         }
         .padding(30)
     }
 }
 */

/*
 var body: some View {
     ScrollView{
         VStack{
             self.vista
             Text("Nro de intentos \(self.contIntentos)")
             //ultimov2
             /*VStack (alignment: .leading){
                 Text("Tarjetas")
                     .textStyle(TitleStyle())
                 self.pickerCard
             }.padding()*/
            
             HStack{
                 Button(action: {
                     self.navigationRoot.setRootView()
                 })
                 {
                     Text("Aceptar")
                 }.buttonStyle(PrimaryButtonOutlineStyle())
                 //ultimov2
                /* Button(action: {
                     self.modal.toggle()
                 }){
                     Text("Monto")
                 }.buttonStyle(PrimaryButtonOutlineStyle())
                 .sheet(isPresented: $modal) {
                     EnterAmountView(modal: self.$modal, monto: self.$monto)
                 }*/
                 
                 Button(action: {
                     items.removeAll()
                     items.append(self.vista.snapshot())
                     //items.append(UIImage(named: self.imageShare)!)
                     sheet.toggle()
                 }){
                     Text("test")
                 }.buttonStyle(PrimaryButtonOutlineStyle())
                 .sheet(isPresented: $sheet, content: {
                     ShareSheet(items: items)
                 })
                 Button(action: {
                     self.testImg = self.vista.snapshot()
                     self.showingSheet = true
                    }) {
                        Text("Compartir")
                        
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                    .sheet(isPresented: $showingSheet,
                           content: {
                             ActivityView(activityItems: [self.testImg as Any], applicationActivities: nil) })
                 
                 //error en la descarga
                 
                /* Button("Decargar") {
                     let image = self.vista.snapshot()
                     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                     showingAlert = true
                 }.buttonStyle(PrimaryButtonOutlineStyle())*/
             }
             .alert(isPresented: $showingAlert) {
                 Alert(title: Text("Fastgi"), message: Text("Descarga completa"), dismissButton: .default(Text("Aceptar")))
             }
            
         }.navigationBarTitle(Text("Pagar"), displayMode: .inline)
     }.onAppear{
         //self.testImg1 = self.testImg
        // self.dataQr._id
     }
 
 }
 */
