//
//  RemoteOutput.swift
//  Simcoe
//
//  Created by Christopher Jones on 4/7/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

internal struct RemoteOutput: Output {

    let token: String

    private let baseUrl = NSURL(string: "http://panalytics.herokuapp.com/")!

    private var url: NSURL {
        return NSURL(string: token, relativeToURL: baseUrl)!
    }

    init(token: String) {
        self.token = token

        Swift.print ("Simcoe now logging remotely to URL: \(url.absoluteString)")
    }

    func print(message: String) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let data = try! NSJSONSerialization.dataWithJSONObject(["analytics": message], options: NSJSONWritingOptions(rawValue: 0))
        request.HTTPBody = data

        NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            .dataTaskWithRequest(request)
            .resume()
    }

}
