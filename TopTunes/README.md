#  TopTunes

## 7 Background Sessions

### 07 Challenge Starter
TopTunes uses Feed URLs generated by [iTunes RSS Feed Generator](https://rss.itunes.apple.com/en-us) to display the top 20 songs / hot tracks / new music etc.

>Note: The format of the Feed URLs sometimes changes. If the app cannot get correct JSON data, copy and paste the URL directly from the Feed Generator.

This starter app uses a default session and data task with completion handler to send a request.

TODO 1: Change `session` to use a background configuration, with `MasterViewController` as delegate.

TODO 2: Convert the task in `fetchList()` to use the URLSession delegate, instead of a completion handler.

TODO 3: Implement the `URLSessionDataDelegate` method `urlSession(_:dataTask:didReceive:)` to do what the task's completion handler did, __plus__ create a new task to fetch a _different_ category of top-20 songs. Set this task's `earliestBeginDate` to be 30 seconds from the current time `Date()`.

TODO 4: Implement the `URLSessionTaskDelegate` method urlSession(_:task:willBeginDelayedRequest:completionHandler:) to continue loading.
