//
//  FormUserDataView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

import SDWebImageSwiftUI
struct FormUserDataView: View {
    var updateUser = UpdateUser()
    @State var correoEstatico: String = "elvin@gmail.com"
    @ObservedObject var login = Login()
    @ObservedObject var updateVM = UpdateUserViewModel()
    var navigationRoot = NavigationRoot()
    // back
    @EnvironmentObject var authState: AuthState
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    //Test
    @State var output: String = ""
    @State var input: String = ""
    //validation
    @State var ci: String = ""
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    
    //camera
    @ObservedObject var imageVM = ImageViewModel()
    @State private var showImagePicker: Bool = false
    @State private var showSheet:Bool = false
    @State private var imageSelect : UIImage? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    init() {
        self.userDataVM.DatosUser1()
      //  self.afiliacionVM.verifiAffiliate(id_cobrador: self.userDataVM.user._id)
    }
    
    var imageProfile:some View {
        HStack(alignment: .center){
            WebImage(url: URL(string: "https://api.fastgi.com/avatar/\(self.userDataVM.user._id)"), options: .refreshCached)
            //WebImage(url: URL(string: "https://i.postimg.cc/8kJ4bSVQ/image.jpg" ))
            .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                //Image(uiImage: self.imageVM.image ?? UIImage(named: "placeholder")!)
                    .placeholder(Image( "user-default"))
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .overlay(
                        Circle()
                            .stroke(Color("card"), lineWidth: 2))
            
        }
        .overlay(
            HStack(alignment:.bottom){
                Spacer()
                Button(action: {
                    self.showSheet = true
                    // self.showImagePicker = true
                    // self.sourceType = .photoLibrary
                }){
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("primary"))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("card"), lineWidth: 2))
                    
                }.padding(.top,60)
            }
        )
        .padding(.top)
    }

    var infoUser:some View{
        ScrollView(){
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 8){
  
                    Text("DATOS PERSONALES")
                        .textStyle(TitleStyle())
                    
                    Text("DOCUMENTO DE IDENTIDAD")
                        .textStyle(TitleStyle())
                    TextField("C.I.", text:  self.$userDataVM.user1.ci, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.numberPad)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                         doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                         }
                    Text("CORREO ELECTRÓNICO")
                        .textStyle(TitleStyle())
                    TextField("user@email.com", text: self.$correoEstatico)
                      .textFieldStyle(InputCorreo())
                        //.keyboardType(.emailAddress)
                    Text("NOMBRES")
                        .textStyle(TitleStyle())
                    TextField("user name", text: self.$userDataVM.user1.nombres, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                    Text("APELLIDOS")
                        .textStyle(TitleStyle())
                    TextField("user lastname", text: self.$userDataVM.user1.apellidos, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                }
                VStack(alignment: .leading, spacing: 8){
                    Text("DIRECCIÓN")
                        .textStyle(TitleStyle())
                    TextField("user address", text: self.$userDataVM.user1.direccion, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                    Divider()
                        .padding(.vertical)
                    Text("DATOS DE FACTURACIÓN")
                        .textStyle(TitleStyle())
                    Text("NOMBRE")
                        .textStyle(TitleStyle())
                    TextField("Nombre", text: self.$userDataVM.user1.nombrenit, onEditingChanged: { changed in self.AddSpace = false})
                        .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                    //.onAppear(perform: {self.IsKeyboardUp(Is: false)})
                    
                    Text("NIT")
                        .textStyle(TitleStyle())
                    TextField("nit", text: self.$userDataVM.user1.nit, onEditingChanged: { changed in self.AddSpace = false})
                        .textFieldStyle(Input())
                        .keyboardType(.numberPad)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                         doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                         }
                    /*Spacer()
                        .frame(height:80)*/
                }
              
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top,.horizontal])
       
        }
        
    }
    
    
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
                self.updateVM.updateUser(ci: self.userDataVM.user1.ci, correo: "elvin@gmail.com", nombres: self.userDataVM.user1.nombres, apellidos: self.userDataVM.user1.apellidos, direccion: self.userDataVM.user1.direccion, nombrenit: self.userDataVM.user1.nombrenit, nit: self.userDataVM.user1.nit)
                //self.authState.navigateBack = true
                self.alertState = true
            }){
                Text("Aceptar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
           /* NavigationLink(destination: SettingsView(), tag: "updatesuccess", selection: self.$login.ruta) {
                EmptyView()
            }*/
            if self.updateVM.isloading == true{
                Loader()
            }
        }
        .padding()
    }
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Datos modificados correctamente."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
            self.navigationRoot.setRootView()
        }))
    }
    @State var valueKeyboard : CGFloat = 0
    @State var AddSpace : Bool = false

    
    func IsKeyboardUp() -> Void{
        //Keyboard is show
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object:nil, queue: .main){
            (noti) in
            let valueKeyboard = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let height = valueKeyboard.height
            
            if self.AddSpace {
                print("Is true")
                print(self.AddSpace)
                //self.valueKeyboard = height-70
                //self.valueKeyboard = height-70
                self.valueKeyboard = height-300
            }else{
                print("Is false")
                self.valueKeyboard = 0
            }
            
            
            //print(Is)
            //self.AddSpace = true
        }
        //Keyboard is hidde
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object:nil, queue: .main){
            (noti) in
            self.valueKeyboard = 0
             //self.AddSpace = false
        }
    }
    
    
    
    
    var body: some View {
        VStack(){
            self.imageProfile
            self.infoUser
            self.buttonSuccess
                .sheet(isPresented: self.$showImagePicker,onDismiss:  {
                    print("ento al sheet")
                    // debugPrint(self.image ?? "")
                    // self.image.uploadAvatar(image: self.imageSelect!)
                    self.imageVM.changeImage()
                    //ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                    //self.navigationRoot.setRootView()
                    print("salio del sheet")
                })
                {
                    ImagePicker(image: self.$imageVM.image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                }
     //test validacion
     /*   VStack{
         
           
         
            Form {
           Text("DOCUMENTO DE IDENTIDAD")
                    .textStyle(TitleStyle())
                TextField("C.I.", text: self.$update.ci.bound, onEditingChanged: { changed in self.AddSpace = false})
                .textFieldStyle(Input())
                TextField("Correo", text: self.$update.correo.bound)
                TextField("Nombres", text: self.$update.nombres.bound)
                TextField("Apellidos", text: self.$update.apellidos.bound)
                TextField("Direccion", text: self.$update.direccion.bound)
                TextField("NombreNit", text: self.$update.nombrenit.bound)
                TextField("Nit", text: self.$update.nit.bound)
                BrokenRulesView(brokenRules: self.update.brokenRules)
            }
            
        }
        Button("Test Validation") {
            self.update.validationInput()
        }*/
             //

        }  .actionSheet(isPresented: self.$showSheet) {
            ActionSheet(title: Text("Opciones"), buttons: [
                .default(Text("Galeria")) {
                    print("entro galeria")
                    self.showImagePicker = true
                    self.sourceType = .photoLibrary
                   
                },
                .default(Text("Camara")) {
                    print("camara")
                    self.showImagePicker = true
                    self.sourceType = .camera
                },
                .cancel()
            ])
        }
            
        .offset(y: -self.valueKeyboard)
        //.animation(.spring())
            
        .onAppear{
            self.userDataVM.DatosUser()
            self.IsKeyboardUp()
        }
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
    }
}


struct FormUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        FormUserDataView()
    }
}
