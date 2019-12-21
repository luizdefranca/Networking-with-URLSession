import Foundation
// The playground must keep running until the asynchronous task completes:
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## Cookbook 1: iTunes Query Data Task
//: Default session with `waitsForConnectivity`:
let config = URLSessionConfiguration.default
config.waitsForConnectivity = true
let defaultSession = URLSession(configuration: config)
//: ### `Track`, `TrackList` and `QueryService`
struct Track: Decodable {
  let trackName: String
  let artistName: String
  let previewUrl: String

    enum CodingKeys : String, CodingKey {

        case trackName, artistName, previewUrl
    }
}

struct TrackList: Decodable {
  let results: [Track]
}

class QueryService {
  var tracks: [Track] = []
  var errorMessage = ""

  func getSearchResults() {
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")!
    let task = defaultSession.dataTask(with: url) { (data, response, error) in

        if let error = error {
            print(error.localizedDescription)
            return
        }

        let validStatusCode = 200 ..< 300
        guard let httpResponse = response as? HTTPURLResponse, validStatusCode.contains(httpResponse.statusCode) else {
            print("Error http response")
            return
        }

        guard let data = data else {
            return
        }

        self.updateSearchResults(data)
        self.tracks
//        print(String(data: data, encoding: .utf8 ))
        PlaygroundPage.current.finishExecution()

    }


    task.resume()




  }

  func updateSearchResults(_ data: Data) {


    tracks.removeAll()

    do {
         let tracklist = try JSONDecoder().decode(TrackList.self, from: data)
//        dump(json)

        for track in tracklist.results {
            dump(track)
        }
    } catch let error {
        print(error.localizedDescription)
    }

    PlaygroundPage.current.finishExecution()

  }

}

QueryService().getSearchResults()
