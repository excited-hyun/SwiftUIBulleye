//
//  ContentView.swift
//  SwiftUIBulleyeV1
//
//  Created by 신나현 on 2021/05/09.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible: Bool = false //state 변수 선언
    var body: some View {
        VStack{
            Text("Welcome to my first App!")
                .fontWeight(.semibold)
                .padding().foregroundColor(.green)
            
            
            Button(action: {
                print("Button Pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
                
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello There!"),
                      message: Text("This is my first pop-up."),
                      dismissButton: .default(Text("Awesome!")))
            }//end of .alert
        }//end of VStack
    }//end of body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
