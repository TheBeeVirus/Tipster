//
//  CalculateView.swift
//  Tipster
//
//  Created by Jd Beecham on 8/23/21.
//

import SwiftUI

struct CalculateView: View {
    @Binding var calulatePopup : Bool
    @Binding var totalAmount : Double
    @Binding var splitText : String
    
    var body: some View {
        ZStack(){
            //Rectangle()
                //.foregroundColor(Color("SemiBG"))
                //.ignoresSafeArea()
            BlurView(style: .regular)
                .ignoresSafeArea()
            VStack(){
                Spacer()
                VStack()
                {
                    Text("Total per person")
                        .font(.largeTitle)
                        .foregroundColor(Color("MainText"))
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .font(.title)
                        .foregroundColor(Color("MainText"))
                    Divider()
                        .padding()
                    Text(splitText)
                        .font(.body)
                        .foregroundColor(Color("MainText"))
                        .padding()
                    Button("Close"){
                        withAnimation(Animation.linear(duration: 0.5))
                        {
                            calulatePopup.toggle()
                        }
                    }
                        .padding()
                        .foregroundColor(Color("MainText"))
                        .background(Color("Select"))
                        .cornerRadius(75)
                }
                Spacer()
                
            }
        }
    }
}

struct CalculateView_Previews: PreviewProvider {
    @State static var calulatePopup = false
    @State static var totalAmount = 45.00
    @State static var splitText = "Split between 2 people, with 10% tip."
    static var previews: some View {
        CalculateView(calulatePopup: $calulatePopup, totalAmount: $totalAmount, splitText: $splitText)
    }
}
