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

class SessionDelegate: NSObject, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localFilePath: (URL) -> URL = { url in

            return documentsPath.appendingPathComponent(url.lastPathComponent)
        }


        guard let sourceURL = downloadTask.originalRequest?.url else { return }


        let destionationURL = localFilePath(sourceURL)

        let fileManager = FileManager.default
        

    }


}

let configuration = URLSessionConfiguration.background( withIdentifier: "com.luizramos.prefetch")
configuration.networkServiceType = .background
let session = URLSession(configuration: configuration, delegate: SessionDelegate(), delegateQueue: nil)



PlaygroundPage.current.finishExecution()
