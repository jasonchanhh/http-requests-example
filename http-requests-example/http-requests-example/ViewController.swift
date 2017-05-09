//
//  ViewController.swift
//  http-requests-example
//
//  Created by Jason Chan on 09/05/2017.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //simple GET request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = URL(string: "https://jsonplaceholder.typicode.com/users/2")
        if let url = urlString {
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let dataString = data {
                        print(dataString)
                    }
                }
            }
            task.resume()
        }    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

