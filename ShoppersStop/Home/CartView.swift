//
//  CartView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        VStack(spacing: 0){
            if !viewModel.cartItems.isEmpty {
                ScrollView{
                    ForEach(viewModel.cartItems.sorted(by: { $0.key.id < $1.key.id }), id: \.key.id) { (key, value) in
                        CartItem(cartItem: (key,value))
                    }
                }
                
                NavigationLink {
                    CouponListView().environmentObject(viewModel)
                } label: {
                        HStack {
                            if let couponApplied = viewModel.selectedCoupon {
                                Spacer()
                                Text("'\(couponApplied.name)' applied")
                                    .bold()
                                    .padding()
                                Spacer()
                            } else {
                                Text("Apply coupon").bold()
                                    .padding(.horizontal)
                                Spacer()
                                VStack{
                                    Image(systemName: "arrow.right")
                                         .resizable()
                                         
                                         .foregroundColor(.black)
                                         .frame(width: 25, height: 25)
                                         .padding()
                                         .cornerRadius(8)
                                         .border(.black, width: 2)
                                }.background(Color.white)
                                    .buttonBorderShape(.capsule)
                                    .border(.black, width: 4)
                            }
                          
                          
                        }
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(8)
                    
                }.padding()

              

                if let selectedCoupon = viewModel.selectedCoupon {
                    VStack(spacing: 12){
                        HStack {
                            Text("Cart total: ")
                            Spacer()
                            Text("\(String(format: "%.2f", viewModel.cartTotal))")
                        }
                            HStack {
                                Text("Coupon applied: ")
                                Spacer()
                                Text("-\(String(format: "%.2f", viewModel.discountedAmount))")
                            }.foregroundColor(.orange)
                            Divider()
                    }.padding()
                }
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text("\(String(format: "%.2f", viewModel.totalPrice))")
                }.padding([.horizontal, .bottom])
                    .bold()
                Button(action: {
                            
                           }) {
                               Text("Checkout")
                                   .foregroundColor(.white)
                                   .font(.headline)
                                   .padding()
                                   .frame(maxWidth: .infinity)
                                   .background(Color.orange)
                                   .cornerRadius(10)
                           }
                           .padding(.horizontal)
            } else {
                Text("Cart is empty")
            }
        }.navigationTitle("Your Cart")
            .navigationBarItems(trailing: Text("^[\(viewModel.totalNumberOfItems) Item](inflect: true)").foregroundStyle(.orange))
    }
}
extension NumberFormatter {
    static var twoDecimalPlaces: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
struct CartItem: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var count = 1
    var totalCost : Int {
        return cartItem.0.price * count
    }
    var cartItem: (Product, Int)
    init(cartItem: (Product, Int)) {
        self.cartItem = cartItem
        _count = State(initialValue: cartItem.1)
        
    }
    var body: some View {
        
        HStack {
            if let thumbnail = cartItem.0.thumbnail {
                ImageView(imageURLString: thumbnail)
                    .scaledToFill()
                    .frame(width: getScreenBounds().width / 5, height: getScreenBounds().width / 5)
                    .clipped()
                    .cornerRadius(10)
                    .padding(4)
            }
            VStack(alignment: .leading, spacing: 10){
                Text(cartItem.0.title)
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .bold()
                Text(cartItem.0.category.capitalized)
                    .font(.caption)
                   
            }
                
            Spacer()
            VStack(alignment: .trailing){
                Text("$\(totalCost)")
                    .foregroundStyle(.white)
                    .bold()
                
                Spacer()
                CartStepper(itemCount: $count, range: 0...10)
                    .onChange(of: count) { oldValue, newValue in
                        if newValue == 0 {
                            cartViewModel.removeProduct(product: cartItem.0)
                        } else {
                            cartViewModel.updateQuantity(product: cartItem.0, quantity: count)
                        }
                    }
            }.padding()
        }.background(Color.orange.opacity(0.7).gradient)
            .cornerRadius(10)
            .padding([.horizontal, .top])
           
    }
}
extension Color {
    static let customYellow = Color(UIColor(red: 1.0, green: 0.615, blue: 0.110, alpha: 1.0))
 
}
#Preview {
    CartView()
}
