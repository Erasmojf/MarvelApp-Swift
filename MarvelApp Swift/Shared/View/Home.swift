//
//  Home.swift
//  MarvelApp Swift
//
//  Created by Erasmo J.F Da Silva on 13/05/21.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        TabView{
            
            //Characters View
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
                .environmentObject(homeData)
            
            Text("Comics")
                .tabItem { Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
        }
        .padding()
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            
            
    }
}
