import UIKit

class PostViewController: UIViewController {

    private var saveButton: UIBarButtonItem!

    var memberList = ["A","B","C","D","E"]
    var selectedMember: String?
    var selectedMemberIndex: Int?

    var postImage: UIImage? {
        didSet {
            postImageView.image = postImage
        }
    }

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "post")
        return imageView
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        return imageView
    }()

    private let iconTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .clear
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10)]
        let attributedPlaceholder = NSAttributedString(string: "推しの名前", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    private let iconTextFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "subGray") ?? UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "calendar")
        return imageView
    }()

    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .clear
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let currentDate = dateFormatter.string(from: Date())
        textField.text = currentDate
        return textField
    }()

    private let dateTextFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "subGray") ?? UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "mappin.circle")
        return imageView
    }()

    private let placeTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .clear
        textField.font = UIFont.systemFont(ofSize: 10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10) // 任意のフォントサイズを指定
        ]
        let attributedPlaceholder = NSAttributedString(string: "場所", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let placeTextFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "subGray") ?? UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 18)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12) // 任意のフォントサイズを指定
        ]
        let attributedPlaceholder = NSAttributedString(string: "タイトルを入力してください", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let titleTextFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "subGray") ?? UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let commentTextView: UITextView = {
        let textView = PlaceholderTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = UIColor.clear
        textView.placeholder = "コメントを入力してください"
        textView.layer.borderColor = UIColor(named: "subGray")?.cgColor
        textView.layer.borderWidth = 1.0
        return textView
    }()

    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
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
        view.addSubview(postImageView)
        view.addSubview(iconImageView)
        view.addSubview(iconTextField)
        view.addSubview(iconTextFieldUnderlineView)
        view.addSubview(placeImageView)
        view.addSubview(placeTextField)
        view.addSubview(placeTextFieldUnderlineView)
        view.addSubview(dateImageView)
        view.addSubview(dateTextField)
        view.addSubview(dateTextFieldUnderlineView)
        view.addSubview(titleTextField)
        view.addSubview(titleTextFieldUnderlineView)
        view.addSubview(commentTextView)
        view.addSubview(postButton)
        setUpNavigation()
        setUpConstraints()
    }

    private func setUpNavigation() {

        navigationItem.title = "Post"

        // タイトルのフォントを変更
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Shrikhand-Regular", size: 24) ?? .systemFont(ofSize: 24) // 任意のフォントとサイズに変更
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes

        // Navigation Barに戻るボタンを追加
        let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        showAlert(title: "保存されていません", message: "このまま戻ると編集内容は破棄されます")
    }

    private func setUpConstraints() {
        iconTextField.delegate = self
        dateTextField.delegate = self
        placeTextField.delegate = self
        let pickerView = UIPickerView()
        pickerView.delegate = self
        iconTextField.inputView = pickerView

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 3.0/4.0)
        ])

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            iconImageView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1)
        ])

        NSLayoutConstraint.activate([
            iconTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            iconTextField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 7),
            iconTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            iconTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        ])

        NSLayoutConstraint.activate([
            iconTextFieldUnderlineView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 3),
            iconTextFieldUnderlineView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            iconTextFieldUnderlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            iconTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            dateImageView.topAnchor.constraint(equalTo: iconTextFieldUnderlineView.topAnchor, constant: 5),
            dateImageView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            dateImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            dateImageView.heightAnchor.constraint(equalTo: dateImageView.widthAnchor, multiplier: 1)
        ])

        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: iconTextFieldUnderlineView.bottomAnchor, constant: 6),
            dateTextField.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: 7),
            dateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dateTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        ])

        NSLayoutConstraint.activate([
            dateTextFieldUnderlineView.topAnchor.constraint(equalTo: dateImageView.bottomAnchor, constant: 3),
            dateTextFieldUnderlineView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            dateTextFieldUnderlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: dateTextFieldUnderlineView.topAnchor, constant: 5),
            placeImageView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            placeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            placeImageView.heightAnchor.constraint(equalTo: dateImageView.widthAnchor, multiplier: 1)
        ])

        NSLayoutConstraint.activate([
            placeTextField.topAnchor.constraint(equalTo: dateTextFieldUnderlineView.bottomAnchor, constant: 6),
            placeTextField.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 7),
            placeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            placeTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        ])

        NSLayoutConstraint.activate([
            placeTextFieldUnderlineView.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 3),
            placeTextFieldUnderlineView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            placeTextFieldUnderlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            placeTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            titleTextFieldUnderlineView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5),
            titleTextFieldUnderlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextFieldUnderlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: titleTextFieldUnderlineView.bottomAnchor, constant: 15),
            commentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentTextView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 30),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            postButton.widthAnchor.constraint(equalToConstant: 320),
            postButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

class PlaceholderTextView: UITextView {
    
    // プレースホルダーテキストを保持するプロパティ
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(placeholderLabel)
        
        // プレースホルダーラベルの制約を設定
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        // プレースホルダーラベルのフォントと背景色を設定
        placeholderLabel.font = UIFont.systemFont(ofSize: 12) // フォントサイズを変更
        placeholderLabel.backgroundColor = UIColor.clear // 背景色を透明に設定
        
        // テキストが変更されたときにプレースホルダーラベルを表示・非表示する
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        // プレースホルダーラベルを初期状態で表示
        showPlaceholderLabel()
    }
    
    @objc private func textDidChange() {
        if let text = self.text, text.isEmpty {
            showPlaceholderLabel()
        } else {
            hidePlaceholderLabel()
        }
    }
    
    private func showPlaceholderLabel() {
        placeholderLabel.isHidden = false
    }
    
    private func hidePlaceholderLabel() {
        placeholderLabel.isHidden = true
    }
}

extension PostViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // テキストフィールドがタップされた際にピッカービューを表示する処理
        addDoneButtonAndAddButtonToPickerView()
        if textField == dateTextField {
            return false
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    private func addDoneButtonAndAddButtonToPickerView() {
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
         let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
         let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

         doneButton.tintColor = UIColor(named: "mainGray")
         addButton.tintColor = UIColor(named: "mainGray")
         
         toolBar.setItems([addButton, spaceButton, doneButton], animated: false)
         
         iconTextField.inputAccessoryView = toolBar
     }

    @objc private func doneButtonTapped() {
        view.endEditing(true) // キーボードやピッカービューを閉じる
    }

    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "新しい選択肢を追加", message: "新しい選択肢を入力してください", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "選択肢を入力"
        }
        
        let addAction = UIAlertAction(title: "追加", style: .default) { (_) in
            if let newOption = alertController.textFields?.first?.text, !newOption.isEmpty {
                self.memberList.append(newOption) // リストに選択肢を追加
                self.iconTextField.text = newOption // テキストフィールドに選択肢を表示
            } else {
                self.iconTextField.text = self.memberList.first // リストの1番目の選択肢を表示
            }
            self.iconTextField.resignFirstResponder() // ピッカービューを閉じる
            self.iconTextField.reloadInputViews() // ピッカービューの再読み込み
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}

extension PostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return memberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return memberList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // ピッカービューで選択された内容を処理する
        selectedMember = memberList[row]
        iconTextField.text = selectedMember
        
        // 選択されたら他のテキストフィールドの選択をクリアする
        dateTextField.text = nil
        placeTextField.text = nil
    }
}
