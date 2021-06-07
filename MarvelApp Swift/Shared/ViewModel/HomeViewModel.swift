//
//  HomeViewModel.swift
//  MarvelApp Swift (iOS)
//
//  Created by Erasmo J.F Da Silva on 13/05/21.
//

import SwiftUI
import Combine
import CryptoKit


class HomeViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    
    var searchCancellable: AnyCancellable? = nil
    
    @Published var fetchedCharacters: [Character]? = nil
    
    @Published var fetchedComics: [Comic]? = []
    @Published var offset: Int = 0
    
    init(){
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == ""{
                    
                    self.fetchedCharacters = nil
                    
                }else{
                    self.searchCharacter()
                }
            })
    }
    
    func searchCharacter(){
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url =  "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){
            (data,_, err) in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("No data found")
                return
            }
            
            do{
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                DispatchQueue.main.async {
                    
                    if self.fetchedCharacters == nil{
                         self.fetchedCharacters = characters.data.results
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    
    func MD5(data: String) -> String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func fetchComics(){
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        let url =  "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){
            (data,_, err) in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("No data found")
                return
            }
            
            do{
                let characters = try JSONDecoder().decode(APIComicResult.self, from: APIData)
                DispatchQueue.main.async {
                    self.fetchedComics = characters.data.results
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
