import UIKit

final class LoginViewController: UIViewController, LoginView {

  var presenter: LoginPresenter!

  private var setUpButton: UIBarButtonItem!
  private var isSetUpButtonTapped = false

  // titleLabel
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Login"
    label.font = UIFont(name: "Shrikhand-Regular", size: 24)
    label.textColor = UIColor(named: "mainGray") ?? UIColor.gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // mailAdressLabel
  private let mailAddressLabel: UILabel = {
    let label = UILabel()
    label.text = "mail address"
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor(named: "subGray") ?? UIColor.lightGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // mailAddressTextFiled
  private let mailAddressTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.clearButtonMode = .whileEditing
    textField.keyboardType = .emailAddress
    return textField
  }()

  // mailAddressTextFiledのアンダーライン
  private let mailAddressTextFieldUnderlineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "mainGray") ?? UIColor.gray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // passWordLabel
  private let passWordLabel: UILabel = {
    let label = UILabel()
    label.text = "pass word"
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor(named: "subGray") ?? UIColor.lightGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // passWordTextFiled
  private let passWordTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isSecureTextEntry = true
    textField.clearButtonMode = .whileEditing
    return textField
  }()

  // mailAddressTextFiledのアンダーライン
  private let passWordTextFieldUnderlineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "mainGray") ?? UIColor.gray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
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

  // titleTextFiled
  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

  // titleTextFiledのアンダーライン
  private let nameTextFieldUnderlineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "mainGray") ?? UIColor.gray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // LoginButton
  private let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Login", for: .normal)
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

  override func viewDidLoad() {
    super.viewDidLoad()
      view.backgroundColor = UIColor(named: "mainYellow")
      loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
      setUpContents()
      setupKeyboardToolbar()
      presenter = LoginPresenter(view: self)
  }

  func setUpContents() {
    setUpNavigation()
    view.addSubview(titleLabel)
    view.addSubview(mailAddressLabel)
    view.addSubview(mailAddressTextField)
    view.addSubview(mailAddressTextFieldUnderlineView)
    view.addSubview(passWordLabel)
    view.addSubview(passWordTextField)
    view.addSubview(passWordTextFieldUnderlineView)
    view.addSubview(loginButton)
    setUpLoginConstraints()
  }

  private func resetUpView() {
    mailAddressLabel.removeFromSuperview()
    mailAddressTextField.removeFromSuperview()
    mailAddressTextFieldUnderlineView.removeFromSuperview()
    passWordLabel.removeFromSuperview()
    passWordTextField.removeFromSuperview()
    passWordTextFieldUnderlineView.removeFromSuperview()
    nameLabel.removeFromSuperview()
    nameTextField.removeFromSuperview()
    nameTextFieldUnderlineView.removeFromSuperview()
  }

  func setUpNavigation() {
    // サインアップボタンを作成
    setUpButton = UIBarButtonItem(title: "signup", style: .plain, target: self, action: #selector(setButtonTapped))
    // カスタムフォントを適用したいタイトルフォントを設定
    let font = UIFont.systemFont(ofSize: 12) // フォントサイズを指定
    let normalAttributes: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: UIColor(named: "subGray") ?? UIColor.lightGray // カスタムのボタンタイトル色
    ]
    setUpButton.setTitleTextAttributes(normalAttributes, for: .normal)
    let highlightedAttributes: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: UIColor(named: "subGray") ?? UIColor.lightGray // カスタムのタップ時のタイトル色
    ]
    setUpButton.setTitleTextAttributes(highlightedAttributes, for: .highlighted)
    // ボタンをナビゲーションバーに追加
    navigationItem.rightBarButtonItem = setUpButton
  }

  // ボタンのアクション
    @objc func setButtonTapped() {
        isSetUpButtonTapped.toggle()
        if isSetUpButtonTapped {
            // タイトルをsignupに戻す
            setUpButton.title = "login"
            titleLabel.text = "Sign up"
            loginButton.setTitle("Sign up", for: .normal)
            loginButton.removeTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
            loginButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
            resetUpView()
            setUpSignUpConstraints()
        } else {
            // タイトルをloginに変更
            setUpButton.title = "sign up"
            titleLabel.text = "Login"
            loginButton.setTitle("Login", for: .normal)
            loginButton.removeTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
            loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
            resetUpView()
            setUpContents()
        }
    }

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
    ])
    NSLayoutConstraint.activate([
      mailAddressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
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
  }

  private func setUpLoginConstraints() {
    view.addSubview(mailAddressLabel)
    view.addSubview(mailAddressTextField)
    view.addSubview(mailAddressTextFieldUnderlineView)
    view.addSubview(passWordLabel)
    view.addSubview(passWordTextField)
    view.addSubview(passWordTextFieldUnderlineView)
    view.addSubview(loginButton)
    setUpConstraints()
    NSLayoutConstraint.activate([
      passWordLabel.topAnchor.constraint(equalTo: mailAddressTextFieldUnderlineView.bottomAnchor, constant: 30),
      passWordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
    ])
    NSLayoutConstraint.activate([
      passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor, constant: 3),
      passWordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      passWordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
    ])
    NSLayoutConstraint.activate([
      passWordTextFieldUnderlineView.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 5),
      passWordTextFieldUnderlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      passWordTextFieldUnderlineView.trailingAnchor.constraint(equalTo: passWordTextField.trailingAnchor),
      passWordTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
    ])
    NSLayoutConstraint.activate([
      loginButton.topAnchor.constraint(equalTo: passWordTextFieldUnderlineView.bottomAnchor, constant: 50),
      loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
      loginButton.widthAnchor.constraint(equalToConstant: 320),
      loginButton.heightAnchor.constraint(equalToConstant: 45)
    ])
  }

  private func setUpSignUpConstraints() {
    view.addSubview(mailAddressLabel)
    view.addSubview(mailAddressTextField)
    view.addSubview(mailAddressTextFieldUnderlineView)
    view.addSubview(passWordLabel)
    view.addSubview(passWordTextField)
    view.addSubview(passWordTextFieldUnderlineView)
    view.addSubview(nameLabel)
    view.addSubview(nameTextField)
    view.addSubview(nameTextFieldUnderlineView)
    setUpConstraints()

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: mailAddressTextFieldUnderlineView.bottomAnchor, constant: 30),
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
      passWordLabel.topAnchor.constraint(equalTo: nameTextFieldUnderlineView.bottomAnchor, constant: 30),
      passWordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
    ])

    NSLayoutConstraint.activate([
      passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor, constant: 3),
      passWordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      passWordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
    ])

    NSLayoutConstraint.activate([
      passWordTextFieldUnderlineView.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 5),
      passWordTextFieldUnderlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      passWordTextFieldUnderlineView.trailingAnchor.constraint(equalTo: passWordTextField.trailingAnchor),
      passWordTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
    ])

    NSLayoutConstraint.activate([
      loginButton.topAnchor.constraint(equalTo: passWordTextFieldUnderlineView.bottomAnchor, constant: 50),
      loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
      loginButton.widthAnchor.constraint(equalToConstant: 320),
      loginButton.heightAnchor.constraint(equalToConstant: 45)
    ])
  }

    private func setupKeyboardToolbar() {
        // Doneボタンを表示するためのツールバーを作成
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Doneボタンを作成
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = UIColor(named: "mainGray") ?? UIColor.gray

        // ボタンをツールバーに追加
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        // ツールバーをキーボードのアクセサリビューとして設定
        mailAddressTextField.inputAccessoryView = toolbar
        passWordTextField.inputAccessoryView = toolbar
        nameTextField.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        // キーボードを閉じる処理
        view.endEditing(true)
    }

    @objc func loginButtonPressed() {
        guard let email = mailAddressTextField.text, !email.isEmpty,
              let password = passWordTextField.text, !password.isEmpty else {
            showAlert(title: "入力エラー", message: "メールアドレスまたはパスワードが入力されていません")
            print("メールアドレスまたはパスワードが入力されていません")
            return
        }
        presenter.loginButtonPressed(email: email, password: password)
    }

    @objc func signupButtonPressed() {
        guard let email = mailAddressTextField.text, !email.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let password = passWordTextField.text, !password.isEmpty else {
            showAlert(title: "入力エラー", message: "メールアドレスまたは名前またはパスワードが入力されていません")
            print("メールアドレスまたは名前またはパスワードが入力されていません")
            return
        }
        presenter.loginButtonPressed(email: email, password: password)
    }

    func onLoginSuccess() {
        print("success")
    }

    func onLoginFailure() {
        print("何かが違うよ")
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
