import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## Part 6 Challenge: UploadTask to Update json-server Post
let session = URLSession(configuration: .ephemeral)
//: The main difference between using a data task and using an upload task is
//: you pass the data directly to the upload task, instead of storing it in the request.
//:
//: __TODO 1 of 2:__ Use `PostRouter` enum (in Sources) to create a PUT request to update post 1 to `["author": "Part 6", "title": "Upload Task"]`:
let putRequest: URLRequest
let post = Post(author: "Part 6", title: "Upload Task")

putRequest = PostRouter.update(1, post).asURLRequest()
//: __Note:__ If we didn't have `PostRouter` to create the request,
//: we would write code here to JSON-encode the `Post`,
//: then pass this to the `uploadTask` `from` parameter.
//: However, since `PostRouter` has already stored the JSON data in the request's `httpBody`,
//: that's what we'll pass to `uploadTask`.
//:
//: __TODO 2 of 2:__ create an upload task with `putRequest` and `putRequest.httpBody`,
//: and the usual completion handler that checks for `data`,
//: `response` with status code 200, then JSON-decodes `data` to `PostWithId`.
let task = session.uploadTask(with: putRequest, from: putRequest.httpBody) { data, response, error in
      defer { PlaygroundPage.current.finishExecution()}
    guard let data = data, let httpResponse = response as? HTTPURLResponse,
        (200 ... 299).contains(httpResponse.statusCode) else {
            print("No data or status code not OK")
            return
    }

    do {
        let post = try JSONDecoder().decode(PostWithId.self, from: data)
        dump(post)

    } catch let err {
        print("Decoder Error: \(err.localizedDescription)")
    }



}

task.resume()





//: Run your `json-server` in Terminal: `json-server --watch db.json`, then run this playground.
//: You can double-check the result in RESTed by GETting all posts.
