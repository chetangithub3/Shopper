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
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .foregroundColor(.orange)
                            )
                            .padding(.horizontal)
                            .overlay {
                                if !cartViewModel.cartItems.isEmpty {
                                  
                                    VStack{
                                        HStack{
                                            Spacer()
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.red)
                                                    .frame(width: 20)
                                                Text("\(cartViewModel.cartItems.count)")
                                                    .foregroundStyle(.white)
                                            }
                                         
                                        }
                                      
                                        Spacer()
                                    }
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
