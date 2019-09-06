//
//  EmbeddedEngineView.swift
//  Zai Likh
//
//  Created by Victor Poon on 6/9/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//

import UIKit
import SwiftUI
import WebKit

struct EmbeddedEngineView: UIViewRepresentable {    // struct, not class
    typealias UIViewType = WKWebView
    
    var numberOfPages: Int = 0
    @Binding var currentPage: Int
    
    func makeUIView(context: UIViewRepresentableContext<EmbeddedEngineView>) -> WKWebView {
        let control =  WKWebView()
        return control
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<EmbeddedEngineView>) {
        
    }
    
}
