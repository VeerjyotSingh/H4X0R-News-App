//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Veerjyot Singh on 04/06/22.
//

import Foundation

class NetworkManager:ObservableObject{
    
    @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page")
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let result = try decoder.decode(Result.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = result.hits
                            }
                        } catch{
                            print(error)
                        }
                    }
                }
            }
               task.resume()
        }
    }
}

struct Result:Decodable{
    let hits: [Post]
}

struct Post:Decodable, Identifiable{
    var id:String{
        return objectID
    }
    let objectID:String
    let points:Int
    let title:String
    let url:String?
}
