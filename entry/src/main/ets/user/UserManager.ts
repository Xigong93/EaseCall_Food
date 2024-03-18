import dataPreferences from '@ohos.data.preferences';
import { getUiAbility } from '../utils/UiAbilityHolder'
import Logger from '../utils/Logger'

const USER_KEY = "user"

class UserDao {
  private async getPreference(): Promise<dataPreferences.Preferences> {
    let context = getUiAbility().context
    return await dataPreferences.getPreferences(context, USER_KEY)
  }

  async save(user: User) {
    const pref = await this.getPreference()
    await pref.put(USER_KEY, JSON.stringify(user))
    await pref.flush()
  }

  async getUser(): Promise<User | null> {
    const pref = await this.getPreference()
    const userStr = await pref.get(USER_KEY, "") as string
    if (!userStr) {
      return null
    }
    try {
      return JSON.parse(userStr) as User
    } catch (e: any) {
      console.log(e)
      this.clear()
      return null
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
export class User {
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


