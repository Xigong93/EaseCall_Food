import httpRequest, { HttpResult, resultSuccess } from '../../net/HttpRequest'
import { User, userManager } from '../../user/UserManager'

export default class LoginViewModel {
  async login(account: string, password: string): Promise<string | true> {
    const form = {
      username: account,
      password: password
    }
    const result: HttpResult<void> = await httpRequest.post(`web/app/loginApp.do`, form)
    if (!result) {
      return "网络错误,请重试"
    } else if (resultSuccess(result)) {
      this.saveUser(account)
      return true
    } else {
      return "账号或密码不正确"
    }
  }

  async saveUser(account: string) {
    const user: User = {
      name: account, id: "01", token: "unknown"
    }
    userManager.login(user)
  }
}