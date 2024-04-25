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
                        .padding(.vertical)
                            .foregroundColor(.orange)
                            .overlay {
                                if cartViewModel.totalNumberOfItems != 0  {
                                    ZStack{
                                        Circle()
                                            .foregroundColor(.red)
                                            .frame(width: 15)
                                        Text("\(cartViewModel.totalNumberOfItems)")
                                            .font(.footnote)
                                           
                                            .foregroundStyle(.white)
                                            .minimumScaleFactor(0.5)
                                    }.offset(x: 10, y: -10)
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
