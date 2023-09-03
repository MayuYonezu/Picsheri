import UIKit
import TOCropViewController

class MemberProfileViewController: UIViewController, UIImagePickerControllerDelegate, TOCropViewControllerDelegate, UINavigationControllerDelegate {

    var viewWidth: CGFloat = 0.0
    private var progressView: UIProgressView!

    private let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        // 白い縁の設定
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    private let nameButton: UIButton = {
        let button = UIButton()
        button.setTitle("name", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "mainGray") ?? UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainYellow")
        viewWidth = view.frame.width
        setUpNavigation()
        setUpContents()
        setUpScrollView()
    }

    private func setUpNavigation() {

        navigationItem.title = "Member"

        // タイトルのフォントを変更
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Shrikhand-Regular", size: 24) ?? .systemFont(ofSize: 24) // 任意のフォントとサイズに変更
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }

    private func setUpContents() {
        view.addSubview(profileButton)
        view.addSubview(nameButton)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        nameButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
        // progress1Viewをインスタンス化
        progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            profileButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            profileButton.heightAnchor.constraint(equalTo: profileButton.widthAnchor, multiplier: 1)
        ])

        profileButton.layer.masksToBounds = true
        profileButton.layer.cornerRadius = viewWidth * 0.25 / 2
        profileButton.clipsToBounds = true

        NSLayoutConstraint.activate([
            nameButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 5),
            nameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: nameButton.bottomAnchor, constant: 10),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            progressView.widthAnchor.constraint(equalToConstant: 150),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])

        progressView.progress = 0.9
    }

    private func setUpScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        view.addSubview(scrollView)
        // メモリービューを開いたときに少し右側にスクロール
        let xOffset = CGFloat(-20) // スクロールする横方向のオフセット
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)

        let numberOfViews = 10 // ここで表示するビューの数を設定
        let viewWidth = view.frame.width * 0.9
        let viewHeight = viewWidth * 5 / 4
        let spacing: CGFloat = 10
        let horizontalSpacing: CGFloat = 10
        let verticalSpacing: CGFloat = 15
        
        // Set content size of scroll view
        scrollView.contentSize = CGSize(width: (viewWidth + spacing + horizontalSpacing) * CGFloat(numberOfViews) - spacing, height: viewHeight + 2 * verticalSpacing)
        scrollView.showsHorizontalScrollIndicator = false
        
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            scrollView.heightAnchor.constraint(equalToConstant: viewHeight + 2 * verticalSpacing),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10)
        ])
        
        for i in 0..<numberOfViews {
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            let offsetX = (viewWidth + spacing + horizontalSpacing) * CGFloat(i)
            let offsetY = verticalSpacing
            whiteView.frame = CGRect(x: offsetX, y: offsetY, width: viewWidth, height: viewHeight)
            whiteView.layer.cornerRadius = 10
            whiteView.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
            whiteView.layer.shadowOpacity = 0.2
            whiteView.layer.shadowOffset = CGSize(width: 2, height: 2)
            whiteView.layer.shadowRadius = 5
            scrollView.addSubview(whiteView)
            addContentToWhiteView(whiteView)
        }
    }

    private func addContentToWhiteView(_ whiteView: UIView) {
        let postImageView = UIImageView()
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = UIColor(named: "subGray")
        // Aspect ratio constraint for 4:3
        let aspectRatioConstraint = postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor, multiplier: 4.0/3.0)
        aspectRatioConstraint.priority = .required // Make sure this constraint is satisfied
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        
        let commentTextView = UITextView()
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.text = "comment"
        commentTextView.font = UIFont.systemFont(ofSize: 12)
        commentTextView.isUserInteractionEnabled = false
        commentTextView.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        
        whiteView.addSubview(postImageView)
        whiteView.addSubview(titleLabel)
        whiteView.addSubview(commentTextView)
        
        NSLayoutConstraint.activate([
            aspectRatioConstraint, // Activate the aspect ratio constraint
            postImageView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            postImageView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 30),
            postImageView.widthAnchor.constraint(equalTo: whiteView.widthAnchor, multiplier: 0.9) // 90% width of whiteView
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            commentTextView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 10),
            commentTextView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -10),
            commentTextView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -15)
        ])
    }

    @objc private func nameButtonTapped() {
        let alertController = UIAlertController(title: "名前を変更する", message: "保存するとすぐに変更されます", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "名前"
        }
        
        let okAction = UIAlertAction(title: "保存", style: .default) { (_) in
            if let newName = alertController.textFields?.first?.text, !newName.isEmpty {
                self.nameButton.setTitle(newName, for: .normal)
            }
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }


    @objc func profileButtonTapped() {
        let alertController = UIAlertController(title: "プロフィール画像変更", message: "プロフィール画像を変更しますか？", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.modalPresentationStyle = .fullScreen
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image picker controller finished picking media")

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("Image selected: \(selectedImage)")
            let cropViewController = TOCropViewController(image: selectedImage)
            cropViewController.delegate = self
            cropViewController.doneButtonColor = UIColor(named: "subYellow")
            cropViewController.cancelButtonColor = UIColor(named: "mainYellow")
            cropViewController.customAspectRatio = CGSize(width: 1, height: 1)
            cropViewController.aspectRatioLockEnabled = true
            cropViewController.resetAspectRatioEnabled = false

            picker.present(cropViewController, animated: true, completion: nil)
        } else {
            print("No image selected")
            dismiss(animated: true, completion: nil)
        }
    }

    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        self.profileButton.setImage(image, for: .normal)
        cropViewController.dismiss(animated: true) {
            // UIImagePickerController を取得
            if let imagePickerController = self.presentedViewController as? UIImagePickerController {
                imagePickerController.dismiss(animated: true) {
                    // MemberProfileViewController に戻る
                    if let memberProfileViewController = self.presentingViewController as? MemberProfileViewController {
                        memberProfileViewController.profileButton.setImage(image, for: .normal)
                    }
                }
            }
        }
    }

    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
