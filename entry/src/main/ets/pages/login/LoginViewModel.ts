import { User, userManager } from '../../user/UserManager'

export default  class LoginViewModel {
  async login(account: string, password: string): Promise<string | true> {
    if (account == "admin" && password == "123456") {
      let user: User = { id: "0", name: "admin", token: "admin_token" }
      await userManager.login(user)
      return true;
    }
    return "账号或密码不正确"
  }
}