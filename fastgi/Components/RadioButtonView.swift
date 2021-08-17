//
//  RadioButtonView.swift
//  fastgi
//
//  Created by Hegaro on 05/08/2021.
//

import SwiftUI


struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

//MARK:- Group of Radio Buttons
enum Gender: String {
    case visa = "VISA"
    case mastercard = "MASTERCARD"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        VStack {
            radioVisaMajority
            radioMasterCardMajority
        }
    }
    
    var radioVisaMajority: some View {
        RadioButtonField(
            id: Gender.visa.rawValue,
            label: Gender.visa.rawValue,
            isMarked: selectedId == Gender.visa.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioMasterCardMajority: some View {
        RadioButtonField(
            id: Gender.mastercard.rawValue,
            label: Gender.mastercard.rawValue,
            isMarked: selectedId == Gender.mastercard.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct RadioButtonView: View {
    var body: some View {
           HStack {
               Text("TARJETA")
                .textStyle(TitleStyle())
               RadioButtonGroups { selected in
                   print("Selected card is: \(selected)")
               }
           }.padding()
       }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonView()
    }
}
