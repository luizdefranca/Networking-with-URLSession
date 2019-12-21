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
We have four subclass of URLSessionTask
 1 - URLSessionDataTask - returns the response as an object in memory
 2 - URLSessionUploadTask - similar to URLSessionDataTask but it makes easier to provide a request body
 3 - URLSessionDownloadTask - doesn't return the response in memory but writes the data to a file
    and returns the location of the file
 * 4 - URLSessionStreamTask - saves the response in a temporary files similar to URLSessionDownloadTask.
    It's used to create a bidirectional TCP/IP connections.

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
//let json = "{'hello': 'world'}"
//let urlPost = URL(string: "http://httpbin.org/post")!
//var request = URLRequest(url: urlPost)
//request.httpMethod = "Post"
//request.httpBody = json.data(using: .utf8)
//
//let newSession = URLSession(configuration: .default)
//let newTask = newSession.dataTask(with: request) { (data, response, error) in
//
//    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//        print("Error")
//        return
//    }
//
//    guard let data = data, let postResponse = String(data: data, encoding: .utf8) else {
//        print(error.debugDescription)
//        return
//    }
//    print(postResponse)
//     PlaygroundPage.current.finishExecution()
//
//}
//newTask.resume()

/*
Task Priorities
 All the task has a priority that determines what level for the task run at.
 It has a range from 0.0 to 1.0, and the default values is 0.5

 Cache Policies
 The default configuration object use a persistent disk based cache of responses to requests.
 If it's necessary to change the cache policy, we have to check the documentation for NSURL request
 used protocol cache policy.

 The URLSession has two method to handle when we need an upload task or an download task.
 The upload task doesn't use delegate for response and data delivery but delegate methods for handling
 authentication challenges.
 When you use upload task you can't use URL class for creating the task, instead you have to use
 URLRequest class.
 UploadTask method has an additional parameter that corresponds to the data that you want to upload.
 This data you must to put into request HTTP body.

 URLSession -> URLSessionDelegate Protocol - UISessionDelegate
 Life Cycle Methods -> URLSessionTaskDelegate Protocol - UISessionTaskDelegate
 UploadTask -> URLSessionDataDelegate
 DownloadTask -> URLSessionDownloadDelegate
 Streaming -> URLSessionStreamDelegate
 */


//UPLoading a image to server
/*

class SessionDelegate: NSObject, URLSessionDataDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didSendBodyData bytesSent: Int64, totalBytesSent: Int64,
                    totalBytesExpectedToSend: Int64) {
        let progress = round(Float(totalBytesSent) * 100 / Float(totalBytesExpectedToSend))
        print("progress: \(progress) %")

    }
 }

let image = UIImage(named: "mojave.jpg")
let imageData = image?.jpedData(compressionQuality: 1.0)
let uploadURL = URL(string: "http://localhost:5000/upload")!
let request = URLRequest(url: uploadURL)
let request.httpMethod = "POST"
let task = URLSession.shared.uploadTask(with: request, from: imageData) {
    (data, response, error)  in
    let serverResponse = String(data: data!, encoding: .uft8)
    print(serverResponse!)
 }

 task.resume()

// Example using session delegate to map the upload progress

 let sessionWithDelegate = URLSession(configuration: .default, delegate: SessionDelegate(),
    delegateQueue: OperationQueue.main)

 let taskWithDelegate = sessionWithDelegate.uploadTask(with: request, from: imageData) {
    (data, response, error) in
    let serverResponse = String(data: data!, encoding: .utf8)
    print(serverResponse)
 }
 taskWithDelegate.resume()
 
 */



//let upConfiguration = URLSessionConfiguration.background(withIdentifier: "com.myuploadMethod")
//let upSession = URLSession(configuration: upConfiguration)
//let upTask = upSession.uploadTask(with: <#T##URLRequest#>, from: <#T##Data#>)

/*
 Background session


 */

//class SessionDelegate: NSObject, URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let localFilePath: (URL) -> URL = { url in
//
//            return documentsPath.appendingPathComponent(url.lastPathComponent)
//        }
//
//
//        guard let sourceURL = downloadTask.originalRequest?.url else { return }
//
//
//        let destionationURL = localFilePath(sourceURL)
//
//        let fileManager = FileManager.default
//
//
//    }
//
//
//}
//
//let configuration = URLSessionConfiguration.background( withIdentifier: "com.luizramos.prefetch")
//configuration.networkServiceType = .background
//let session = URLSession(configuration: configuration, delegate: SessionDelegate(), delegateQueue: nil)
//
//
//
//PlaygroundPage.current.finishExecution()

