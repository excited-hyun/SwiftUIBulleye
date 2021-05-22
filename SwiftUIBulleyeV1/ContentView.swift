//
//  ContentView.swift
//  SwiftUIBulleyeV1
//
//  Created by 신나현 on 2021/05/09.
//

import SwiftUI

struct ContentView: View {
    //Properties
    //==========================
    //Colors
    let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
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
        NavigationView{
            VStack{
                Spacer()
                HStack{
                    Text("Put the bullseye as close as you can do:")
                        .modifier(LabelStyle())
                    
                    
                    //Text("100")
                    Text("\(target)")
                        .modifier(ValueStyle())
                    
                }
                
                Spacer();
                //Slider row
                //TODO : Add view for the slider row here
                HStack{
                    Text("1")
                        .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                    Text("100")
                        .modifier(LabelStyle())
                }
                
                Spacer();
                
                //Button row
                Button(action: {
                    //print("Button Pressed!")
                    print( "points awarded: \(self.pointForCurrentRound())")
                    self.alertIsVisible = true
                    
                }) {
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
                    
                }
                .background(Image("Button"))
                .modifier(Shadow())
                
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
                        HStack{
                            Image("StartOverIcon")
                            Text("Start over").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button"))
                    .modifier(Shadow())
                    
                    Spacer();
                    Text("Score")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                    Spacer();
                    Text("Round")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                    
                    Spacer();
                   // Button(action: {}){
                    NavigationLink(destination: AboutView()){
                        HStack {
                            Image("InfoIcon")
                            Text("Inform").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button"))
                    .modifier(Shadow())
                }.padding(.bottom, 20)
                .accentColor(midnightBlue)
                
            }//end of VStack
            .onAppear() {
                self.startNewGame()
            }
            .background(Image("Background"))
        } //end of NevigationView
        .navigationViewStyle(StackNavigationViewStyle())
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


//View modifiers
struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Round MT Bold", size: 18))
            .foregroundColor(Color.white)
            .modifier(Shadow())
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Round MT Bold", size: 24))
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
    }
}

//shadow
struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
}

//For the Hit me! button
struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Round MT Bold", size: 18))
            .foregroundColor(Color.black)
            
    }
}

//For the Start over and Info button
struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Round MT Bold", size: 12))
            .foregroundColor(Color.black)
            
    }
}

//preview
//=======================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
