//: [<< Create new user](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Authentication: How to login to get an authentication token
let config = URLSessionConfiguration.default
config.waitsForConnectivity = true
let session = URLSession(configuration: config)
//: Endpoints for web app:
let baseURL = URL(string: "https://tilftw.herokuapp.com/")
let newUserEndpoint = URL(string: "users", relativeTo: baseURL)
let loginEndpoint = URL(string: "login", relativeTo: baseURL)
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
//: ### Login to web app
//: __TODO 1 of 4:__ Copy and paste the `user` from the previous page:
let user = User(name: "luizz", email: "luizz@hotmail.com", password: "luizz.123")

//: __TODO 2 of 4:__ Combine user's email and password, and encode in base64:
let loginString = "\(user.email):\(user.password)"
let loginData = loginString.data(using: .utf8)
let encondedData = loginData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))




//: __TODO 3 of 4:__ Create a POST `URLRequest` with `loginEndpoint`:
var loginRequest = URLRequest(url: loginEndpoint!)
loginRequest.httpMethod = "POST"
loginRequest.setValue("application/json", forHTTPHeaderField: "accept")
loginRequest.setValue("application/json", forHTTPHeaderField: "content-type")
loginRequest.setValue("Basic \(encondedData)", forHTTPHeaderField: "authorization" )



//: __TODO 4 of 4:__ Create a data task with `loginRequest`:
let task = session.dataTask(with: loginRequest) { data, response, error in

    guard let response = response, let data = data else { PlaygroundPage.current.finishExecution()}
    print(response)
    print(String(data: data, encoding: .utf8))

    do {
        let auth = try JSONDecoder().decode(Auth.self, from: data)
        print(auth)
    } catch let error {
        print(error.localizedDescription)
        return
    }

    PlaygroundPage.current.finishExecution()
}

task.resume()



