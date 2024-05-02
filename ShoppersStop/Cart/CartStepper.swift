//
//  CartStepper.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import SwiftUI

struct CartStepper: View {
    @Binding var itemCount: Int
    let range: ClosedRange<Int>

    var body: some View {
        HStack {
            Button {
                if self.itemCount > self.range.lowerBound {
                    self.itemCount -= 1
                }
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(self.itemCount > self.range.lowerBound ? .white : .gray)
            }

            Text("\(itemCount)")
                .bold()
                .foregroundStyle(.white)
            Button {
                if self.itemCount < self.range.upperBound {
                    self.itemCount += 1
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(self.itemCount < self.range.upperBound ? .white : .gray)
            }
        }
    }
}

#Preview {
    CartStepper(itemCount: .constant(10), range: 0...10)
}
