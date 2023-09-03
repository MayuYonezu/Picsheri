import UIKit

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
        let alertController = UIAlertController(title: "保存完了", message: "保存が完了しました", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil) // ここで画面遷移を行う
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @objc private func logoutButtonTapped() {
        let alertController = UIAlertController(title: "", message: "本当にログアウトしますか？", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "はい", style: .default) { (_) in
            let transition = CATransition()
            transition.duration = 1
            transition.type = CATransitionType.fade
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)

        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
