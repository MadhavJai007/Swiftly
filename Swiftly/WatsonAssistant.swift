//
//  WatsonAssistant.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-11-02.
//

import Foundation
import SwiftUI
import AssistantV2


/// Struct for message object
struct Message: Identifiable {
    var id = UUID()
    var text: String
    var sender: Sender
    
    enum Sender{
        case user, chatbot, system
    }
}

class WatsonAssistant: ObservableObject {
    
    static let instance = WatsonAssistant()
    private let authenticator = WatsonIAMAuthenticator(apiKey: "AjB3RJCwfpoTATa05-3ZsEKHtIXKXno2HgTMVPizvFyi")
    private let assistant: Assistant
    private let assistantID = "38f70976-e9af-4332-b33a-0f4197c09bd9"
    private var context: MessageContextStateless = MessageContextStateless()

    init(){
        assistant = Assistant(version: "2020-06-14", authenticator: authenticator)
        assistant.serviceURL = "https://api.us-south.assistant.watson.cloud.ibm.com/instances/d2b1cc14-ee89-4027-b482-b791349859cb"
    }


    func sendTextToAssistant(text: String, completion: @escaping(Result<MessageResponseStateless,WatsonError>) -> Void) {
        
        let input = MessageInputStateless(messageType: "text", text: text)

        self.assistant.messageStateless(assistantID: self.assistantID, input: input, context: context){ (response, error) in

            guard let result = response?.result else {

                print("Error occured. ")
                completion(.failure(WatsonError.noResponse))
                return
            }
            
            self.context = result.context

            completion(.success(result))

        }
    }
    
    func processGenericResponse(assistantResponse: [RuntimeResponseGeneric]) -> String {
      
        var message = ""
        
        SwiftlyApp.incomingChatbotMessages.removeAll()
        
        for response in assistantResponse {
            switch response {
            case let .text(innerResponse):
                message = innerResponse.text
                let newMessage = Message(text: message, sender: Message.Sender.chatbot)
                /// saving response in static array of messages
                SwiftlyApp.incomingChatbotMessages.append(newMessage)
            default:
                return "Something went wrong..."
            }
        }
        
        return message
    }
}
