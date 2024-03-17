import dataPreferences from '@ohos.data.preferences';
import { getUiAbility } from '../utils/UiAbilityHolder'
import Logger from '../utils/Logger'

class UserDao {
  private async getPreference(): Promise<dataPreferences.Preferences> {
    let context = getUiAbility().context
    return await dataPreferences.getPreferences(context, "user")
  }

  async save(user: User) {
    const pref = await this.getPreference()
    await pref.put("uid", user.id)
    await pref.put("name", user.name)
    await pref.put("token", user.token)
    await pref.flush()
  }

  async getUser(): Promise<User | null> {
    const pref = await this.getPreference()
    const id = await pref.get("uid", "")
    const name = await pref.get("name", "")
    const token = await pref.get("token", "")

    if (!id || !name || !token) {
      return null
    }
    return {
      id: id as string,
      name: name as string,
      token: token as string
    }
  }

  async clear() {
    const pref = await this.getPreference()
    await pref.clear()
    await pref.flush()
  }
}

/**
 * 用户管理器
 */
class UserManager {
  private userDao = new UserDao()

  private logger = new Logger("用户管理器")


  /**
   * 是否已登录
   * @returns
   */
  async isLogin(): Promise<boolean> {
    return await this.getUser() != null
  }

  async getUser(): Promise<User | null> {
    return await this.userDao.getUser()
  }
  /**
   * 登录
   * @param user
   */
  async login(user: User) {
    this.logger.info(`登录:${JSON.stringify(user)}`)
    await this.userDao.save(user)
  }

  /**
   * 退出登录
   */
  async logout() {
    this.logger.info(`退出登录`)
    await this.userDao.clear()
  }
}

export const userManager = new UserManager()

/**
 * 用户
 */
export interface User {
  /**
   * 用户id
   */
  readonly id: string
  /**
   * 昵称
   */
  readonly name: string

  /**
   * 和服务器交互的token
   */
  readonly token: string
}


