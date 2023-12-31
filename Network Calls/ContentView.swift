//  /*
//
//  Project: Network Calls
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 03.07.2023
//
//  Status | Complited
//
//  */

import SwiftUI

struct ContentView: View {
    
    @State private var user: GitHubUser?
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.7)
            VStack{
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(.gray.opacity(0.6))
                }
                .frame(width: 150, height: 150)
                
                Text(user?.login ?? "Login Placeholder")
                    .bold()
                    .font(.title3)
                
                Text(user?.bio ?? "Bio Placeholder")
                    .padding()
                
                Spacer()
            }
            .padding(.top, 70)
        }
        .ignoresSafeArea()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidURL{
                print("invalid URL")
            } catch GHError.invaliResponse {
                print("invalid response")
            } catch GHError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    func getUser() async throws -> GitHubUser {
        
        let endpoint = "https://api.github.com/users/elaidzha1940"
        
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
            throw GHError.invalidData
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
    case invalidData
}
