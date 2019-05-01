//
//  ReaderListViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 4/30/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class ReaderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView(frame: CGRect.zero)
    private weak var cancelButton: UIBarButtonItem?

    private static var cellReuseIdentifier = "readerCell"

    // Update this "Any" to be "Reader" once you have link the terminal sdk
    private var readers: [Any] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Connect Reader"

        view.backgroundColor = UIColor.white

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReaderListViewController.cellReuseIdentifier)
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
        // TODO: Once a tableview has been selected call connectReader on this table view.
    }

    // Mark - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: ReaderListViewController.cellReuseIdentifier)

        // TODO: Set the cells textLabel to display the reader serial number

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
