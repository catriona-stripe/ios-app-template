//
//  APIClient.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import Alamofire

class APIClient {

    /**
     In order wire up terminal, you'll need to first deploy an instance of
     our provided example backend:

     https://github.com/stripe/example-terminal-backend

     After deploying your backend, replace empty string on the line below with
     the URL of your Heroku app.

     Have this class impolement ConnectionTokenProvider and uncomment
     fetchConnectionToken once you have StripeTerminal installed in the app.
     */

    static var backendUrl: String = ""

//    func fetchConnectionToken(_ completion: @escaping ConnectionTokenCompletionBlock) {
//        if let backendUrl = URL(string: APIClient.backendUrl) {
//            let url = backendUrl.appendingPathComponent("connection_token")
//            let params: [String: Any] = [:] // whatever parameters necessary for your backend to authenticate the client
//
//            Alamofire.request(url, method: .get, parameters: params)
//                .responseJSON { responseJSON in
//                    switch responseJSON.result {
//                    case .success(let json):
//                        if let json = json as? [String: AnyObject],
//                            let secret = json["secret"] as? String {
//                            completion(secret, nil)
//                        }
//                    case .failure(let error):
//                        completion(nil, error)
//                    }
//            }
//        }
//    }

}
