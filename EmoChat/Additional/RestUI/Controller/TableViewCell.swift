//
//  TableViewCell.swift
//  EmoChat
//
//  Created by Sergii Kyrychenko on 19.06.17.
//  Copyright © 2017 SoftServe. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var messageModel: MessageModel?

    var message: Message? {
        didSet {
            parseDataFromMessageText()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImageInCell: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func parseDataFromMessageText() {
        if let notNullMessage = message {
            let newModel = MessageModel(message: notNullMessage)
            newModel.getParseDataFromResource { (allDone) in
                if allDone {
                    self.messageModel = newModel

                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                }
            }
        }
    }

    private func updateUI() {
        spinner.startAnimating()

        guard let messageURLData = messageModel?.messageURLData else {
            return
        }

        for (key, value) in messageURLData {

            myLabel.text = key

            if let valueModel = value as? UrlembedModel {
                titleLabel.text = valueModel.title

                guard let notNullUrl = valueModel.url else {
                    continue
                }

                JSONParser.sharedInstance.downloadImage(url: notNullUrl) { (image) in
                    DispatchQueue.main.async  {
                        self.myImageInCell.image = image
                        self.spinner.stopAnimating()
                    }
                }
            }
        }
    }

}
