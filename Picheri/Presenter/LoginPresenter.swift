protocol LoginView: AnyObject {
    func onLoginSuccess()
    func onLoginFailure()
}

class LoginPresenter {
    weak var view: LoginView?

    init(view: LoginView) {
        self.view = view
    }

    func loginButtonPressed(email: String, password: String) {
        print("presenterに届いたよ: email = \(email), password = \(password)")
//         ログイン成功の場合
         view?.onLoginSuccess()
//         ログイン失敗の場合
         view?.onLoginFailure()
    }
    
    func signupButtonPressed(email: String, name: String, password: String) {
        print("presenterに届いたよ: email = \(email), password = \(password)")
        // ログイン成功の場合
        view?.onLoginSuccess()
        // ログイン失敗の場合
        view?.onLoginFailure()
    }

}
