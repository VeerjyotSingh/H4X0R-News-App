//
//  ContentView.swift
//  H4X0R News
//
//  Created by Veerjyot Singh on 04/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){ posts in
                NavigationLink(destination: DetailView(url: posts.url)) {
                    HStack{
                        Text(String(posts.points))
                        Text(posts.title)
                    }
                }
            }
            .navigationBarTitle("H4X0R")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 15 Pro"))
    }
}
