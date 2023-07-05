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
    
    func getUser() async throws -> GitHubUser {
        
        let endpoint = "https://api.github.com/users/Elaidzha1940"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invaliResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GitHubUser: Codable {
    
    let login: String
    let avatarUrl: String
    let bio: String
}

enum GHError: Error {
    
    case invalidURL
    case invaliResponse
}
