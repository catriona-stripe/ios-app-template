//
//  APIClient.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import Alamofire
//import StripeTerminal

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

    static let backendUrl: String = ""

    static let defaultError = NSError(domain: "APIClient Error",
                                      code: 1,
                                      userInfo: [
                                        NSLocalizedDescriptionKey: "APIClient request failed.",
    ])

//    func urlWithPathComponents(_ pathComponents: [String]) -> URL {
//        guard let backendURL = URL(string: APIClient.backendUrl) else {
//            fatalError()
//        }
//        var responseURL = backendURL
//        for component in pathComponents {
//            responseURL = responseURL.appendingPathComponent(component)
//        }
//        return responseURL
//    }
//
//    func fetchConnectionToken(_ completion: @escaping ConnectionTokenCompletionBlock) {
//        let url = self.urlWithPathComponents(["connection_token"])
//        let params: [String: Any] = [:] // whatever parameters necessary for your backend to authenticate the client
//
//        AF.request(url, method: .post, parameters: params)
//            .responseJSON { responseJSON in
//                switch responseJSON.result {
//                case .success(let json):
//                    if let json = json as? [String: AnyObject],
//                        let secret = json["secret"] as? String {
//                        completion(secret, nil)
//                    }
//                case .failure(let error):
//                    completion(nil, error)
//                }
//        }
//    }
//
//    func capturePaymentIntent(_ paymentIntentId: String, additionalParams: [String: Any]? = nil, completion: @escaping (Error?) -> Void) {
//        let url = self.urlWithPathComponents(["payment_intents", paymentIntentId, "capture"])
//        AF.request(url,
//                   method: .post,
//                   parameters: additionalParams)
//            .responseString(completionHandler: { response in
//                completion(response.error)
//            })
//    }
}
