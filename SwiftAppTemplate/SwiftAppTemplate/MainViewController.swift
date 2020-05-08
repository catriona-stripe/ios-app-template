//
//  MainViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    private let paymentTextField = UITextField()
    private static let spacing: CGFloat = 50.0
    private static let stripeBlue = UIColor(red: 103.0/255.0, green:  114.0/255.0, blue: 229.0/255.0, alpha: 1.0)

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Example App"
        view.backgroundColor = UIColor.white

        paymentTextField.delegate = self

        let discoverReadersButton = MainViewController.stripeyButton()
        discoverReadersButton.setTitle("Discover Readers", for: .normal)
        discoverReadersButton.addTarget(self, action: #selector(discoverReader), for: .touchUpInside)

        let collectPaymentButton = MainViewController.stripeyButton()
        collectPaymentButton.setTitle("Collect Payment", for: .normal)
        collectPaymentButton.addTarget(self, action: #selector(collectPayment), for: .touchUpInside)

        paymentTextField.placeholder = "0"
        paymentTextField.keyboardType = .numberPad
        paymentTextField.borderStyle = .roundedRect

        let stackView = UIStackView(arrangedSubviews: [
            UIView(), // Spacer()
            discoverReadersButton,
            paymentTextField,
            collectPaymentButton,
            UIView(), // Spacer()
        ])
        stackView.axis = .vertical
        stackView.spacing = MainViewController.spacing
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -MainViewController.spacing),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: MainViewController.spacing),
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
        guard let amountString = paymentTextField.text else {
            presentErrorAlert("Please input an amount to collect.")
            return
        }

        guard let _ = UInt(amountString) else {
            presentErrorAlert("Please enter valid integer.")
            return
        }
    }

    private static func stripeyButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = MainViewController.stripeBlue.cgColor
        button.layer.cornerRadius = 4.0
        button.titleEdgeInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        button.backgroundColor = MainViewController.stripeBlue
        return button
    }
}
