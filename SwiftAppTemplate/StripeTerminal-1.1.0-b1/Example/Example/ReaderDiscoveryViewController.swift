//
//  ReaderDiscoveryViewController.swift
//  Dev
//
//  Created by Ben Guo on 7/18/18.
//  Copyright © 2018 Stripe. All rights reserved.
//

import UIKit
import Static
import StripeTerminal

class ReaderDiscoveryViewController: TableViewController, DiscoveryDelegate {

    var onConnectedToReader: (Reader) -> () = { _ in }
    private let config: DiscoveryConfiguration
    private var discoverCancelable: Cancelable? = nil
    private weak var cancelButton: UIBarButtonItem?
    private let activityIndicatorView = ActivityIndicatorHeaderView(title: "HOLD READER NEARBY")

    init(discoveryConfig: DiscoveryConfiguration) {
        self.config = discoveryConfig
        super.init(style: .grouped)
        self.title = "Discovery"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        self.cancelButton = cancelButton
        navigationItem.leftBarButtonItem = cancelButton

        updateContent(readers: [], isSetup: true)
        activityIndicatorView.activityIndicator.startAnimating()
        activityIndicatorView.activityIndicator.hidesWhenStopped = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 1. discover readers
        discoverCancelable = Terminal.shared.discoverReaders(config, delegate: self) { error in
            if let error = error {
                print("discoverReaders failed: \(error)")
                self.presentAlert(error: error) { _ in
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
            self.discoverCancelable = nil;
        }
    }

    private func updateContent(readers: [Reader], isSetup: Bool) {
        if !isSetup {
            activityIndicatorView.activityIndicator.stopAnimating()
        }
        if readers.count == 0 {
            switch (self.config.discoveryMethod) {
            case .bluetoothProximity:
                activityIndicatorView.title = "HOLD READER NEARBY"
            case .bluetoothScan:
                activityIndicatorView.title = "NEARBY READERS"
            case .internet:
                if isSetup {
                    activityIndicatorView.title = "LOOKING UP REGISTERED READERS"
                } else {
                    activityIndicatorView.title = "NO REGISTERED READERS FOUND"
                }
            @unknown default:
                activityIndicatorView.title = "READERS"
            }
            dataSource.sections = [
                Section(header: Section.Extremity.view(activityIndicatorView),
                        rows: [])
            ]
        }
        else {
            switch (self.config.discoveryMethod) {
            case .bluetoothProximity:
                activityIndicatorView.title = "DISCOVERED READER"
            case .bluetoothScan:
                activityIndicatorView.title = "NEARBY READERS"
            case .internet:
                activityIndicatorView.title = "REGISTERED READERS"
            @unknown default:
                activityIndicatorView.title = "READERS"
            }
            let rows = readers.map { reader -> Row in
                if let battery = reader.batteryLevel {
                    let detailText = "🔋 \(abs(battery.floatValue*100))%"
                    return Row(text: reader.serialNumber, detailText: detailText, selection: { [unowned self] in
                        self.connect(to: reader)
                    })
                }
                else {
                    return Row(text: reader.serialNumber, selection: { [unowned self] in
                        self.connect(to: reader)
                    })
                }
            }
            let footer: Section.Extremity?
            if let softwareVersion = readers.first?.deviceSoftwareVersion {
                footer = Section.Extremity.title("Reader software: \(softwareVersion)")
            }
            else {
                footer = nil
            }
            dataSource.sections = [
                Section(header: Section.Extremity.view(activityIndicatorView),
                        rows: rows,
                        footer: footer)
            ]
        }
    }

    // 2. connect to a selected reader
    private func connect(to reader: Reader, failIfInUse: Bool = true) {
        cancelButton?.isEnabled = false
        let previousTitle = activityIndicatorView.title
        activityIndicatorView.title = "Connecting..."
        activityIndicatorView.activityIndicator.startAnimating()
        Terminal.shared.connectReader(reader, connectConfig: ConnectConfiguration(failIfInUse: failIfInUse)) { connectedReader, error in
            if let connectedReader = connectedReader {
                self.discoverCancelable = nil
                self.onConnectedToReader(connectedReader)
            } else if let error = error as NSError?,
                error.code == ErrorCode.connectFailedReaderIsInUse.rawValue {
                self.presentAlert(
                    title: "\(reader.label ?? reader.serialNumber) in use",
                    message: "Reader is already collecting a payment. Interrupt the in-progress transaction?",
                    okButtonTitle: "Interrupt",
                    handler: { (shouldInterrupt) in
                        if shouldInterrupt {
                            self.connect(to: reader, failIfInUse: false)
                        }
                })
            } else if let error = error {
                self.presentAlert(error: error)
            }
            self.activityIndicatorView.activityIndicator.stopAnimating()
            self.cancelButton?.isEnabled = true
            self.activityIndicatorView.title = previousTitle
        }
    }

    @objc func dismissAction() {
        if let cancelable = discoverCancelable {
            cancelable.cancel { error in
                if let error = error {
                    print("cancel discoverReaders failed: \(error)")
                }
                else {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                self.discoverCancelable = nil
            }
        }
        else {
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: SCPDiscoveryDelegate
    func terminal(_ terminal: Terminal, didUpdateDiscoveredReaders readers: [Reader]) {
        updateContent(readers: readers, isSetup: false)
    }
}


