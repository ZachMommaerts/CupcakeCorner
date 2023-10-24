//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Zach Mommaerts on 10/23/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddressView(order: Order())
}
