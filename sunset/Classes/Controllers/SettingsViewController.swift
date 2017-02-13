import UIKit
import Foundation
import FontAwesome
import TwitterKit

extension UIColor {
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}

class SettingsViewController: UITableViewController {
    
    let settingsText = ["アカウント", "Twitter"]
    // 設定項目の見出しセルの index
    let optionIndex = [0, 2]
    let sessionStore = Twitter.sharedInstance().sessionStore
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AccountsTableViewCell", bundle: nil), forCellReuseIdentifier: "accountsTableCell")
        tableView.register(UINib(nibName: "SettingsTitlesViewCell", bundle: nil), forCellReuseIdentifier: "settingsTitlesViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 項目名の数 + 1 (タイトルセル)
        return self.settingsText.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 設定タイトル
        if (indexPath.row == 0) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "settingsTitlesViewCell", for: indexPath) as! SettingsTitlesViewCell
            cell.backgroundColor = UIColor(red: 255 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1.0)
            cell.settingsTitleLabel.font = UIFont.fontAwesome(ofSize: 16)
            cell.settingsTitleLabel.text = String.fontAwesomeIcon(name: .cog)
            return cell
        // アカウント連携セル
        } else if (indexPath.row < 3) {
            let cell = insertAccountContents(indexPath: indexPath)
            return cell
        // その他
        } else {
            let cell = insertThemeContents(indexPath: indexPath)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Twitter
        if (indexPath.row == 2) {
            // Twitter 連携していない場合のみ, 押したらログイン遷移するようにする
            if (self.sessionStore.session()?.userID == nil) {
                Twitter.sharedInstance().logIn {
                    (session, error) -> Void in
                    if (session != nil) {
                        // NOTE: 遷移という名の Main 画面の再描画
                        self.appDelegate.showMainView()
                    } else {
                        print("Error：\(error?.localizedDescription)")
                    }
                }
            }
        }
    }

    // アカウント連携セル用
    private func insertAccountContents(indexPath: IndexPath) -> UITableViewCell {
        if (self.optionIndex.contains(indexPath.row - 1)) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "settingsTitlesViewCell", for: indexPath) as! SettingsTitlesViewCell
            cell.settingsTitleLabel.text = settingsText[indexPath.row - 1]
            cell.settingsTitleLabel.font = UIFont(name: "HirakakuProN-W6", size: 12)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountsTableCell", for: indexPath) as! AccountsTableViewCell
            // ログインしている状態
            if (self.sessionStore.session()?.userID != nil) {

                // 連携しているアカウントには チェックマーク をつける
                cell.checked.font = UIFont.fontAwesome(ofSize: 14)
                cell.checked.text = String.fontAwesomeIcon(name: .check)
                // ログアウトボタン
                cell.logoutButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 16)
                cell.logoutButton.setTitle(String.fontAwesomeIcon(name: .signOut), for: .normal)
                cell.logoutButton.setTitleColor(UIColor.black, for: .normal)
                cell.logoutButton.addTarget(self, action: #selector(self.tappedLogoutButton(sender:)), for: .touchUpInside)
            } else {
                cell.checked.text = ""
                cell.logoutButton.titleLabel?.text = ""
            }
            cell.accountInfo.text = settingsText[indexPath.row - 1]
            cell.accountInfo.font = UIFont(name: "HirakakuProN-W3", size: 11)
            return cell
        }
    }

    // テーマ選択セル用
    private func insertThemeContents(indexPath: IndexPath) -> UITableViewCell {
        if (self.optionIndex.contains(indexPath.row - 1)) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "settingsTitlesViewCell", for: indexPath) as! SettingsTitlesViewCell
            cell.settingsTitleLabel.text = settingsText[indexPath.row - 1]
            cell.settingsTitleLabel.font = UIFont(name: "HirakakuProN-W6", size: 12)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountsTableCell", for: indexPath) as! AccountsTableViewCell
            cell.checked.text = ""
            cell.accountInfo.text = settingsText[indexPath.row - 1]
            cell.accountInfo.font = UIFont(name: "HirakakuProN-W3", size: 11)
            return cell
        }
    }

    @objc internal func tappedLogoutButton(sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "アカウント連携解除", message: "ログアウトしてもいいですか？", preferredStyle:  UIAlertControllerStyle.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            let sessionStore = Twitter.sharedInstance().sessionStore
            if let userId = sessionStore.session()?.userID {
                sessionStore.logOutUserID(userId)
            }
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理 (なにもしない)
            (action: UIAlertAction!) -> Void in
        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    }

}
