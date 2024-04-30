//
//  CouponItem.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/30/24.
//

import SwiftUI

struct CouponItem: View {

    @EnvironmentObject var cartViewModel: CartViewModel
     var coupon: Coupon
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "dollarsign.square")
                .resizable()
                .scaledToFill()
                .foregroundColor(.orange)
                .frame(width: 50, height: 50)
                .padding(.leading)
            VStack(alignment: .leading) {
                Text(coupon.code)
                    .font(.title3)
                Text(coupon.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }.padding()
            Spacer()
            Button {
                cartViewModel.selectedCoupon = coupon
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(cartViewModel.selectedCoupon?.code == coupon.code ? "Applied" : "Use")
                    .foregroundStyle(.orange)
                    .font(.subheadline)
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .border(.orange, width: 2)
                    .cornerRadius(4)
                    .padding(.horizontal)
                    .disabled(cartViewModel.selectedCoupon == coupon)
            }
        }.background(Color.white)
            .cornerRadius(4)
            .padding(.horizontal)
    }
}
