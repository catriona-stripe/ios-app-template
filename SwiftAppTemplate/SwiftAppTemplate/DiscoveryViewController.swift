//
//  DiscoveryViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 4/30/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView(frame: CGRect.zero)
    private weak var cancelButton: UIBarButtonItem?

    private static var cellReuseIdentifier = "readerCell"

    // This could be changed to an actual type.
    private var items: [Any] = []

    init(_ items: [Any]) {
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        self.items = items
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Connect Reader"

        view.backgroundColor = UIColor.white

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DiscoveryViewController.cellReuseIdentifier)
        tableView.separatorStyle = .none
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        self.cancelButton = cancelButton
        navigationItem.leftBarButtonItem = cancelButton

        tableView.reloadData()
    }

    @objc func dismissAction() {
        navigationController?.popViewController(animated: true)
    }

    // Mark - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: This is method is called once any of the items on a list have
        // been selected.
    }

    // Mark - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryViewController.cellReuseIdentifier) ??  UITableViewCell(style: .default, reuseIdentifier: DiscoveryViewController.cellReuseIdentifier)

        // You can attempt to cast to a given object with as? and then safely
        // access an object specific properity in order to set the textLabel
        // of the cell to something meaningful.
        if let text = items[indexPath.row] as? String {
            cell.textLabel?.text = text
        }

        let bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(bottomBorder)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBorder.heightAnchor.constraint(equalToConstant: 1.0),
            bottomBorder.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
        ])

        return cell
    }
}
