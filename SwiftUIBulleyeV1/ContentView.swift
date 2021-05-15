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
    @State var target: Int = Int.random(in: 1...100)
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("Put the bullseye as close as you can do:")
                //Text("100")
                Text("\(self.target)")
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
                //print("Button Pressed!")
                print( "points awarded: \(self.pointForCurrentRound())")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
                
            }
            //State for alert
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello There!"),
                      message: Text(self.scoringMassage()),
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
    func pointForCurrentRound() -> Int {
        
        var difference: Int
        
        if self.sliderValueRounded > self.target {
            difference = self.sliderValueRounded - self.target
        }
        else if self.target > self.sliderValueRounded {
            difference = self.target - self.sliderValueRounded
        }
        else{
            difference = 0
        }
        return 100 - difference
    }
    
    func scoringMassage() -> String {
        return "The slider value is \(Int(self.sliderValueRounded)).\n"
            + "The target value is \(self.target).\n"
            + "Yoou scored \(pointForCurrentRound()) points this round."
    }
    
}//end of structure


//preview
//=======================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
