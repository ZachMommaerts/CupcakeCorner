//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Zach Mommaerts on 10/23/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderWrapper: OrderWrapper
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                TextField("Street Address", text: $orderWrapper.order.streetAddress)
                TextField("City", text: $orderWrapper.order.city)
                TextField("Zip", text: $orderWrapper.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderWrapper: orderWrapper)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderWrapper.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(orderWrapper: OrderWrapper())
}
