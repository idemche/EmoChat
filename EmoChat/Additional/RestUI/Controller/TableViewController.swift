//
//  TableViewController.swift
//  EmoChat
//
//  Created by Sergii Kyrychenko on 19.06.17.
//  Copyright © 2017 SoftServe. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var stringURL: String?
    var imageData: Data?



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func getImage(info: String) {
        stringURL = info
        let task = URLSession.shared.dataTask(with: (URL(string: info))!) {(data, responce, error) in

            if error != nil {
                print("error")
            }

            else {
                self.imageData = data
            }
        }
        task.resume()

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! TableViewCell

//        if imageData != nil && stringURL != nil {
//
//            cell.myImageInCell.image = UIImage(data: imageData!)
//            cell.myLabel.text = stringURL
//
//        }

        //getJsonData()
//        makeGetCall()
        dataRequest()


        return cell
    }


    override func viewDidLoad() {
        super .viewDidLoad()

    }


    //MARK:- Get Jddd

let urlToRequest: String = "https://urlembed.com/json/WDYyREZLSlU2TUk0Qlk2V0xMUklYM01JS0M1VUxJREZXVDZMUU1IQ0tXREhCN0s1TURGQT09PT0=/https://9gag.com/gag/aoOmXeA"

    func getJsonData() {

//        let urlString: String = "https://urlembed.com/json/WDYyREZLSlU2TUk0Qlk2V0xMUklYM01JS0M1VUxJREZXVDZMUU1IQ0tXREhCN0s1TURGQT09PT0=/https://9gag.com/gag/aoOmXeA"

//        let lobj_Request = NSMutableURLRequest(url: URL(string: urlString)!)
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: lobj_Request as URLRequest), completionHandler: { (data, response, error) -> Void in
//            do {
//                let str = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
//                print(str)
//            }
//            catch {
//                print("json error: \(error)")
//            }
//        })
//        task.resume()




//        let task = session.dataTask(with: lobj_Request as URLRequest) {
//            data, response, error in
//            print("Response: \(response)")
//
//            // Checking here Response
//            if response != nil {
//
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                print("Success: \(statusCode)")
//            }
//        }
//
    }

    func dataRequest() {
//        let url4 = URL(string: urlToRequest)!
//        let session4 = URLSession.shared
//        let request = NSMutableURLRequest(url: url4)
//        request.httpMethod = "POST"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//        let paramString = "data=Hello"
//        request.httpBody = paramString.data(using: String.Encoding.utf8)
//        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
//            guard let _: Data = data, let _: URLResponse = response, error == nil else {
//                print("*****error")
//                return
//            }
//            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
//        }
//        task.resume()



        //---------------
        let url = URL(string: urlToRequest)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
//            var session = URLSession()
//            session.delegate = self

//            var downloadsSession: URLSession = {
//                let configuration = URLSessionConfiguration.default
//                let session = URLSession(session: configuration, didReceiveChallenge: self, completionHandler: nil)
//                return session
//            }()
            let configuration = URLSessionConfiguration.default
            let sharedSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)

            let task = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                        print(stringData) //JSONSerialization
                    }
                }
                if error != nil {
                    print (error?.localizedDescription ?? "sm. error occured")
                }
            })
            task.resume()
        }

    }

//    func URLSession(session: URLSession,
//                    didReceiveChallenge challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
//    }





//    func makeGetCall() {
//        // Set up the URL request
//        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
//        guard let url = URL(string: todoEndpoint) else {
//            print("Error: cannot create URL")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//
//        // set up the session
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        // make the request
//        let task = session.dataTask(with: urlRequest) {
//            (data, response, error) in
//            // check for any errors
//            guard error == nil else {
//                print("error calling GET on /todos/1")
//                print(error)
//                return
//            }
//            // make sure we got data
//            guard let responseData = data else {
//                print("Error: did not receive data")
//                return
//            }
//            // parse the result as JSON, since that's what the API provides
//            do {
//                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
//                    print("error trying to convert data to JSON")
//                    return
//                }
//                // now we have the todo, let's just print it to prove we can access it
//                print("The todo is: " + todo.description)
//
//                // the todo object is a dictionary
//                // so we just access the title using the "title" key
//                // so check for a title and print it if we have one
//                guard let todoTitle = todo["title"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoTitle)
//            } catch  {
//                print("error trying to convert data to JSON")
//                return
//            }
//        }
//        
//        task.resume()
//    }







    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension TableViewController: URLSessionDelegate {

//    @nonobjc func URLSession(session: URLSession,
//                             didReceiveChallenge challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
//    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))

    }

//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//
//    }
}
