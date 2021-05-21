//
//  WebView.swift
//  MarvelApp Swift (iOS)
//
//  Created by Erasmo J.F Da Silva on 21/05/21.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView{
        
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

