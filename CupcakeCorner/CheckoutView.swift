//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Zach Mommaerts on 10/23/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderWrapper: OrderWrapper
    
    @State private var alertMessage = ""
    @State private var showingConfirmation = false
    @State private var showingFailure = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(orderWrapper.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {  }
        } message: {
            Text(alertMessage)
        }
        .alert("An error occured.", isPresented: $showingFailure) {
            Button("OK") {  }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderWrapper) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: ("https://reqres.in/api/cupcakes"))!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderWrapper.self, from: data)
            alertMessage = "Your order for \(decodedOrder.order.quantity)x \(Order.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            alertMessage = "There was an issue processing your order. Please try again at a later time."
            showingFailure = true
        }
    }
}

#Preview {
    CheckoutView(orderWrapper: OrderWrapper())
}
