//
//  LoginViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var MainImage: UIImageView!
    @IBOutlet weak var PassText: UITextField!
    @IBOutlet weak var WarningLabel: UILabel!
    @IBOutlet weak var UsernameText: UITextField!
    var response: LoginResponse!
    var response2: LoginResponse!
    var response3: Session?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.WarningLabel.text = ""
        // Do any additional setup after loading the view.
        self.MainImage.image = UIImage(named:"tmdb.png")
        LoadToken()
    }
   
    

    @IBAction func Button(_ sender: Any) {
        if(self.response.success == 1){
        CheckUser(username: self.UsernameText.text!, pass: self.PassText.text!,request_token: self.response.request_token)
            print("entre")
        }

        
//        if(self.response3.success == 1 ){
//        }
//
        
        let url = Router.login(username: self.UsernameText.text!, password: self.PassText.text!,request_token: self.response.request_token)
//        print(url.urlRequest!)

//        APIClient.shared.requestItem(request: url, onCompletion: { (result: Result<LoginResponse,Error>) in
//            switch (result){
//            case .success(let response): self.response = response ;
//            case .failure(let error ): print(error)
//            }
//            print("Token \(self.response.request_token!) dio \(self.response.success!)" )
//        })
        
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func LoadToken(){
        APIClient.shared.requestItem(request: Router.getToken, onCompletion:{(result:Result<LoginResponse,Error>)
                in
                switch (result){
                case .success(let response): self.response = response ;
                case .failure(let error ): print(error)
                }
            print("Token \(self.response.request_token!) dio \(self.response.success!)" )
            })
    }
    
    func CheckUser(username: String, pass:String,request_token: String){
        APIClient.shared.requestItem(request: Router.login(username: username, password: pass, request_token: request_token), onCompletion:{(result:Result<LoginResponse,Error>)
                in
                switch (result){
                case .success(let response): self.response2 = response ;           self.getSession(request_token: self.response2.request_token)
                case .failure(let error ):print(error)
                    let message : String
                    if let httpStatusCode = error.asAFError?.responseCode {
                        switch(httpStatusCode) {
                        case 400:
                            message = "Username or password not provided."
                        case 401:
                            message = "Incorrect password for user ."
                        default:
                        message = "no entre en ninguno"
                        }
                        
                        self.WarningLabel.text = message
                    }
                }
            })
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func getSession(request_token: String){
        APIClient.shared.requestItem(request:Router.getSession(request_token: self.response2.request_token), onCompletion:{(result:Result<Session,Error>)
                in
                switch (result){
                case .success(let response): self.response3 = response ;
                    self.performSegue(withIdentifier: "loginsegue", sender: self)
                    Settings.shared.sessionId = self.response3!.session_id!
                case .failure(let error ): print(error)
                }
            
            })
//        if let session = self.response3!.session_id {
//            print(session)
//        }
        
        


    }
    

}
