//
//  LoginViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var PassText: UITextField!
    @IBOutlet weak var UsernameText: UITextField!
    var response: LoginResponse!
    var response2: LoginResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        LoadToken()
    }
   
    

    @IBAction func Button(_ sender: Any) {
        if(self.response.success == 1){
//            CheckUser(username: self.UsernameText.text!, pass: self.PassText.text!,request_token: self.response.request_token)
            print("entre")
        }
        print(Router.getToken.urlRequest!)
        print(Router.login(username: self.UsernameText.text!, password: self.PassText.text!,request_token: self.response.request_token).urlRequest!)
        
        
      
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
                case .success(let response): self.response2 = response ;
                case .failure(let error ): print(error)
                }
            
//            print("Login \(self.response2.expires_at?) dio \(self.response2.success?)" )
            })
    }

}
