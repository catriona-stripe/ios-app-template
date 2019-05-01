//
//  MainViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 5/1/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private  var connectReaderButton = UIButton()
    private var collectPaymentButton = UIButton()
    private var paymentTextField = UITextField()
    private var containerView = UIView()

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

        paymentTextField.placeholder = "0"
        paymentTextField.keyboardType = .numbersAndPunctuation
        paymentTextField.borderStyle = .roundedRect

        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        paymentTextField.leftView = paddingView
        paymentTextField.leftViewMode = .always

        view.addSubview(containerView)
        containerView.addSubview(connectReaderButton)
        containerView.addSubview(collectPaymentButton)
        containerView.addSubview(paymentTextField)

        containerView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    }


    @objc func discoverReader(sender: UIButton) {
        let readerViewController = ReaderListViewController()
        navigationController?.pushViewController(readerViewController, animated: true)
    }

    @objc func collectPament(sender: UIButton) {
        // TODO: Fill flow for collection a payment.
    }
}
