import UIKit
import PlaygroundSupport
/*
let mySharedSession = URLSession.shared

mySharedSession.configuration.allowsCellularAccess
mySharedSession.configuration.allowsCellularAccess = false
mySharedSession.configuration.allowsCellularAccess


let myDefaultConfiguration = URLSessionConfiguration.default
let eConfig = URLSessionConfiguration.ephemeral
let bConfig = URLSessionConfiguration.background(withIdentifier: "code.luizramospe.sessions")


myDefaultConfiguration.allowsCellularAccess
myDefaultConfiguration.allowsCellularAccess = false
myDefaultConfiguration.allowsCellularAccess

let myDefaultSession = URLSession(configuration: myDefaultConfiguration)
myDefaultSession.configuration.allowsCellularAccess

let defaultSession = URLSession(configuration: .default)

/*
We have three subclass of URLSessionTask
 1 - URLSessionDataTask - returns the response as an object in memory
 2 - URLSessionUploadTask - similar to URLSessionDataTask but it makes easier to provide a request body
 3 - URLSessionDownloadTask - doesn't return the response in memory but writes the data to a file
    and returns the location of the file

 */


let configuration = URLSessionConfiguration.default
configuration.waitsForConnectivity = true
let session = URLSession(configuration: configuration)

let urlString = "https://jsonplaceholder.typicode.com/users"
let url = URL(string: urlString)!
let task = session.dataTask(with: url) {
    data, response, error in

    guard let httpResponse = response as? HTTPURLResponse,
    httpResponse.statusCode == 200 else {
        return
    }

    guard let data = data else {
        print(error.debugDescription)
        return
    }

    if let result = String(data: data, encoding: .utf8) {
        print(result)
    }

    PlaygroundPage.current.finishExecution() //Used to finish the automatic execution of playground

}
task.resume()
*/
let json = "{'hello': 'world'}"
let urlPost = URL(string: "http://httpbin.org/post")!
var request = URLRequest(url: urlPost)
request.httpMethod = "Post"
request.httpBody = json.data(using: .utf8)

let newSession = URLSession(configuration: .default)
let newTask = newSession.dataTask(with: request) { (data, response, error) in

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        print("Error")
        return
    }

    guard let data = data, let postResponse = String(data: data, encoding: .utf8) else {
        print(error.debugDescription)
        return
    }
    print(postResponse)
     PlaygroundPage.current.finishExecution()

}
newTask.resume()


