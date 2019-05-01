//
//  UIViewController+Error.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

extension UIViewController {
    func errorAlert(_ errorString: String) {
        let alertContainer = UIAlertController(title: "Error",
                                               message: errorString,
                                               preferredStyle: .alert)
        alertContainer.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertContainer, animated: true)
    }
}
