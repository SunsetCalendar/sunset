import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ナビゲーションバー隠す
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        Twitter.sharedInstance().logIn(completion: {
            session, error in
            // ログインセッションが残っていたら、そのままメイン画面へ飛ばす
            if (session != nil) {
                self.performSegue(withIdentifier: "showMain", sender: nil)
            
            // ログインしてなかったら、ログインびたんを表示した画面を挟む
            } else {
                let loginButton = TWTRLogInButton(logInCompletion: {
                    session, error in
                    if session != nil {
                        self.performSegue(withIdentifier: "showMain", sender: nil)
                    } else {
                        print(error?.localizedDescription)
                    }
                })
                loginButton.center = self.view.center
                self.view.addSubview(loginButton)
                
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ステータスバーを隠す
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
}

