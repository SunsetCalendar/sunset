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

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Twitter
//        if (indexPath.row == 2) {
//            // Twitter 連携していない場合のみ, 押したらログイン遷移するようにする
//            if (self.sessionStore.session()?.userID != nil) {
//                Twitter.sharedInstance().logIn {
//                    (session, error) -> Void in
//                    if (session != nil) {
//                        print("signed in: \(session?.userName)");
//                    } else {
//                        print("Error：\(error?.localizedDescription)");
//                    }
//                }
//            }
//        }
//    }

    // アカウント連携セル用
    private func insertAccountContents(indexPath: IndexPath) -> UITableViewCell {
        if (self.optionIndex.contains(indexPath.row - 1)) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "settingsTitlesViewCell", for: indexPath) as! SettingsTitlesViewCell
            cell.settingsTitleLabel.text = settingsText[indexPath.row - 1]
            cell.settingsTitleLabel.font = UIFont(name: "HirakakuProN-W6", size: 12)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountsTableCell", for: indexPath) as! AccountsTableViewCell
            if (self.sessionStore.session()?.userID != nil) {
                cell.checked.font = UIFont.fontAwesome(ofSize: 14)
                cell.checked.text = String.fontAwesomeIcon(name: .check)
            } else {
                cell.checked.text = ""
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
}
