//
//  TableViewCell.swift
//  EmoChat
//
//  Created by Sergii Kyrychenko on 19.06.17.
//  Copyright © 2017 SoftServe. All rights reserved.
//

import UIKit

protocol TestResizeCellInCell: class {
    //func resizeMyCell(cell: UITableViewCell)
}

class TableViewCell: UITableViewCell, TestResizeCellInCell {

    var testRDelegate:TestResizeCell?

    var messageModel: MessageModel?

    var message: Message? {
        didSet {
            parseDataFromMessageText()
        }
    }

    @IBOutlet weak var subViewREstHeight: NSLayoutConstraint!
    @IBOutlet weak var subViewRest: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImageInCell: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        subViewREstHeight.constant = 0
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

//        defer {
//            spinner.stopAnimating()
//        }

        let downloadGroup = DispatchGroup()

        guard let messageURLData = messageModel?.messageURLData else {
            return
        }

        for (key, value) in messageURLData {
            downloadGroup.enter()

            myLabel.text = key

            if let valueModel = value as? UrlembedModel {
                titleLabel.text = valueModel.title

                guard let notNullUrl = valueModel.url else {
                    continue
                }

                JSONParser.sharedInstance.downloadImage(url: notNullUrl) { (image) in
                    DispatchQueue.main.async  {
                        self.myImageInCell.image = image

//                        let ccView = Bundle.main.loadNibNamed("RestUIInfo", owner: self, options: nil)?.first as! UITableViewCell
//                            //).contentView as! RestUIInfoView
//
//                        ccView.frame = CGRect(x: 0, y: self.contentView.frame.height - 30, width: self.contentView.frame.width, height: ccView.contentView.frame.height)
//                        self.contentView.addSubview(ccView)
//
//                        self.testRDelegate?.resizeMyCell(cell: self)

//                        self.translatesAutoresizingMaskIntoConstraints = false
//                        let views = ["deviceView" : ccView.contentView]
//
//                        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[deviceView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//                        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[deviceView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))


                    }

                    downloadGroup.leave()
                }
            }
        }

        downloadGroup.notify(queue: DispatchQueue.main) { // 2
            DispatchQueue.main.async  {
                //self.xibSetup()

                let ccView = Bundle.main.loadNibNamed("RestUIInfo",
                                                      owner: self,
                                                      options: nil)?.first as! UITableViewCell
                //).contentView as! RestUIInfoView

//                let contentViewCell = ccView.contentView
//                contentViewCell.translatesAutoresizingMaskIntoConstraints = false
//
//                contentViewCell.frame = CGRect(x: 0,
//                                               y: 0,
//                                      width: self.subViewRest.frame.width,
//                                      height: self.subViewRest.frame.height)
//
//
                self.subViewREstHeight.constant = ccView.bounds.height//200
//                self.subViewRest.addSubview(contentViewCell)
//
//                self.subViewRest.layoutIfNeeded()
//
//                self.subViewRest.frame = CGRect(x: self.subViewRest.frame.origin.x,
//                                                y: self.subViewRest.frame.origin.y,
//                                                width: self.subViewRest.frame.width,
//                                                height: contentViewCell.frame.height)
//
//                contentViewCell.layoutIfNeeded()
                self.testRDelegate?.resizeMyCell(cell: self)

                self.spinner.stopAnimating()
            }
        }
    }

    func xibSetup() {
        let myView = loadViewFromNib()

        myView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(myView)

        let leading = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: myView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        self.addConstraint(leading)

        let bottom = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: myView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottom)

        let trailing = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: myView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        self.addConstraint(trailing)

//        let top = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: myView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)

        let top = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: subViewRest, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)

        self.addConstraint(top)

        self.testRDelegate?.resizeMyCell(cell: self)
    }

    //I load the xib file
    func loadViewFromNib() -> UIView {

//        let bundle = NSBundle(forClass: self.dynamicType)
//        let nib = UINib(nibName: "View", bundle: bundle)
//        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        let ccView = Bundle.main.loadNibNamed("RestUIInfo", owner: self, options: nil)?.first as! UITableViewCell

        return ccView.contentView
    }

}
