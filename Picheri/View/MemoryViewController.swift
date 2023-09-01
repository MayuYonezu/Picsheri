
import UIKit

class MemoryViewController: UIViewController {

    private var profileButton: UIBarButtonItem!

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

    private func setUpScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        view.addSubview(scrollView)
        // メモリービューを開いたときに少し右側にスクロール
        let xOffset = CGFloat(-20) // スクロールする横方向のオフセット
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)

        let numberOfViews = 10 // ここで表示するビューの数を設定
        let viewWidth = view.frame.width * 0.9
        let viewHeight = viewWidth * 4 / 3
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (CGFloat(numberOfViews) - 1)
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
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
            
            
            // Add content to whiteView
            // ...
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainYellow")
        setUp()
        setUpNavigation()
        setUpScrollView()

    }

    private func setUp() {
        if let tabBarSuperview = tabBarController?.view {
            tabBarSuperview.addSubview(plusButton)
            // 中央に配置する制約を設定
            NSLayoutConstraint.activate([
                plusButton.centerXAnchor.constraint(equalTo: tabBarSuperview.centerXAnchor),
                plusButton.bottomAnchor.constraint(equalTo: tabBarSuperview.bottomAnchor, constant: -50), // タブバーの少し上に配置
                plusButton.widthAnchor.constraint(equalToConstant: 60),
                plusButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
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
        
        title = "Memory"
        
        // タイトルのフォントを変更
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Shrikhand-Regular", size: 24) ?? .systemFont(ofSize: 24) // 任意のフォントとサイズに変更
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }

    // ボタンのアクション
    @objc func profileButtonTapped() {
        
    }

}
