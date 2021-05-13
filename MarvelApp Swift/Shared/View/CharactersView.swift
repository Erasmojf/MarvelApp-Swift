//
//  CharactersView.swift
//  MarvelApp Swift (iOS)
//
//  Created by Erasmo J.F Da Silva on 13/05/21.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        
        NavigationView{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                VStack(spacing: 15){
                    
                    HStack(spacing: 10){
//                        Image(systemName: "magnifyinglass")
//                            .foregroundColor(.gray)
                        
                        TextField("Search Character", text: $homeData.searchQuery)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                if let characters = homeData.fetchedCharacters{
                    if characters.isEmpty {
                        
                        Text("No Results Found")
                            .padding(.top, 20)
                    }else{
                        ForEach(characters){ data in
                            
                            Text(data.name)
                        }
                    }
                    
                } else{
                    if homeData.searchQuery != ""{
                        ProgressView()
                            .padding(.top, 20)
                    }
                }
            })
            .navigationTitle("Marvel")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
