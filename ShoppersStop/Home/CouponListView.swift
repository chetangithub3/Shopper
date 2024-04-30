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
            if cartViewModel.coupons.isEmpty {
                Text("No Coupons")
            } else {
                ScrollView {
                    ForEach(cartViewModel.coupons, id: \.id) { coupon in
                      CouponItem(coupon: coupon)
                    }.padding(.top)
                }
                Spacer()
            }
        }.background(Color.gray.opacity(0.3))
            .navigationTitle("Coupons")
        .task {
            await cartViewModel.fetchCoupons()
        }
    }
}

#Preview {
    CouponListView()
}
