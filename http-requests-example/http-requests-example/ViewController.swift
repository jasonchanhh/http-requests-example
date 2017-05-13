//
//  ViewController.swift
//  http-requests-example
//
//  Created by Jason Chan on 09/05/2017.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // simplest GET request using shared URLSession
    func getRequestSimple() {
        let session = URLSession.shared
        let urlString = URL(string: "https://reqres.in/api/users/1")
        if let url = urlString {
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let dataString = String(data: data!,encoding: String.Encoding.utf8) {
                        print("GET request example 1")
                        print(dataString)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    // GET request using default URLSessionConfiguration
    func getRequestDefaultConfig() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = URL(string: "https://reqres.in/api/unknown/1")
        if let url = urlString {
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let dataString = String(data: data!,encoding: String.Encoding.utf8) {
                        print("GET request example 2")
                        print(dataString)
                    }
                }
            }
            task.resume()
        }
    }
    
    // POST request using URLRequest
    func postRequestSimple() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = URL(string: "https://reqres.in/api/users")
        if let urlToBeUsed = urlString {
            var requestToPost = URLRequest(url: urlToBeUsed)
            requestToPost.httpMethod = "POST"
            let newData: [String: Any] = ["first_name": "John", "last_name": "Doe"]
            let jsonData: Data
            do {
                jsonData = try JSONSerialization.data(withJSONObject: newData, options: [])
                requestToPost.httpBody = jsonData
            } catch {
                print("Error: cannot create JSON")
                return
            }
            let task = session.dataTask(with: requestToPost) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let outputString = String(data: data!,encoding: String.Encoding.utf8) {
                        print("POST request example 1")
                        print(outputString)
                    }
                }
            }
            task.resume()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequestSimple()
        getRequestDefaultConfig()
        postRequestSimple()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

