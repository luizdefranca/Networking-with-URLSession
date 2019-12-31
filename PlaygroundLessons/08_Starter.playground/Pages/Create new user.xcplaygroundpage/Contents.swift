import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Authentication: How to login to get an authentication token
/*
 Cookies
 -Sent by server, returned by client to maintain identity and info
 -sessio/transient or permanent/stored
 - Flash cookies/local stored objects

 You can control the cookie behavior into session configuration (URLSessionConfiguration)

  - Set cookies from cookies store?
 configuration.httpShouldSetCookies = false
 * it controls whether tasks should automaticall provide cookies from the shared cookie store
 when making requests. << The default value is true >>.
 If you want to provide cookies yourself, set this value to false and provide a cookie header
 either through the session's HTTP additional headers property or the request object.

 - Accept cookies?
configuration.httpCookieAcceptPolicy = .never
 * it determines the cookie accept policy for all tasks. << The default values is only form main
 document domain >>.
 You can change for all or never.

 - Store cookies?
 configuration.httpCookiesStorage = nil
 * It determines the cookie storage object used by all tasks. To disable cookie storage, set this
 property to nil. << For default and background sessions the default values is the shared cookie
 storage object. For ephemeral session the default value is a private cookie storage object that
store data in memory only and is destroyed when you invalidate the session. >>


 */




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
//let name = NSStringFromClass(U)
//name
//let name = NSStringFromClass(<#T##aClass: AnyClass##AnyClass#>)
//: ### Create a new user:
//: __TODO 1 of 4:__ To create a new user, start by creating a POST `URLRequest` with `newUserEndpoint`:


var postRequest = URLRequest(url: newUserEndpoint!)
postRequest.httpMethod = "POST"
//postRequest.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "content-type": "application/json"
//]
postRequest.setValue("application/json", forHTTPHeaderField: "accept")
postRequest.setValue("application/json", forHTTPHeaderField: "content-type")
//postRequest.setValue("utf-8", forHTTPHeaderField: "charset")




//: __TODO 2 of 4:__ Create a new User object, with your name etc.:
let user = User(name: "luizz", email: "luizz@hotmail.com", password: "luizz.123")

//: __TODO 3 of 4:__ Assign JSON-encoded `user` to `httpBody`:
 var dataObject : Data? = nil {
    didSet {
        print("data set")
    }
}

do {
    dataObject = try JSONEncoder().encode(user)

    postRequest.httpBody = dataObject
} catch let error {
    print("Error Enconding...\(error.localizedDescription)")
    PlaygroundPage.current.finishExecution()
}



//: __TODO 4 of 4:__ Create a data task with `newUserRequest`:

print(String(data: postRequest.httpBody!, encoding: .utf8) )
let task = session.dataTask(with: postRequest) { (data, response, error) in

    print((response as! HTTPURLResponse).description)
    if error != nil {
        if let data = data, let httpResponse = response as? HTTPURLResponse,
            (200 ... 299).contains(httpResponse.statusCode) {
            print("Status Code: \(httpResponse.statusCode)")
            print(" \(httpResponse.description )")

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                dump(user)
            } catch  {
                print(error)
            }
        } else {
            print("Error loading data")
        }

    } else {
        print("Request Error: \(error?.localizedDescription ?? "")")
    }

    PlaygroundPage.current.finishExecution()
}

task.resume()



//: Copy your User object from TODO 2, then continue to the next page.
//:
//: [Login to web app >>](@next)
