//
//  MainViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    private let connectReaderButton = UIButton()
    private let collectPaymentButton = UIButton()
    private let paymentTextField = UITextField()
    private let containerView = UIView()
    private let loadingIndicator = UIActivityIndicatorView()
    private let loadingContainerView = UIView()
    private let loadingLabel = UILabel()

    private static let spacing: CGFloat = 50.0
    private static let stripeBlue = UIColor(red: 103.0/255.0, green:  114.0/255.0, blue: 229.0/255.0, alpha: 1.0)

    init() {
        super.init(nibName: nil, bundle: nil)
        paymentTextField.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Terminal Example App"
        view.backgroundColor = UIColor.white

        connectReaderButton.setTitle("Connect Reader", for: .normal)
        connectReaderButton.setTitleColor(UIColor.white, for: .normal)
        connectReaderButton.layer.borderWidth = 1.0
        connectReaderButton.layer.borderColor = MainViewController.stripeBlue.cgColor
        connectReaderButton.layer.cornerRadius = 4.0
        connectReaderButton.titleEdgeInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        connectReaderButton.backgroundColor = MainViewController.stripeBlue
        connectReaderButton.addTarget(self, action: #selector(discoverReader), for: .touchUpInside)


        collectPaymentButton.setTitle("Collect Payment", for: .normal)
        collectPaymentButton.setTitleColor(UIColor.white, for: .normal)
        collectPaymentButton.layer.borderWidth = 1.0
        collectPaymentButton.layer.borderColor = MainViewController.stripeBlue.cgColor
        collectPaymentButton.layer.cornerRadius = 4.0
        collectPaymentButton.titleEdgeInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        collectPaymentButton.backgroundColor = MainViewController.stripeBlue
        collectPaymentButton.addTarget(self, action: #selector(collectPayment), for: .touchUpInside)

        paymentTextField.placeholder = "0"
        paymentTextField.keyboardType = .numbersAndPunctuation
        paymentTextField.borderStyle = .roundedRect

        paymentTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        paymentTextField.leftViewMode = .always

        loadingContainerView.isHidden = true
        loadingContainerView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)

        loadingLabel.textColor = UIColor.white

        view.addSubview(containerView)
        containerView.addSubview(connectReaderButton)
        containerView.addSubview(collectPaymentButton)
        containerView.addSubview(paymentTextField)
        view.addSubview(loadingContainerView)
        loadingContainerView.addSubview(loadingIndicator)
        loadingContainerView.addSubview(loadingLabel)

        containerView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -MainViewController.spacing),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        connectReaderButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            connectReaderButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            connectReaderButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            connectReaderButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: MainViewController.spacing),
            connectReaderButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -MainViewController.spacing),
        ])

        paymentTextField.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: connectReaderButton.bottomAnchor, constant: MainViewController.spacing),
            paymentTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            paymentTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: MainViewController.spacing),
            paymentTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -MainViewController.spacing),
            paymentTextField.heightAnchor.constraint(equalTo: connectReaderButton.heightAnchor),
        ])


        collectPaymentButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            collectPaymentButton.topAnchor.constraint(equalTo: paymentTextField.bottomAnchor, constant: MainViewController.spacing),
            collectPaymentButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            collectPaymentButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            collectPaymentButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: MainViewController.spacing),
            collectPaymentButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -MainViewController.spacing),
        ])

        loadingContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: loadingContainerView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: loadingContainerView.centerYAnchor),
        ])

        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: MainViewController.spacing),
            loadingLabel.centerXAnchor.constraint(equalTo: loadingContainerView.centerXAnchor)
        ])
    }


    @objc func discoverReader(sender: UIButton) {
        loadingLabel.text = "Discovering Readers..."
        loadingContainerView.isHidden = false
        loadingIndicator.startAnimating()

        // TODO once you have discovered some readers create a
        // ReaderListViewController and push it onto the navigationController.

        // let readerViewController = ReaderListViewController(readers)
        // navigationController?.pushViewController(readerViewController, animated: true)
    }

    @objc func collectPayment(sender: UIButton) {
        startCollectingPayment()
    }

    // Mark: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startCollectingPayment()
        return true
    }

    private func startCollectingPayment() {
        guard let amountString = paymentTextField.text else {
            errorAlert("Please input an amount to collect.")
            return
        }

        guard let amountNumber = Int(amountString) else {
            errorAlert("Please enter valid integer.")
            return
        }

        // TODO: Fill in flow for collecting payments. Since there are multiple steps
        // you may want to print to the console (call print(<string>)) after each step is done.
        // You could also use the loading view and continue to update what is going on. g
    }
}
