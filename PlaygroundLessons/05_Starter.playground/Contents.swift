import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## URLSession Cookbook 2: POST DataTask
let session = URLSession(configuration: .ephemeral)

struct HTTPMethod {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let patch = "PATCH"
}

enum HttpMethod : String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

let url = URL(string: "http://localhost:3000/posts/")!

var urlRequest = URLRequest(url: url)

urlRequest.httpMethod = HTTPMethod.get




let task = session.dataTask(with: url)
task.currentRequest?.url
task.currentRequest?.description
task.currentRequest?.httpMethod
task.currentRequest?.allowsCellularAccess // = false  // error: currentRequest is read-only
task.currentRequest?.httpShouldHandleCookies
task.currentRequest?.timeoutInterval

task.currentRequest?.cachePolicy
task.currentRequest?.networkServiceType
task.currentRequest
task.currentRequest?.allHTTPHeaderFields
//: ### POST DataTask with URLRequest
//: __TODO 1 of 13:__ To create a data task with a custom request, first create your request:
var request = URLRequest(url: url)

//: __TODO 2 of 13:__ `URLRequest` is a struct, so declaring it as `var` allows us to modify its properties.
//: Specify a non-default cache policy and a network service type:
request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
request.networkServiceType = .background

//: __TODO 3 of 13:__ Specify this request accesses the network only on wi-fi —
//: faster, less battery drain, and it preserves the user's data quota:
request.allowsCellularAccess = false

//: __TODO 4 of 13:__ When the request is ready, create the data task:
let taskWithRequest = session.dataTask(with: request)
//: __TODO 5 of 13:__ Check the task's `httpMethod` property:
taskWithRequest.currentRequest?.httpMethod
//: __TODO 6 of 13:__ Change the request's `httpMethod` property to __POST__:
request.httpMethod = HTTPMethod.post
//: __TODO 7 of 13:__ To send JSON, not an encoded form, set the header field __content-type__ to __application/json__:
request.addValue("application/json", forHTTPHeaderField: "content-type")
//: __TODO 8 of 13:__ A POST task __sends__ data, so JSON-encode a `Post` object for the request's `httpBody`:
struct Post: Codable {
//  let id: Int
  let author: String
  let title: String
}


let myPost = Post(author: "Luiz" , title: "Any Title")

do {
    let data = try JSONEncoder().encode(myPost)
    request.httpBody = data
} catch let error {
    error.localizedDescription
    PlaygroundPage.current.finishExecution()
}




//: __TODO 9 of 13:__ Check the `taskWithRequest` properties:
taskWithRequest.currentRequest?.httpMethod
//: __TODO 10 of 13:__ Just one setting shows that you must set up the request completely _before_ creating the task, so create another task, with the now-complete `request`, and set up its handler to JSON-decode the response data:
let newTask = session.dataTask(with: request) { data, response, error in

    defer { PlaygroundPage.current.finishExecution()}

    guard let data = data, let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 201 else {
            print("DataTask Error: \(error!.localizedDescription)")
            return
    }

    print(httpResponse.statusCode)
    do {
        let post = try JSONDecoder().decode(Post.self, from: data)
        dump(post)
    } catch let decodeError {
        print("JSONDecoder Error: \(decodeError.localizedDescription)")
        return
    }

}





//: __TODO 11 of 13:__ Check the task's `httpMethod`, header fields and `httpBody`:
newTask.currentRequest?.httpMethod
newTask.currentRequest?.allHTTPHeaderFields
newTask.currentRequest?.httpBody



//: __TODO 12 of 13:__ `resume` the task, to run it:
newTask.resume()


//: __TODO 13 of 13:__ Comment out the `resume` line, then check the task's `httpBody` again:

newTask.currentRequest?.httpBody
