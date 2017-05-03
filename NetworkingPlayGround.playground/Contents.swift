import Foundation
import UIKit

typealias JSONDictionary = [String: Any]

let url = URL(string: "episodes.json")

struct Media {}

struct Episode {
    let id: String
    let title: String
}

extension Episode {
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? String,
              let title = dictionary["title"] as? String else { return nil }
        
        self.id = id
        self.title = title
    }
}

extension Episode {
    static let all = Resource<[Episode]>(url: url!, parseJSON: { data in
        let json = try? JSONSerialization.data(withJSONObject: data, options: [])
        guard let dictionaries = json as? [JSONDictionary] else { return nil }
        return dictionaries.flatMap(Episode.init)
    })
    
//    var media: Resource<[Episode]> {
//        let url = NSURL(string: "http://localhost:8000/episodes/\(id).json")!
//    }
}

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> () ) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            let result = data.flatMap(resource.parse)
            completion(result)
        }.resume()
    }
}



Webservice().load(resource: Episode.all) { result in
    print("OI")
    print(result)
    print("OI")
}