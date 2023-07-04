//  /*
//
//  Project: Network Calls
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 03.07.2023
//
//  S
//
//  */

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
    
            Circle()
                .foregroundColor(.gray.opacity(0.6))
                .frame(width: 150, height: 150)
            
            Text("Username")
                .bold()
                .font(.title3)
            
            Text("Github")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


