//
//  DiscoveryViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 4/30/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit
//import StripeTerminal // Uncomment after setting up the framework

class DiscoveryViewController: UITableViewController/*, DiscoveryDelegate */ {
    private static var cellReuseIdentifier = "readerCell"

    // This could be changed to the Reader type.
    private var items: [String] = []

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Connect Reader"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DiscoveryViewController.cellReuseIdentifier)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissAction))

// Make sure to uncomment the DiscoveryDelegate protocol part above too
//        Terminal.shared.discoverReaders(DiscoveryConfiguration(deviceType: {you pick}, discoveryMethod: {you pick}, simulated: false), delegate: self) { [unowned self] error in
//            if let error = error {
//                self.presentErrorAlert(error.localizedDescription)
//            }
//        }
    }

    @objc func dismissAction() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - DiscoveryDelegate

//    func terminal(_ terminal: Terminal, didUpdateDiscoveredReaders readers: [Reader]) {
//        for reader in readers {
//            items.removeAll { $0 == reader.serialNumber } // make sure we don't have duplicates
//            items.append(reader.serialNumber)
//        }
//        self.tableView.reloadData()
//    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: This is method is called once any of the items on a list have
        // been selected. If you update the `items` to store `Reader`s you probably
        // want to connect to that reader now.
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryViewController.cellReuseIdentifier) ??  UITableViewCell(style: .default, reuseIdentifier: DiscoveryViewController.cellReuseIdentifier)

        cell.textLabel?.text = items[indexPath.row]

        return cell
    }
}
