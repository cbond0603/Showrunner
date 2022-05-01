//
//  Shows.swift
//  Showrunner
//
//  Created by Chris Bond on 4/30/22.
//

import Foundation

class Shows {
    struct Returned: Codable {
        var show: Show
    }

    var showArray: [Returned] = []

    var urlString = "https://api.tvmaze.com/search/shows?q=alien"

    func getData(completed: @escaping () -> ()) {        
        print("🕸🕸 We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("🤬 ERROR: Couldn't create a URL from \(urlString)")
            completed()
            return
        }
        
        //Create Session
        let session = URLSession.shared
        
        //get data with .datatask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🤬 ERROR: \(error.localizedDescription)")
            }
            //deal with data
            do {
                let returned = try JSONDecoder().decode([Returned].self, from: data!)
                self.showArray = returned
                print("Here is what we returned \(self.showArray)")
            } catch {
                print("🤬 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}



