import UIKit
import TOCropViewController

final class MemberViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    private var profileButton: UIBarButtonItem!
    private var progress1View: UIProgressView!
    private var progress2View: UIProgressView!
    private var progress3View: UIProgressView!

    private let reuseIdentifier = "Cell"
    let images: [UIImage] = [UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "profile")!] // 表示する画像

    private let member1Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.masksToBounds = true // クリッピングを有効にする
        button.layer.cornerRadius = 50 // 半径の半分を指定して円形にクリッピング
        // 白い縁の設定
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    private let member1Label: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let member2Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.masksToBounds = true // クリッピングを有効にする
        button.layer.masksToBounds = true // クリッピングを有効にする
        button.layer.cornerRadius = 40 // 半径の半分を指定して円形にクリッピング
        // 白い縁の設定
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    private let member2Label: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let member3Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.masksToBounds = true // クリッピングを有効にする
        button.layer.masksToBounds = true // クリッピングを有効にする
        button.layer.cornerRadius = 40 // 半径の半分を指定して円形にクリッピング
        // 白い縁の設定
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    private let member3Label: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // 左側にスペースを設定

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
        collectionView.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        collectionView.layer.shadowOpacity = 0.2
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 2)
        collectionView.layer.shadowRadius = 5
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        let imageSize = CGSize(width: 50, height: 50) // 画像のサイズを設定
        let buttonImage = UIImage(named: "plus")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(named: "mainGray") // ボタンの色を設定
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainYellow")
        setUpNavigation()
        setUp()
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
    }

    private func setUpNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // サインアップボタンを作成
        profileButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(profileButtonTapped))
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)

        // カスタムフォントを適用したいタイトルフォントを設定
        let font = UIFont.systemFont(ofSize: 12) // フォントサイズを指定
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(named: "subGray") ?? UIColor.lightGray // カスタムのボタンタイトル色
        ]

        profileButton.setTitleTextAttributes(normalAttributes, for: .normal)
        let highlightedAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(named: "subGray") ?? UIColor.lightGray // カスタムのタップ時のタイトル色
        ]

        profileButton.setTitleTextAttributes(highlightedAttributes, for: .highlighted)
        // ボタンをナビゲーションバーに追加
        navigationItem.rightBarButtonItem = profileButton
        navigationItem.title = "Ranking"

        // タイトルのフォントを変更
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Shrikhand-Regular", size: 24) ?? .systemFont(ofSize: 24) // 任意のフォントとサイズに変更
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes

        member1Button.addTarget(self, action: #selector(memberButtonPressed), for: .touchUpInside)
        member2Button.addTarget(self, action: #selector(memberButtonPressed), for: .touchUpInside)
        member3Button.addTarget(self, action: #selector(memberButtonPressed), for: .touchUpInside)
    }

    @objc func memberButtonPressed() {
        let memberProfileViewController = MemberProfileViewController()
        navigationController?.pushViewController(memberProfileViewController, animated: true)
    }

    @objc func profileButtonTapped() {
        let profileViewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }

    @objc func plusButtonPressed() {
        print("push Image selected")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.modalPresentationStyle = .fullScreen
            present(imagePickerController, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image picker controller finished picking media")

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("Image selected: \(selectedImage)")
            let cropViewController = TOCropViewController(image: selectedImage)
            cropViewController.delegate = self
            cropViewController.doneButtonColor = UIColor(named: "subYellow")
            cropViewController.cancelButtonColor = UIColor(named: "mainYellow")
            cropViewController.customAspectRatio = CGSize(width: 4, height: 3)
            cropViewController.aspectRatioLockEnabled = true
            cropViewController.resetAspectRatioEnabled = false

            picker.present(cropViewController, animated: true, completion: nil)
        } else {
            print("No image selected")
            dismiss(animated: true, completion: nil)
        }
    }

    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        let postViewController = PostViewController()
        postViewController.postImage = image
        
        let postNavigationController = UINavigationController(rootViewController: postViewController)
        postNavigationController.modalPresentationStyle = .fullScreen
        cropViewController.present(postNavigationController, animated: true, completion: nil)
    }

    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
    }

    private func setUp() {
        view.addSubview(member1Button)
        view.addSubview(member1Label)
        view.addSubview(member2Button)
        view.addSubview(member2Label)
        view.addSubview(member3Button)
        view.addSubview(member3Label)
        view.addSubview(memberCollectionView)
        
        // progress1Viewをインスタンス化
        progress1View = UIProgressView()
        progress1View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progress1View)
        
        // progress2Viewをインスタンス化
        progress2View = UIProgressView()
        progress2View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progress2View)
        
        // progress2Viewをインスタンス化
        progress3View = UIProgressView()
        progress3View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progress3View)

        // メモリービューを開いたときに少し右側にスクロール
        let xOffset = CGFloat(20) // スクロールする横方向のオフセット
        memberCollectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)

        NSLayoutConstraint.activate([
            member1Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            member1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            member1Button.widthAnchor.constraint(equalToConstant: 100),
            member1Button.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            member1Label.topAnchor.constraint(equalTo: member1Button.bottomAnchor, constant: 10),
            member1Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            progress1View.topAnchor.constraint(equalTo: member1Label.bottomAnchor, constant: 10),
            progress1View.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            progress1View.widthAnchor.constraint(equalToConstant: 100),
            progress1View.heightAnchor.constraint(equalToConstant: 5)
        ])

        NSLayoutConstraint.activate([
            member2Button.topAnchor.constraint(equalTo: progress1View.bottomAnchor, constant: 30),
            member2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            member2Button.widthAnchor.constraint(equalToConstant: 80),
            member2Button.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            member2Label.topAnchor.constraint(equalTo: member2Button.bottomAnchor, constant: 10),
            member2Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90)
        ])

        NSLayoutConstraint.activate([
            progress2View.topAnchor.constraint(equalTo: member2Label.bottomAnchor, constant: 10),
            progress2View.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            progress2View.widthAnchor.constraint(equalToConstant: 80),
            progress2View.heightAnchor.constraint(equalToConstant: 5)
        ])

        NSLayoutConstraint.activate([
            member3Button.topAnchor.constraint(equalTo: progress1View.bottomAnchor, constant: 30),
            member3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            member3Button.widthAnchor.constraint(equalToConstant: 80),
            member3Button.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            member3Label.topAnchor.constraint(equalTo: member3Button.bottomAnchor, constant: 10),
            member3Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90)
        ])

        NSLayoutConstraint.activate([
            progress3View.topAnchor.constraint(equalTo: member3Label.bottomAnchor, constant: 10),
            progress3View.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            progress3View.widthAnchor.constraint(equalToConstant: 80),
            progress3View.heightAnchor.constraint(equalToConstant: 5)
        ])

        NSLayoutConstraint.activate([
            memberCollectionView.topAnchor.constraint(equalTo: progress3View.bottomAnchor, constant: 30),
            memberCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memberCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            memberCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])

        if let tabBarSuperview = tabBarController?.view {
            tabBarSuperview.addSubview(plusButton)
            // 中央に配置する制約を設定
            NSLayoutConstraint.activate([
                plusButton.centerXAnchor.constraint(equalTo: tabBarSuperview.centerXAnchor),
                plusButton.bottomAnchor.constraint(equalTo: tabBarSuperview.bottomAnchor, constant: -30), // タブバーの少し上に配置
                plusButton.widthAnchor.constraint(equalToConstant: 60),
                plusButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }

        // 貢献度
        progress1View.progress = 0.9
        progress2View.progress = 0.3
        progress3View.progress = 0.2

        memberCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = images[indexPath.item]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30 // 半径の半分を指定して円形にクリッピング
        imageView.layer.masksToBounds = true // クリッピングを有効にする
        // 白い縁の設定
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.addSubview(imageView)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 60 // セルの幅を計算
        let cellHeight = 60 // セルの高さ
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memberProfileViewController = MemberProfileViewController() // ここでは適切な初期化方法に変更してください
        navigationController?.pushViewController(memberProfileViewController, animated: true)
    }
}
