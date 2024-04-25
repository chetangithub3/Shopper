//
//  CouponListView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/24/24.
//

import SwiftUI

struct CouponListView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        VStack {
         
           
            ForEach(cartViewModel.coupons, id: \.id) { coupon in
              CouponItem(coupon: coupon)
            }
        }.task {
            await cartViewModel.fetchCoupons()
        }
    }
}


struct CouponItem: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    var coupon: Coupon
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        HStack{
            Image(systemName: "dollarsign.square.fill")
                .frame(width: 100, height: 100)
            VStack{
                Text(coupon.name)
                    .font(.title)
                Text(coupon.code)
            }
            Button {
                cartViewModel.selectedCoupon = coupon
                
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Apply")
            }

            
        }
    }
}
#Preview {
    CouponListView()
}
