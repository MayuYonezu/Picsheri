import UIKit
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class PostViewController: UIViewController {
    
    private var saveButton: UIBarButtonItem!
    
    var selectedMember: String?
    private var memberPicker: UIPickerView!
    private var members: [String] = []
    
    let geocoder = CLGeocoder()
    var place_longitude: CLLocationDegrees = 0.0
    var place_latitude: CLLocationDegrees = 0.0
    
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
    
    private let memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        return imageView
    }()
    
    private let memberTextField: UITextField = {
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
    
    private let memberTextFieldUnderlineView: UIView = {
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
        textField.font = UIFont.systemFont(ofSize: 10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10)
        ]
        let attributedPlaceholder = NSAttributedString(string: "場所", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
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
        view.addSubview(memberImageView)
        view.addSubview(memberTextField)
        view.addSubview(memberTextFieldUnderlineView)
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
        fetchMembersFromFirebase()
        print(members)
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

    @objc func postButtonTapped() {
        if let errorMessage = validateFields() {
            displayAlert(message: errorMessage)
        } else {
            if let member = memberTextField.text {
                saveMemberIconToFirestore(member: member)
                uploadImageAndSaveToFirestore()
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func setUpConstraints() {
        memberTextField.delegate = self
        memberTextField.inputView = memberPicker
        dateTextField.delegate = self
        placeTextField.delegate = self
        titleTextField.delegate = self
        setupKeyboardToolbar()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        memberTextField.inputView = pickerView
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 3.0/4.0)
        ])
        
        NSLayoutConstraint.activate([
            memberImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            memberImageView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            memberImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            memberImageView.heightAnchor.constraint(equalTo: memberImageView.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            memberTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            memberTextField.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 7),
            memberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            memberTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            memberTextFieldUnderlineView.topAnchor.constraint(equalTo: memberImageView.bottomAnchor, constant: 3),
            memberTextFieldUnderlineView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            memberTextFieldUnderlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            memberTextFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            dateImageView.topAnchor.constraint(equalTo: memberTextFieldUnderlineView.topAnchor, constant: 5),
            dateImageView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            dateImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            dateImageView.heightAnchor.constraint(equalTo: dateImageView.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: memberTextFieldUnderlineView.bottomAnchor, constant: 6),
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
    
    private func saveMemoryToFirestore() {
        // 必要な情報を取得
        let place = placeTextField.text ?? ""
        let date = dateTextField.text ?? ""
        let member = memberTextField.text ?? ""
        let longitude = place_longitude
        let latitude = place_latitude
        let comment = commentTextView.text ?? ""
        let title = titleTextField.text ?? ""
        
        // Firestoreにデータを追加
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        let data: [String: Any] = [
            "place": place,
            "date": date,
            "member": member,
            "longitude": longitude,
            "latitude": latitude,
            "comment": comment,
            "title": title
        ]
        
        // usersコレクションの下にuidのドキュメント内のmemoryサブコレクションにデータを追加
        db.collection("users").document(uid).collection("memory").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
                self.showAlert(title: "エラー", message: "保存に失敗しました。")
            } else {
                print("Document added successfully.")
                // データ追加が成功したら何らかの処理を行う（例: 画面遷移など）
            }
        }
    }
    private func validateFields() -> String? {
        if memberTextField.text?.isEmpty ?? true {
            return "アイコンが入力されていません"
        }
        if dateTextField.text?.isEmpty ?? true {
            return "日付が入力されていません"
        }
        if placeTextField.text?.isEmpty ?? true {
            return "場所が入力されていません"
        }
        if titleTextField.text?.isEmpty ?? true {
            return "タイトルが入力されていません"
        }
        if commentTextView.text?.isEmpty ?? true {
            return "コメントが入力されていません"
        }
        return nil
    }
    
    private func displayAlert(message: String) {
        let alertController = UIAlertController(title: "入力エラー", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func convertImageToJPEG(image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 0.8) // JPEGデータに変換
    }

    private func convertJPEGToBase64(jpegData: Data) -> String? {
        return jpegData.base64EncodedString(options: [])
    }

    private func uploadImageToStorage(imageData: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                imageRef.downloadURL { url, error in
                    if let url = url {
                        completion(.success(url))
                    } else if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    private func uploadImageAndSaveToFirestore() {
        if let image = postImageView.image,
           let jpegData = convertImageToJPEG(image: image),
           let base64String = convertJPEGToBase64(jpegData: jpegData) {
            
            uploadImageToStorage(imageData: jpegData) { result in
                switch result {
                case .success(let url):
                    // アップロード成功した場合の処理
                    print("Image uploaded successfully. URL: \(url)")
                    
                    // Firestore にデータを保存
                    self.saveMemoryToFirestore(imageURL: url, base64String: base64String)
                case .failure(let error):
                    // アップロード失敗した場合の処理
                    print("Image upload failed. Error: \(error.localizedDescription)")
                }
            }
        } else {
            // 画像が選択されていない場合の処理
        }
    }
    
    private func saveMemoryToFirestore(imageURL: URL, base64String: String) {
        // 必要な情報を取得
        let place = placeTextField.text ?? ""
        let date = dateTextField.text ?? ""
        let member = memberTextField.text ?? ""
        let longitude = place_longitude
        let latitude = place_latitude
        let comment = commentTextView.text ?? ""
        let title = titleTextField.text ?? ""
        
        // Firestoreにデータを追加
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        let data: [String: Any] = [
            "place": place,
            "date": date,
            "member": member,
            "longitude": longitude,
            "latitude": latitude,
            "comment": comment,
            "title": title,
            "imageURL": imageURL.absoluteString,
        ]
        
        // usersコレクションの下にuidのドキュメント内のmemoryサブコレクションにデータを追加
        db.collection("users").document(uid).collection("memory").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
                self.showAlert(title: "エラー", message: "保存に失敗しました。")
            } else {
                print("Document added successfully.")
                // データ追加が成功したら何らかの処理を行う（例: 画面遷移など）
            }
        }
    }
    
    private func saveMemberIconToFirestore(member: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not logged in.")
            return
        }
        
        let db = Firestore.firestore()
        let memberRef = db.collection("users").document(uid).collection("members")
        
        // アイコン名の重複チェック
        memberRef.whereField("member", isEqualTo: member).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error checking duplicate member: \(error)")
                return
            }
            
            if querySnapshot?.documents.isEmpty == true {
                // 重複がない場合のみデータを追加
                let data: [String: Any] = [
                    "member": member
                ]
                
                memberRef.addDocument(data: data) { error in
                    if let error = error {
                        print("Error adding member member document: \(error)")
                    } else {
                        print("Member member document added successfully.")
                    }
                }
            } else {
                print("Icon already exists.")
            }
        }
    }

    private func fetchMembersFromFirebase() {
        let db = Firestore.firestore()
        let membersCollection = db.collection("users").document(UserModel.shared.uid ?? "").collection("members")

        membersCollection.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching members: \(error.localizedDescription)")
                return
            }

            var memberNames: [String] = []

            for document in querySnapshot!.documents {
                if let memberName = document.data()["member"] as? String {
                    memberNames.append(memberName)
                }
            }

            self.members = memberNames
            print("取り出す", memberNames)
        }
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
        //        addDoneButtonAndAddButtonToPickerView()
        memberTextFieldTapped()
        if textField == dateTextField {
            return false
        }
        if textField == placeTextField {
            textField.resignFirstResponder()
            if let searchText = textField.text {
                searchLocation(searchText)
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == placeTextField {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                searchLocation(updatedText)
            }
            return true
        } else if textField == titleTextField {
            return true
        } else {
            return false
        }
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
        memberTextField.inputAccessoryView = toolBar
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true) // キーボードやピッカービューを閉じる
    }
    
    @objc private func addButtonTapped() {
        showIconInputAlert()
    }
    
    private func memberTextFieldTapped() {
        if members.isEmpty {
            // Pickerの中身が空の場合、アラートを表示してアイコン入力画面に遷移
            showIconInputAlert()
        } else {
            addDoneButtonAndAddButtonToPickerView()
        }
    }
    
    func showIconInputAlert() {
        let alertController = UIAlertController(title: "新しい推しを追加", message: "推しの名前を入力してください", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "推しの名前"
        }
        
        let addAction = UIAlertAction(title: "追加", style: .default) { (_) in
            if let newOption = alertController.textFields?.first?.text, !newOption.isEmpty {
                self.members.append(newOption) // リストに選択肢を追加
                self.memberTextField.text = newOption // テキストフィールドに選択肢を表示
            } else {
                self.memberTextField.text = self.members.first // リストの1番目の選択肢を表示
            }
            self.memberTextField.resignFirstResponder() // ピッカービューを閉じる
            self.memberTextField.reloadInputViews() // ピッカービューの再読み込み
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
        placeTextField.inputAccessoryView = toolbar
        titleTextField.inputAccessoryView = toolbar
        commentTextView.inputAccessoryView = toolbar
    }
    
    func searchLocation(_ searchText: String) {
        geocoder.geocodeAddressString(searchText) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                print("Found location: \(self.place_latitude), \(self.place_longitude)")
                // ここで取得した座標を変数に代入
                self.place_latitude = location.coordinate.latitude
                self.place_longitude = location.coordinate.longitude
                print("確定: \(self.place_latitude), \(self.place_longitude)")
            } else {
                print("No matching location found.")
            }
        }
    }
}

extension PostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return members.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return members[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // ピッカービューで選択された内容を処理する
        selectedMember = members[row]
        memberTextField.text = selectedMember
    }
}
