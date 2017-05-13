# http-requests-example

# The Technical Problem
With the enormous volumes of data being generated and downloaded every single day, most modern applications will need to obtain information from or send information to an API in some form or another. Different situations require different ways of sending a HTTP request to an API web server, and in order to most efficiently and effectively do this, a solid understanding of the methods required is necessary. The problem then, is this: what are the different ways an iOS application can send HTTP GET and POST requests to an API web server, and how does one go about doing this in Swift 3?

This article will start by first explaining what a RESTful API is in order to build a solid foundation of what it means when an application sends a HTTP request to a web server. Furthering on that, this article will then explain and walk the reader through the different ways of sending GET and POST requests to a web server through the use of different examples.

# The RESTful API
Representational State Transfer (REST) APIs are web services that provide the ability for computer systems to exchange and make use of information on the Internet, using a uniform and predefined set of stateless operations. This means that no information is kept by the RESTful web service between executions, which allows for fast performance and reliability. When requesting resources from a RESTful API, the network components are treated as a black box whose implementation details are unknown to the requester. A client (e.g. browser/iOS application) does not need to know beforehand about the RESTful web server, the resources it holds, or the structure of its API.

A RESTful API is an API that uses HTTP code to allow two computer systems or software programs to communicate with each other. The API lists out the different calling methods for a developer to write a program that requests resources from its web server. Because RESTful web services rely on HTTP code to do the heavy lifting, a RESTful API is able to reuse any methods and status codes from HTTP instead of using fancy queries and custom code to access data stored in a database. While the main HTTP verbs used by most APIs are GET, POST, PUT and DELETE, any other HTTP methods can be used by a RESTful API.

# How to make a HTTP Request in Swift 3 for iOS
This section will describe and explain how to make HTTP requests in Swift 3 for iOS using Xcode 8, by focusing mainly on the two most commonly used requests, GET and POST, although this can be easily extended to use any other HTTP request. A GET method requests some resource from the API web server, and this should only retrieve data without having any other effect.  Conversely, a POST method requests that the API web server create a new resource as specified in the POST method call. As such, this article will first start by outlining the simpler GET request, and then proceed on to the POST request. This article will not, however, deal with what to do with the resources obtained from a GET request as most APIs typically return JSON data or HTTP redirects. It is much simpler to use API calls that only return JSON data, and then to display the JSON data as it is without parsing it, as the topic of parsing JSON is a topic for another day.
Preliminaries
This article makes use of the free website, Reqres, which is an online REST API for testing and prototyping which returns arbitrary JSON data. The URLs required will be provided in the code snippets below, however the root URL of the website is: https://reqres.in/api/


As this is a tutorial for iOS, the first step would be to create a simple Single View Application. This can be easily done in Xcode 8, using iOS 10.3 as the deployment target. In order to keep things as simple as possible, no UI elements will be used, and all code will be inserted directly into the default ViewController class contained in ViewController.swift.

# GET That Data!
Here is how to make a simple GET request to the sample API server, beginning with the simplest example you can write using URLSession, which gives the ability to load data asynchronously from an API web server. A URLSession can perform three types of tasks:
data tasks for sending and receiving data, intended for short requests, e.g. requesting a web server for some data (which is what we’re doing)
download tasks for downloading files, which also supports background downloads while the app is not running
upload tasks for uploading files, which also supports background uploads while the app is not running and can do some things that data tasks do

For the purposes of keeping things simple, we will only focus on data tasks.

    // simplest GET request using shared URLSession
    func getRequestSimple() {
        let session = URLSession.shared
        let urlString = URL(string: "https://reqres.in/api/users/1")
        if let urlToBeUsed = urlString {
            let task = session.dataTask(with: urlToBeUsed) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let outputString = String(data: data!,encoding: String.Encoding.utf8) {
                        	print("GET request example 1")
print(outputString)
                    }
                }
            }
            task.resume()
        }
    }

An important line that is often missed is task.resume(), which actually starts the task. One thing to note about this example is the use of URLSession.shared, which is for basic requests as it is created without a configuration object, used to define the connection behaviour of a URLSession, e.g. caching policies, connection requirements, and support for background downloads. Using a shared URLSession allows for requests to be made to a web server with minimal setup required. Again, there are several types of configuration objects, variants of the URLSessionConfiguration class. These are default, ephemeral, and background, but this article will only focus on default sessions. The latter two commonly used for more advanced tasks; ephemeral sessions are commonly used for privacy and potentially sensitive data, while background sessions are needed for background uploads and downloads of files when an app is not running. A default session is similar to a shared URLSession without further customisation, except that it allows for obtaining data incrementally as the data arrives from the web server. It is simple to create a default session, with only the addition of one line of code, and the modification of another:

       // this line specifies the default URLSessionConfiguration as newConfig
     	let newConfig = URLSessionConfiguration.default
// this line now specifies a URLSession with newConfig as its configuration object
       let session = URLSession(configuration: newConfig)

The first example performs a data task of the form dataTask(with: URL), in which it was called as session.dataTask(with: urlToBeUsed). This is the most basic form of data task, in which only the URL of the API is used in the creation of the task. However, there are more ways that a data task can be specified by using a URLRequest object. This is used to specify certain behaviours of the data task, e.g. the HTTP method to be used,  the cache policy and the HTTP body (used in a POST request). With that said, the next logical step to take would be to make a POST request using a URLRequest object.

# POST That Data!
A POST request is accompanied with an enclosed message body which is the data to be POSTed to the web server. This can be in the form of a new database item, login credentials, web form data and much more. Because Reqres takes JSON data as input for POST requests, a simple JSON data entry is created in the example below. 

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

In order to set the HTTP method of the data task to be a POST request, a URLRequest object is made which takes a URL as input. The HTTP method can then be assigned by writing requestToPost.httpMethod = “POST’, followed by the addition of the HTTP message body given by requestToPost.httpBody = jsonData. This example also shows how to specify the URLRequest object in the data task, given as dataTask(with: requestToPost).

It is also worth noting that Reqres fakes the processing of creating actual new data in its database when data is POSTed to it. In the example below, Reqres will return some arbitrary user ID and time of user creation upon performing the POST request, as can be seen when the above example is run:

{"{\"first_name\":\"John\",\"last_name\":\"Doe\"}":"","id":"496","createdAt":"2017-05-12T23:52:34.293Z"}

Conclusion
I hope that this technical article has been informative and useful in forming a solid foundation for understanding HTTP requests in Swift 3 and how to use them using URLSessions. Of course, there is much, much more that can be done and learnt about API calls and URLSession, but I hope that this article has been a good read. It is clear that there are very many ways one can send a HTTP request to an API web server, and some ways work better for some situations, depending on what data needs to be sent or received and how it should be sent.
