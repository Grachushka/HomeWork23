import UIKit

//Написать playground, в котором будет несколько нотификаций разных, которые кто-то будет отправлять и кто-то принимать. И продемонстрировать правильную работу.

extension Notification.Name {
    
    static let post = Notification.Name("Post")
    static let postInfoAboutNameBook = Notification.Name("PostInfoAboutNameBook")
}

class BookMarket {
    
    func sendMessage(text: String) {
        print("We have new Book: \(text)!")
        NotificationCenter.default.post(name: .postInfoAboutNameBook, object: text)
    }
}

class Human {
    
    private let name: String
    
    init(name: String) {
        
        self.name = name
        
        observePost()
    }
    
    deinit {
        
           NotificationCenter.default.removeObserver(self)
       }
       
       func observePost() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(messageReceived(_:)), name: .postInfoAboutNameBook, object: nil)
       
    }
    
    @objc
    private func messageReceived(_ notification: Notification) {
        guard let nameOfBook = notification.object as? String else {
            return
        }
        
        print("We get new book said \(name) with name \(nameOfBook)")
    }
}

let human1 = Human(name: "Paul")
let human2 = Human(name: "Eul")
let human3 = Human(name: "Georgio")

let bookMarket = BookMarket()

bookMarket.sendMessage(text: "Harry Potter 6")


class ViewController {
    let id: String

    init(id: String) {
        self.id = id

        observePost()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func observePost() {
        NotificationCenter.default.addObserver(self, selector: #selector(messageReceived(_:)), name: .post, object: nil)
    }

    @objc
    private func messageReceived(_ notification: Notification) {
        guard let message = notification.object as? String else {
            return
        }

        print("\(id): Message received: \(message)")
    }
}



class Poster {
//    static let postNotifName = Notification.Name("Post")

    func sendMessage(text: String) {
        print("Going to send message: \(text)")
        NotificationCenter.default.post(name: .post, object: text)
    }
}

let poster = Poster()

poster.sendMessage(text: "Hello everyone!")

let vc1 = ViewController(id: "1")
let vc2 = ViewController(id: "2")
let vc3 = ViewController(id: "3")

poster.sendMessage(text: "Hello everyone!(2)")
