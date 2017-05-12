# http-requests-example

# The Technical Problem
With the enormous volumes of data being generated and downloaded every single day, most modern applications will need to obtain information from or send information to an API in some form or another. Different situations require different ways of sending a HTTP request to an API web server, and in order to most efficiently and effectively do this, a solid understanding of the methods required is necessary. The problem then, is this: what are the different ways an iOS application can send HTTP GET requests to an API web server, and how does one go about doing this in Swift 3?

This article will start by first explaining what a RESTful API is in order to build a solid foundation of what it means when an application sends a HTTP request to a web server. Furthering on that, this article will then explain and walk the reader through the different ways of sending GET requests to a web server through the use of different examples.

# The RESTful API
Representational State Transfer (REST) APIs are web services that provide the ability for computer systems to exchange and make use of information on the Internet, using a uniform and predefined set of stateless operations. This means that no information is kept by the RESTful web service between executions, which allows for fast performance and reliability. When requesting resources from a RESTful API, the network components are treated as a black box whose implementation details are unknown to the requester. A client (e.g. browser/iOS application) does not need to know beforehand about the RESTful web server, the resources it holds, or the structure of its API.

A RESTful API is an API that uses HTTP code to allow two computer systems or software programs to communicate with each other. The API lists out the different calling methods for a developer to write a program that requests resources from its web server. Because RESTful web services rely on HTTP code to do the heavy lifting, a RESTful API is able to reuse any methods and status codes from HTTP instead of using fancy queries and custom code to access data stored in a database. While the main HTTP verbs used by most APIs are GET, POST, PUT and DELETE, any other HTTP methods can be used by a RESTful API.

# How to make a HTTP Request in Swift 3 for iOS
This section will describe and explain how to make HTTP requests in Swift 3 for iOS using Xcode 8, by focusing mainly on one of the most commonly used requests, GET, although this can be easily extended to use any other HTTP request. A GET method requests some resource from the API web server, and this should only retrieve data without having any other effect. As such, this article will outline the simple GET request. This article will not, however, deal with what to do with the resources obtained from a GET request.

## Preliminaries
This article makes use of the free website, JSON Placeholder, which is an online REST API for testing and prototyping which returns arbitrary JSON data. The URLs required will be provided in the code snippets below, however the root URL of the website is: 
https://jsonplaceholder.typicode.com/
As this is a tutorial for iOS, the first step would be to create a simple Single View Application. This can be easily done in Xcode 8, using iOS 10.3 as the deployment target. In order to keep things as simple as possible, no UI elements will be used, and all code will be inserted directly into the default ViewController class contained in ViewController.swift.

## GET That Data!
Here is how to make a simple GET request to the sample API server.

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
        }
