//
//  User.swift
//  EmoChat
//
//  Created by Kirill on 5/30/17.
//  Copyright © 2017 SoftServe. All rights reserved.
//

class User: FireBaseEmoChat {

//    var userId:String = Auxiliary.getEmpyUUID()
    var uuid: String = Auxiliary.getEmpyUUID()
    var name: String? = "uknowned"
    var email:String? = "no e-mail"
    var userConversations: [Conversation?]? = []
    var userMessages: [Message?]? = []

    
    init(userId: String, name: String, email: String) {
        self.uuid = userId
        self.name = name
        self.email = email
        
    }

    convenience init(name: String = "uknowned", email: String = "no e-mail") {
        self.init()

        self.uuid = Auxiliary.getUUID()
        self.name = name
        self.email = email
    }

    func appendConversation(_ newElement: Conversation) {
        userConversations?.append(newElement)
    }

    func appendMessage(_ newElement: Message) {
        userMessages?.append(newElement)
    }

    //MARK:- func. for FireBase use
    func toAnyObjectInID() -> Any {
        return [
            "userId": uuid
        ]
    }

    func toAnyObject() -> Any {
        return [
            uuid: getDetails()
        ]
    }

    func getDetails() -> [String: Any] {

        return ["userId": uuid,
                "name": name ?? "uknowned",
                "email":email ?? "no e-mail",
                "userConversations": collectDataFromModelInstance(userConversations),
                "userMessages": collectDataFromModelInstance(userMessages)
        ]
    }

    class func toAnyObject(users usersInArray:[User]) -> Any {
        var valueToReturn: [String: Any] = [:]

        for userInArr in usersInArray {
            valueToReturn.updateValue(userInArr.getDetails(), forKey: userInArr.uuid)
        }

        return valueToReturn
    }
}


