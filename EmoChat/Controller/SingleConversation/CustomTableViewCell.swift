//
//  CustomTableViewCell.swift
//  EmoChat
//
//  Created by Olga Saliy on 20.06.17.
//  Copyright © 2017 SoftServe. All rights reserved.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: SpecialTextView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var previewContainer: UIView!
    @IBOutlet weak var heightOfPreviewContainer: NSLayoutConstraint!
    
    weak var delegate: CellDelegate!
    weak var singleConversationControllerDelegate: SingleConversationControllerProtocol?
    
    var temporaryCellHeight:CGFloat = 0
    var extraCellHeiht:CGFloat {
        return heightOfPreviewContainer.constant
    }

    weak var messageModel: MessageModel?
    
    var messageEntity: Message? {
        get {
            return _messageEntity
        }
        
        set {
            _messageEntity = newValue
            //TODO: check type of content
            message.text = newValue?.content!.content
            setNullableDataInPreviewContainer()
            parseDataFromMessageText(delaySeconds: 1)
        }
    }
    
    var contentRect: CGRect {
        get {
            return message.frame
        }
    }
    
    func handler(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            delegate.cellDelegate(self, didHandle: .longPress)
        }
    }
    
    
    private var _messageEntity: Message!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setInitDataForUI()
    }
    
    private func setInitDataForUI() {
        addRecognizerForMessage()
        
        previewContainer.backgroundColor = UIColor.clear
        setNullableHeightOfPreviewContainer()
    }
    
    func setNullableDataInPreviewContainer() {
        messageModel = nil
        removeRestUIInfoViewFromView(view: previewContainer)
        setNullableHeightOfPreviewContainer()
    }
    
    func setNullableHeightOfPreviewContainer() {
        heightOfPreviewContainer.constant = 0
    }
    
    private func addRecognizerForMessage() {
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handler))
        message.addGestureRecognizer(recognizer)
    }

}

// MARK: - Actions

enum Action {
    case longPress
    // Other actions
}

protocol CellDelegate: class {
    func cellDelegate(_ sender: UITableViewCell, didHandle action: Action)
}


