import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    private var saveButton: UIBarButtonItem!
    private var isSetUpButtonTapped = false
    
    // titleLabel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont(name: "Shrikhand-Regular", size: 24)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // nameLabel
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "subGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // nameTextFiled
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = UserModel.shared.name
        textField.textColor = UIColor(named: "mainGray") ?? UIColor.gray
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // nameTextFiledのアンダーライン
    private let nameTextFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainGray") ?? UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // mailAddressLabel
    private let mailAddressLabel: UILabel = {
        let label = UILabel()
        label.text =  "mail address"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "subGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // mailAddressTextFiled
    private let mailAddressTextField: UITextField = {
        let textField = UITextField()
        textField.text = UserModel.shared.email
        textField.textColor = UIColor(named: "mainGray") ?? UIColor.gray
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // mailAddressTextFiledのアンダーライン
    private let mailAddressTextFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainGray") ?? UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // LoginButton
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor(named: "mainYellow"), for: .normal)
        button.backgroundColor = UIColor(named: "mainGray")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 22.5
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor(named: "mainYellow"), for: .normal)
        button.backgroundColor = UIColor(named: "subGray")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 22.5
        button.layer.shadowColor = UIColor(named: "subGray")?.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainYellow")
        setUp()
        setUpNavigation()
    }
    
    func setUp() {
        view.addSubview(titleLabel)
        view.addSubview(mailAddressLabel)
        view.addSubview(mailAddressTextField)
        view.addSubview(mailAddressTextFieldUnderlineView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(nameTextFieldUnderlineView)
        view.addSubview(editButton)
        view.addSubview(logoutButton)
        setUpConstraints()
        addDoneButton()
    }
    
    func setUpNavigation() {
        // Navigation Barに戻るボタンを追加
        let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // ボタンのアクション
    @objc func setButtonTapped() {
    }
    
    private func setUpConstraints() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            nameTextFieldUnderlineView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            nameTextFieldUnderlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextFieldUnderlineView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            nameTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            mailAddressLabel.topAnchor.constraint(equalTo: nameTextFieldUnderlineView.bottomAnchor, constant: 30),
            mailAddressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            mailAddressTextField.topAnchor.constraint(equalTo: mailAddressLabel.bottomAnchor, constant: 3),
            mailAddressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mailAddressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            mailAddressTextFieldUnderlineView.topAnchor.constraint(equalTo: mailAddressTextField.bottomAnchor, constant: 5),
            mailAddressTextFieldUnderlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mailAddressTextFieldUnderlineView.trailingAnchor.constraint(equalTo: mailAddressTextField.trailingAnchor),
            mailAddressTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: mailAddressTextFieldUnderlineView.bottomAnchor, constant: 50),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            editButton.widthAnchor.constraint(equalToConstant: 320),
            editButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            logoutButton.widthAnchor.constraint(equalToConstant: 320),
            logoutButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc private func editButtonTapped() {
        let userUID = UserModel.shared.uid ?? ""
        guard let newName = nameTextField.text, !newName.isEmpty,
              let newEmail = mailAddressTextField.text, !newEmail.isEmpty else {
            // 入力が不正の場合、アラートを表示して処理を中断する
            showAlert(title: "エラー", message: "名前とメールアドレスを入力してください")
            return
        }
        
        // パスワード入力用のアラートを表示
        let passwordAlert = UIAlertController(title: "変更を保存する", message: "パスワードを入力してください", preferredStyle: .alert)
        passwordAlert.addTextField { textField in
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
        }
        passwordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        passwordAlert.addAction(UIAlertAction(title: "確定", style: .default) { _ in
            if let password = passwordAlert.textFields?.first?.text {
                // ユーザーの再認証を行う
                self.reauthenticateUser(currentPassword: password) { [weak self] success in
                    if success {
                        // メールアドレスの更新などの操作を行う
                        // ここにメールアドレスの更新コードを記述
                        self?.updateEmail(newEmail) { success in
                            if success {
                                // Firestore のユーザードキュメントを更新
                                let userDocRef = Firestore.firestore().collection("users").document(userUID)
                                userDocRef.updateData([
                                    "name": newName,
                                    "email": newEmail
                                ]) { [weak self] error in
                                    if let error = error {
                                        self?.showAlert(title: "エラー", message: "プロフィールの更新に失敗しました: \(error.localizedDescription)")
                                    } else {
                                        self?.showAlert(title: "成功", message: "プロフィールが更新されました")
                                        UserModel.shared.name = newName
                                        UserModel.shared.email = newEmail
                                    }
                                }
                            } else {
                                // メールアドレスの更新が失敗した場合の処理
                                // 例: アラートを表示
                            }
                        }
                    } else {
                        self?.showAlert(title: "エラー", message: "再認証に失敗しました。正しいパスワードを入力してください。")
                    }
                }
            }
        })
        
        present(passwordAlert, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func logoutButtonTapped() {
        let alertController = UIAlertController(title: "", message: "本当にログアウトしますか？", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "はい", style: .default) { (_) in
            UserDefaults.standard.removeObject(forKey: "userUID")
            UserDefaults.standard.synchronize()
            let transition = CATransition()
            transition.duration = 1
            transition.type = CATransitionType.fade
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func addDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        doneButton.tintColor = UIColor(named: "mainGray")
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        nameTextField.inputAccessoryView = toolBar
        mailAddressTextField.inputAccessoryView = toolBar
    }
    
    
    @objc private func doneButtonTapped() {
        view.endEditing(true) // キーボードやピッカービューを閉じる
    }
    
    private func reauthenticateUser(currentPassword: String, completion: @escaping (Bool) -> Void) {
        let user = Auth.auth().currentUser
        
        // ユーザーを再認証するための認証情報を作成
        let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: currentPassword)
        
        // ユーザーの再認証を試みる
        user?.reauthenticate(with: credential) { _, error in
            if let error = error {
                // 再認証に失敗した場合
                completion(false)
            } else {
                // 再認証に成功した場合
                completion(true)
            }
        }
    }
    
    private func updateEmail(_ newEmail: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
            if let error = error {
                print("メールアドレスの更新に失敗: \(error.localizedDescription)")
                completion(false)
            } else {
                print("メールアドレスを更新")
                completion(true)
            }
        }
    }
    
    func updateEmailInFirestore(_ newEmail: String, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let userReference = Firestore.firestore().collection("users").document(uid)
        
        userReference.updateData(["email": newEmail]) { error in
            if let error = error {
                print("Firestore email update error: \(error)")
                completion(false)
            } else {
                print("Firestore email update success")
                completion(true)
            }
        }
    }
    
}
