//
//  ContentView.swift
//  SwiftUIBulleyeV1
//
//  Created by 신나현 on 2021/05/09.
//

import SwiftUI

struct ContentView: View {
    //Properties
    //Document
    
    //state for Usr interface views
    @State var alertIsVisible: Bool = false //state 변수 선언
    @State var sliderValue: Double = 50.0
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("Put the bullseye as close as you can do:")
                Text("100")
            }
            
            Spacer();
            //Slider row
            //TODO : Add view for the slider row here
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer();
            
            //Button row
            Button(action: {
                print("Button Pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
                
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello There!"),
                      message: Text("The slider value is \(Int(self.sliderValue.rounded()))."),
                      dismissButton: .default(Text("Awesome!")))
            }//end of .alert
            
            Spacer();
            //score row
            //TODO : Add view for the score, rounds, start over and info button
            HStack {
                Button(action: {}){
                    Text("Start over")
                }
                Spacer();
                Text("Score")
                Text("999999")
                Spacer();
                Text("Bound")
                Text("999")
                Spacer();
                Button(action: {}){
                    Text("Inform")
                }
            }.padding(.bottom, 20)

            
        }//end of VStack
    }//end of body
    
    //method
    
}//end of structure


//preview
//=======================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
