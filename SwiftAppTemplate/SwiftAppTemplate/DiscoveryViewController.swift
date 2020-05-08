//
//  DiscoveryViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 4/30/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class DiscoveryViewController: UITableViewController {
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

        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        let barButton = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        navigationItem.rightBarButtonItem = barButton
    }

    @objc func dismissAction() {
        navigationController?.popViewController(animated: true)
    }

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
