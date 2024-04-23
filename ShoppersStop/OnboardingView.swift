//
//  ContentView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    @State var isDone: Bool = false
  
    var body: some View {
        VStack{
            headingView
                .onTapGesture {
                    enableGetStarted()
                }
            descriptionView
            
            if isDone {
                Spacer()
                Button(action: {
             
                }, label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .opacity(isDone ? 1 : 0)
                        .scaleEffect(isDone ? 1 : 0.1)
                        .animation(.spring())
                })
            } else {

                HStack{
                    ProgressView()
                    Text("Fetching products...")
                }
               
            }
        }
        .padding()
        
    
    }
  
    func enableGetStarted() {
        isOnboardingDone = true
        withAnimation {
            isDone = true
        }
     
    }
    var headingView: some View {
        HStack {
            Image(systemName: "cart.fill")
                .imageScale(.large)
                .font(.title)
            Text("Shoppers Stop")
                .font(.title)
                .bold()
        }.foregroundStyle(.orange)
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading){
            Text("Welcome to Shoppers Stop!")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            Text("Your one-stop destination for all your shopping needs. Discover trending products in various categories, and enjoy a seamless shopping experience.")
        }.padding()
       

    }
}



#Preview {
    OnboardingView()
}
