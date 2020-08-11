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

    /**
     Temporary hack: fetching locations requires an account secret token. This
     should be going through the merchant backend but for now we're embedding the
     token in here to provide the locations helper.
     */
    static let secretKey: String = ""

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

    // Provided as a helper to fetch your accounts locations. Returns an array of dictionaries containing the
    // locations as defined in https://stripe.com/docs/api/terminal/locations/list
    func fetchLocations(_ completion: @escaping ([[String:AnyObject]]?, Error?) -> Void) {
        let url = "https://api.stripe.com/v1/terminal/locations"
        assert(APIClient.secretKey.count > 0)
        AF.request(url, method: .get, headers: HTTPHeaders([HTTPHeader.authorization(bearerToken: APIClient.secretKey)]))
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    if let json = json as? [String: AnyObject],
                        let locations = json["data"] as? [[String: AnyObject]] {
                        completion(locations, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
