//: [Request without PostRouter](@previous)

import Foundation
import PlaygroundSupport

import Messages
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## URLSession Cookbook 2 Challenge
//: ### PUT to json-server
//: Use ephemeral session:
let session = URLSession(configuration: .ephemeral)
//: __TODO:__ After completing the `PostRouter` enum in __Sources__, use it to replace the two lines below, with the complete PUT request to update **posts/1** to `["author": "a friend of Alamofire", "title": "Using PostRouter"]`:
let putPost = Post(author: "a friend of mine", title: "Using PostRouter")
let postRouter = PostRouter.update(1, putPost)
//let postRouter = PostRouter.create(<#T##Post#>)
let putRequest = postRouter.asURLRequest()
//: Here's the code from the previous page, to create a data task with a completion handler that checks for `data`,
//: `response` with status code 200, then converts `data` to `JSONDictionary`:
let putTask = session.dataTask(with: putRequest) { data, response, error in
  // handler just shows us what we updated on json-server
  defer { PlaygroundPage.current.finishExecution() }
  guard let data = data, let response = response as? HTTPURLResponse,
    case 200 ..< 300 = response.statusCode  else {
      print("No data or statusCode not OK")

      return
  }
    print("Status Code: \(response.statusCode) - \(response.description)/n")
  let decoder = JSONDecoder()
  do {
    let post = try decoder.decode(PostWithId.self, from: data)
    // decoded data is just the Post we updated on json-server
    post
  } catch let decodeError as NSError {
    print("Decoder error: \(decodeError.localizedDescription)\n")
    return
  }


}
putTask.resume()
//: Run your `json-server` in Terminal: `json-server --watch db.json`, then run this playground.
//: You can double-check the result in RESTed by GETting all posts.

