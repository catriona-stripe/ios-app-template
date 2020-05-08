//
//  MainViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    private let statusImageView = UIImageView()
    private let statusLabel = UILabel()
    private let container = UIStackView()
    private let paymentTextField = UITextField()
    private var currentTopAndBottomConstraints = [NSLayoutConstraint]()
    private static let spacing: CGFloat = 50.0
    private static let stripeBlue = UIColor(red: 103.0/255.0, green:  114.0/255.0, blue: 229.0/255.0, alpha: 1.0)

    init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: keyboardWillShow)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: keyboardWillHide)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Example App"
        view.backgroundColor = UIColor.white

        paymentTextField.delegate = self

        // You can change the set image and tintColor when connected to show some state
        // bolt.fill or creditcard are some other handy symbols 🤷‍♂️
        statusImageView.image = UIImage(systemName: "bolt.slash.fill")
        statusImageView.contentMode = .scaleAspectFit
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.tintColor = .lightGray

        // Change the status label text when connected too and could use it to show the reader messages
        statusLabel.textAlignment = .center
        statusLabel.text = "No reader connected"

        let discoverReadersButton = MainViewController.stripeyButton()
        discoverReadersButton.setTitle("Discover Readers", for: .normal)
        discoverReadersButton.addTarget(self, action: #selector(discoverReader), for: .touchUpInside)

        let collectPaymentButton = MainViewController.stripeyButton()
        collectPaymentButton.setTitle("Collect Payment", for: .normal)
        collectPaymentButton.addTarget(self, action: #selector(collectPayment), for: .touchUpInside)

        paymentTextField.placeholder = "0"
        paymentTextField.keyboardType = .numberPad
        paymentTextField.borderStyle = .roundedRect

        for view in [
            UIView(), // Spacer()
            statusImageView,
            statusLabel,
            discoverReadersButton,
            paymentTextField,
            collectPaymentButton,
            UIView(), // Spacer()
            ] {
                container.addArrangedSubview(view)
        }
        container.axis = .vertical
        container.spacing = MainViewController.spacing
        container.isLayoutMarginsRelativeArrangement = true
        view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false;
        self.updateConstraintsForKeyboardHeight(0)
        NSLayoutConstraint.activate([
            container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -MainViewController.spacing),
            container.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: MainViewController.spacing),
            // Fixed size for the status image
            statusImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc func discoverReader(sender: UIButton) {
        // Use the DiscoveryVC to start discovery and connect to a reader (or return a reader to connect to)
        let discoveryViewController = DiscoveryViewController()
        navigationController?.pushViewController(discoveryViewController, animated: true)
    }

    @objc func collectPayment(sender: UIButton) {
        startCollectingPayment()
    }

    // Mark: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startCollectingPayment()
        return true
    }

    //Mark: - Private

    private func startCollectingPayment() {
        paymentTextField.resignFirstResponder()

        guard let amountString = paymentTextField.text else {
            presentErrorAlert("Please input an amount to collect.")
            return
        }

        guard let _ = UInt(amountString) else {
            presentErrorAlert("Please enter valid integer.")
            return
        }
    }

    private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        // hackety hack, just shift the container up so the bottom is always visible
        // Use -2 view since there's a spacer...hackety hack
        let containerMaxY = container.arrangedSubviews[container.arrangedSubviews.count - 2].frame.maxY + MainViewController.spacing
        let emptySpace = self.view.frame.maxY - containerMaxY
        let shiftForKeyboard = keyboardFrame.size.height - emptySpace
        if shiftForKeyboard > 0 {
            updateConstraintsForKeyboardHeight(shiftForKeyboard)
        }
    }

    private func keyboardWillHide(notification: Notification) {
        updateConstraintsForKeyboardHeight(0)
    }

    private func updateConstraintsForKeyboardHeight(_ height: CGFloat) {
        NSLayoutConstraint.deactivate(currentTopAndBottomConstraints)
        currentTopAndBottomConstraints = [
            container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -height),
            container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -height),
        ]
        NSLayoutConstraint.activate(currentTopAndBottomConstraints)
    }

    private static func stripeyButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = MainViewController.stripeBlue.cgColor
        button.layer.cornerRadius = 4.0
        button.titleEdgeInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        button.backgroundColor = MainViewController.stripeBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
