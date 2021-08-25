//
//  ContentView.swift
//  Tipster
//
//  Created by Jd Beecham on 8/20/21.
//

import SwiftUI

struct ContentView: View {

    @State private var inputValue : String = ""
    @State private var amountPeople = 1
    @State private var group = "person"
    @State private var tip = 1.1
    @State private var tipString = "10%"
    @State var calulatePopup = false
    @State var totalAmount : Double = 0.0
    @State var splitText : String = ""

    var body: some View {
        ZStack() {
            RadialGradient(gradient: Gradient(colors: [Color("GradTop"), Color("GradBottom")]), center: .top, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
            VStack() {
                Spacer()
                Image(systemName: "hand.thumbsup.fill")
                    .font(.system(size: 75.0, weight: .bold))
                    .foregroundColor(Color("BG"))
                Spacer()
                VStack(){
                Label("Enter bill total", systemImage: "creditcard.fill")
                    .font(.title)
                    .foregroundColor(Color("MainText"))
                    .padding(.top, 20)
                TextField("e.g. 123.45", text: $inputValue)
                    .padding()
                    .keyboardType(.decimalPad)
                    .foregroundColor(Color("MainText"))
                GroupBox(label: Label("Select Tip", systemImage: "heart.fill").foregroundColor(Color("MainText"))){
                    HStack() {
                        Button("0%"){
                            tip = 1.0
                            tipString = "0%"
                            hideKeyboard()
                        }
                            .padding(10)
                            .background(Color( tip == 1.0 ? "Select" : "UnSelect"))
                            .foregroundColor(Color("MainText"))
                            .opacity(tip == 1.0 ? 1 : 0.65)
                        
                        Button("5%"){
                            tip = 1.05
                            tipString = "5%"
                            hideKeyboard()
                        }
                            .padding(10)
                            .background(Color( tip == 1.05 ? "Select" : "UnSelect"))
                            .foregroundColor(Color("MainText"))
                            .opacity(tip == 1.05 ? 1 : 0.65)
                        
                        Button("10%"){
                            tip = 1.1
                            tipString = "10%"
                            hideKeyboard()
                        }
                            .padding(10)
                            .background(Color( tip == 1.1 ? "Select" : "UnSelect"))
                            .foregroundColor(Color("MainText"))
                            .opacity(tip == 1.1 ? 1 : 0.65)
                        
                        Button("15%"){
                            tip = 1.15
                            tipString = "15%"
                            hideKeyboard()
                        }
                            .padding(10)
                            .background(Color( tip == 1.15 ? "Select" : "UnSelect"))
                            .foregroundColor(Color("MainText"))
                            .opacity(tip == 1.15 ? 1 : 0.65)
                        
                        Button("20%"){
                            tip = 1.2
                            tipString = "20%"
                            hideKeyboard()
                        }
                            .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .background(Color( tip == 1.2 ? "Select" : "UnSelect"))
                            .foregroundColor(Color("MainText"))
                            .opacity(tip == 1.2 ? 1 : 0.65)
                    }
                }.groupBoxStyle(CustomGroupBox())
                    
                Stepper("Split Amount:", onIncrement: {
                    amountPeople += 1
                    group = checkGroupCount(amount: amountPeople)
                    hideKeyboard()
                    
                }, onDecrement: {
                    if(amountPeople != 1) {
                        amountPeople -= 1
                        group = checkGroupCount(amount: amountPeople)
                    }
                    
                    hideKeyboard()
                })
                .padding(20)
                .foregroundColor(Color("MainText"))
                .background(Color("GroupBG"))
                
                Text("Split between \(amountPeople) \(group)")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .foregroundColor(Color("MainText"))
                Button("Calculate"){
                    let temp = Double(inputValue)
                    if ((temp) != nil) {
                        totalAmount = (temp! * tip) / Double(amountPeople)
                        splitText = generateSplitText()
                        withAnimation(Animation.linear(duration: 0.25))
                        {
                            calulatePopup.toggle()
                        }
                    }
                    

                    hideKeyboard()
                }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 20)
                .foregroundColor(Color("MainText"))
                .background(Color("Select"))
                .cornerRadius(15)
                Divider()
                }.background(Color("BG"))
                .cornerRadius(50)
                .padding()
            }
           
            if(calulatePopup)
            {
                CalculateView(calulatePopup: $calulatePopup, totalAmount: $totalAmount, splitText: $splitText)
            }
        }
    }
    
    func checkGroupCount(amount: Int) -> String {
        
        if (amount > 1){
            return "people"
        }
        
        return "person"
    }
    
    func generateSplitText() -> String {
        return "Split between \(amountPeople) \(group), with \(tipString) tip."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding(25)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color("GroupBG")))
            .overlay(configuration.label
                        .padding(.leading, 15)
                        .padding(.top, 8), alignment: .topLeading)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
