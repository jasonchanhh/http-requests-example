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
        print("GET request example 1")
        let session = URLSession.shared
        let urlString = URL(string: "https://reqres.in/api/users/1")
        if let url = urlString {
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let dataString = String(data: data!, encoding: String.Encoding.utf8) {
                        print(dataString)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    // GET request using default URLSessionConfiguration
    func getRequestDefaultConfig() {
        print("GET request example 2")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = URL(string: "https://reqres.in/api/users?page=2")
        if let url = urlString {
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let dataString = String(data: data!, encoding: String.Encoding.utf8) {
                        print(dataString)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getRequestWithParams() {
        print("GET request example 3")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = URL(string: "https://reqres/api/unknown")
        if let url = urlString {
            let request = URLRequest(url: url)
            request.httpMethod = "GET "
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequestSimple()
        getRequestDefaultConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

