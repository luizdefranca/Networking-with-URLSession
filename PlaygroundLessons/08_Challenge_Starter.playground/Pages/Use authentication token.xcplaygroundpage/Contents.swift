import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Authentication Challenge: How to use an authentication token
let config = URLSessionConfiguration.default
config.waitsForConnectivity = true
let session = URLSession(configuration: config)
//: Endpoints for web app:
let baseURL = URL(string: "https://tilftw.herokuapp.com/")
let newUserEndpoint = URL(string: "users", relativeTo: baseURL)
let loginEndpoint = URL(string: "login", relativeTo: baseURL)
let newEndpoint = URL(string: "new", relativeTo: baseURL)
//: `Codable` structs for User, Acronym, Auth:
struct User: Codable {
  let name: String
  let email: String
  let password: String
}

struct Acronym: Codable {
  let short: String
  let long: String
}

struct Auth: Codable {
  let token: String
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()
//: ### Login to web app (from demo)
//: __TODO 1 of 4:__ Copy and paste the `user` from the demo:
let user = User(name: "luizz", email: "luizz@hotmail.com", password: "luizz.123")

let deletePath = URL(string: "https://tilftw.herokuapp.com/acronyms")
let deleteAcronymsPath =
//    URL(string: "\(534)", relativeTo: newEndpoint!)
    deletePath?.appendingPathComponent("\(534)")
//    URL(fileURLWithPath: "\(534)", relativeTo: URL(string: "https://tilftw.herokuapp.com/acronyms") )

print(deleteAcronymsPath)

var deleteRequest = URLRequest(url: deleteAcronymsPath!)
deleteRequest.allHTTPHeaderFields = [
  "accept": "application/json",
  "content-type": "application/json"
]
deleteRequest.httpMethod = "DELETE"

session.dataTask(with: deleteRequest) { (_, response, error) in
    print("delete")
     print(response)
    guard let response = response else {
        print(error!.localizedDescription)
        PlaygroundPage.current.finishExecution()
    }

}.resume()
//: (from demo) Combine user's email and password, and encode in base64:
let loginString = "\(user.email):\(user.password)"
let loginData = loginString.data(using: .utf8)
let encodedString = loginData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//: (from demo) Create a POST `URLRequest` with `loginEndpoint`:
var loginRequest = URLRequest(url: loginEndpoint!)
loginRequest.httpMethod = "POST"
loginRequest.allHTTPHeaderFields = [
  "accept": "application/json",
  "content-type": "application/json",
  "authorization": "Basic \(encodedString)"
]
//: (from demo) Create a data task with `loginRequest`:
var auth = Auth(token: "")
session.dataTask(with: loginRequest) { data, response, error in
    print("login")
    print(response)
  guard let response = response, let data = data else {PlaygroundPage.current.finishExecution() }
  print(response)
  do {
    auth = try decoder.decode(Auth.self, from: data)
    auth.token
  } catch let decodeError as NSError {
    print("Decoder error: \(decodeError.localizedDescription)\n")
    return
  }
//: __TODO 2 of 4:__ Create a POST request to use the authorization token:
var authRequest = URLRequest(url: newEndpoint!)
    authRequest.allHTTPHeaderFields = [
      "accept": "application/json",
      "content-type": "application/json",
      "authorization": "Bearer \(auth.token)"
    ]




//: __TODO 3 of 4:__ Create and encode a new Acronym object:

    let acronym = Acronym(short: "PN", long: "P")

    do {
        authRequest.httpBody = try JSONEncoder().encode(acronym)
    } catch let error {

        print("Decoder error: \(error.localizedDescription)")
        PlaygroundPage.current.finishExecution()
    }




//: __TODO 4 of 4:__ Create a data task with `tokenAuthRequest`:

    session.dataTask(with: authRequest) { (_, response, error) in
        print("Create")
        print(response)
        guard let response = response else {
            print("Error response: \(error!.localizedDescription)")
            PlaygroundPage.current.finishExecution()
        }
//        print(response)
        PlaygroundPage.current.finishExecution()
    }.resume()

  
  // delete this, or playground will finish before new-acronym task completes
//  PlaygroundPage.current.finishExecution()
  }.resume()
