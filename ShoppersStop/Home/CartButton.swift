//
//  CartButton.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct CartButton: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                NavigationLink {
                    CartView().environmentObject(cartViewModel)
                } label: {
                    
                        Image(systemName: "cart.fill")
                        .font(.title)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .foregroundColor(.orange)
                            )
                            .padding(.horizontal)
                            .overlay {
                                if cartViewModel.totalNumberOfItems != 0  {
                                    ZStack{
                                        Circle()
                                            .foregroundColor(.red)
                                            .frame(width: 20)
                                        Text("\(cartViewModel.totalNumberOfItems)")
                                            .foregroundStyle(.white)
                                    }.offset(x: 22, y: -22)
                                }
                            }
                        
                     
                        
                    
                    
                }
            }
        }
    }
}

struct CartCountIndicator: View {
    var count: Int
    var body: some View{
        VStack{
            
        }
    }
}
#Preview {
    CartButton()
}
