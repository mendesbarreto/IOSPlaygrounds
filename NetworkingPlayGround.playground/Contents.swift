//: Playground - noun: a place where people can play

import UIKit

struct Episode {}
struct Media {}


let url = URL(string: "episodes.json")

struct Resource<A> {
    let url: URL
    let parse: Data -> A?
}

let episodesResource = Resource<Data>(url: url) {
    return data
}

final class Webservice {
    func load<A>(resource: Resource<A>, completion: (A?) -> () ) {
        URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
    }
}