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
    @State var alertIsVisible = false //state 변수 선언
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("Put the bullseye as close as you can do:")
                //Text("100")
                Text("\(target)")
            }
            
            Spacer();
            //Slider row
            //TODO : Add view for the slider row here
            HStack{
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
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
                Alert(title: Text(alertTitle()),
                      message: Text(self.scoringMassage()),
                      dismissButton: .default(Text("Awesome!")){
                        self.startNewRound()
                      })
            }//end of .alert
            
            Spacer();
            //score row
            //TODO : Add view for the score, rounds, start over and info button
            HStack {
                Button(action: {
                    self.startNewGame()
                }){
                    Text("Start over")
                }
                Spacer();
                Text("Score")
                Text("\(score)")
                Spacer();
                Text("Round")
                Text("\(round)")
                Spacer();
                Button(action: {}){
                    Text("Inform")
                }
            }.padding(.bottom, 20)

            
        }//end of VStack
        .onAppear() {
            self.startNewGame()
        }
    }//end of body
    
    //method
    func pointForCurrentRound() -> Int {
        
        let maximumScore = 100
        //let difference = abs(self.sliderValueRounded - self.target)
        let points: Int
        if sliderTargetDifference == 0{
            points = 200
        } else if sliderTargetDifference == 1{
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        
        return points
    }
    
    func scoringMassage() -> String {
        return "The slider value is \(Int(sliderValueRounded)).\n"
            + "The target value is \(target).\n"
            + "Yoou scored \(pointForCurrentRound()) points this round."
    }
    
    func alertTitle() -> String {
        //let difference: Int = abs(self.sliderValueRounded - self.target)
        let title: String
        if sliderTargetDifference == 0{
            title = "Perfect!"
        } else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        } else if sliderTargetDifference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    func startNewRound() {
        score = score + pointForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    func resetSliderAndTarget() {
        //sliderValue = 50.0
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
}//end of structure


//preview
//=======================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
