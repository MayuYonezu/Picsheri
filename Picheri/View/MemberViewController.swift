import UIKit

final class MemberViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var profileButton: UIBarButtonItem!
    private var progress1View: UIProgressView!
    private var progress2View: UIProgressView!
    private var progress3View: UIProgressView!

    private let reuseIdentifier = "Cell"
    let images: [UIImage] = [UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!, UIImage(named: "Profile")!] // 表示する画像

    private let menber1Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        return button
    }()
    
    private let menber1Label: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let menber2Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        return button
    }()
    
    private let menber2Label: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let menber3Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        return button
    }()
    
    private let menber3Label: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "mainGray") ?? UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // スクロール方向を水平に設定
        layout.minimumInteritemSpacing = 20 // セル間の横方向の最小間隔
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100) // 画面幅に合わせたセルのサイズ
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // セクションインセットを0に設定

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
        collectionView.layer.shadowColor = UIColor(named: "mainGray")?.cgColor
        collectionView.layer.shadowOpacity = 0.2
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 2)
        collectionView.layer.shadowRadius = 5
        return collectionView
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
        // サインアップボタンを作成
        profileButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(profileButtonTapped))
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
        
        title = "Member"
        
        // タイトルのフォントを変更
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Shrikhand-Regular", size: 24) ?? .systemFont(ofSize: 24) // 任意のフォントとサイズに変更
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    // ボタンのアクション
    @objc func profileButtonTapped() {
        
    }
    
    private func setUp() {
        view.addSubview(menber1Button)
        view.addSubview(menber1Label)
        view.addSubview(menber2Button)
        view.addSubview(menber2Label)
        view.addSubview(menber3Button)
        view.addSubview(menber3Label)
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
        
        NSLayoutConstraint.activate([
            menber1Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            menber1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            menber1Button.widthAnchor.constraint(equalToConstant: 100),
            menber1Button.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            menber1Label.topAnchor.constraint(equalTo: menber1Button.bottomAnchor, constant: 10),
            menber1Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            progress1View.topAnchor.constraint(equalTo: menber1Label.bottomAnchor, constant: 10),
            progress1View.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            progress1View.widthAnchor.constraint(equalToConstant: 100),
            progress1View.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        NSLayoutConstraint.activate([
            menber2Button.topAnchor.constraint(equalTo: progress1View.bottomAnchor, constant: 30),
            menber2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            menber2Button.widthAnchor.constraint(equalToConstant: 80),
            menber2Button.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            menber2Label.topAnchor.constraint(equalTo: menber2Button.bottomAnchor, constant: 10),
            menber2Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90)
        ])
        
        NSLayoutConstraint.activate([
            progress2View.topAnchor.constraint(equalTo: menber2Label.bottomAnchor, constant: 10),
            progress2View.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            progress2View.widthAnchor.constraint(equalToConstant: 80),
            progress2View.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        NSLayoutConstraint.activate([
            menber3Button.topAnchor.constraint(equalTo: progress1View.bottomAnchor, constant: 30),
            menber3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            menber3Button.widthAnchor.constraint(equalToConstant: 80),
            menber3Button.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            menber3Label.topAnchor.constraint(equalTo: menber3Button.bottomAnchor, constant: 10),
            menber3Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90)
        ])
        
        NSLayoutConstraint.activate([
            progress3View.topAnchor.constraint(equalTo: menber3Label.bottomAnchor, constant: 10),
            progress3View.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            progress3View.widthAnchor.constraint(equalToConstant: 80),
            progress3View.heightAnchor.constraint(equalToConstant: 5)
        ])

        NSLayoutConstraint.activate([
            memberCollectionView.topAnchor.constraint(equalTo: progress3View.bottomAnchor, constant: 30),
            memberCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            memberCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            memberCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])

        progress1View.progress = 0.9 // 進捗を設定（0.0から1.0の間で指定）
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
        cell.contentView.addSubview(imageView)
        
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 60 // セルの幅を計算
        let cellHeight = 60 // セルの高さ
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
