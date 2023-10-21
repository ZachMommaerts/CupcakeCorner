//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Zach Mommaerts on 10/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var email = ""
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        userName.count < 5 || email.count < 5
    }
}

#Preview {
    ContentView()
}