/*
URL - Uniform Resource Locator
HTTP - HyperText Transfer Protocol
 Post - Create
 Get - Read
 Put - Update
 Delete - Delete
 Head - get headers only, it's similar to get, but without the data. It's useful if you only need
 the metadata for a large amount of data, to check whether to check if you need to download it or
 wheter to store it in a file instead of your memory. The default cache method uses this method to
 see if the data changed.

 The client makes a request which is a message and receives a response from the server according
 to the verb request (post, get, put, etc). The message has a body and header.

  *** Content Types ***

 content type specifies the internet media type of the data conveyed by the HTTP message.

 Content Types for text data:
 - application/json - most common for app clients
 - application/x-www-form-urlencoded - uses form-encoded, which looks like a query string
 - text/html

 Content types for binary data:
 - application/pdf
 - image/png, image/jpeg, image/gif
 - multipart/form-data - when the client send any kind of binary file, as well as text elements.

 *** URLSession ***
 - allowsCellularAccess -> It's used to specify if the app should only use wi-fi or not
 - waitsForConnectivity -> removes the need for network notifications. We have to set it to true in
 a non-background configuration and if the user loses network while your task is running, the system
 will periodically check for network and retry your task.

 - {
    multipathServiceType = .handover
    allowsCellularAccess = true
    } -> if your task transfer only small amount of data when there's no wi-fi, you might be able
    to use multipath TCP.
    There are two main type:
    .handover -> switches to cellular when your app loses wif-i
    .interactive -> switches to cellular when wi-fi signal gets weak

 *** URLSessionTasks ***

 1 - URLSessionDataTask
    * response in memory
    * not supported in background sessions
 2 - URLSessionUploadTask
    * easier to provide request body
 3 - URLSessionDownloadTask
    * response written to file on disk

 *** URLSessionDataTask ***
    - func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
        -> default method to get
    - func dataTask(with: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) - Void)
        -> used for post and put requests
    -   func dataTask(with: URL)
        func dataTask(with: URLRequest)
        -> They are used for more complex transfer where you need to monitor progress or handle
        intermediate response data. This session must has delegate and implements relevant delegate
        methods.





 */

let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=abba"
let newUrl = URL(string: urlString)
newUrl?.absoluteString
newUrl?.scheme
newUrl?.host
newUrl?.path
newUrl?.query
newUrl?.baseURL


//Using urlComponents
let baseURl = "https://itunes.apple.com"
var urlComponents = URLComponents(string: baseURl)
urlComponents?.path = "/search"
urlComponents?.query = "media=music&entity=song&term=abba"
let createdURL = urlComponents?.url

//Using relativeTo

let baseURL2 = URL(string: "https://itunes.apple.com")
let relativeURL = URL(fileURLWithPath: "search", relativeTo: baseURL2)

//Another way
var urlComponents2 = URLComponents(string: urlString)
let queryItem = URLQueryItem(name: "term", value: "crowded house")
urlComponents2?.queryItems?.append(queryItem)
urlComponents2?.url

//URL-encode "smiling cat"
let queryEmojiItem = URLQueryItem(name: "emoji", value: "😻")
urlComponents2?.queryItems?.append(queryEmojiItem)
urlComponents2?.url

let challengeURl = baseURl

let configuration = URLSessionConfiguration.ephemeral
configuration.allowsCellularAccess = true
configuration.waitsForConnectivity = true
configuration.multipathServiceType = .handover
configuration.urlCache?.diskCapacity
configuration.urlCache?.memoryCapacity

//creating a cache to set to ephemeral Session Configuration

let cache = URLCache(memoryCapacity: 512_000, diskCapacity: 10_000_000, diskPath: nil)
configuration.urlCache = cache
configuration.urlCache?.diskCapacity
configuration.urlCache?.memoryCapacity

let mySession = URLSession(configuration: configuration)
let secondSession = URLSession(configuration: .default)



