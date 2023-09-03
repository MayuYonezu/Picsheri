class UserModel {
    static let shared = UserModel()
    var email: String?
    var name: String?
    var uid: String?
    private init() {}
}
