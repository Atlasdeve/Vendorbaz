//
//  ContentView.swift
//  Vendorbaz
//
//  Created by Atlas on 9/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "https://vendorbaz.com/")!)
            .edgesIgnoringSafeArea(.all)
    }
}
