import router from '@ohos.router'
import { userManager } from '../../user/UserManager'
import { delay } from '../../utils/PromiseUtil'
import Logger from '../../utils/Logger'

@Entry
@Component
struct WelcomePage {
  async aboutToAppear() {
    await delay(1000)
    let isLogin = await userManager.isLogin()
    // const isLogin = true
    new Logger("欢迎页").info(`首页启动，是否已登录:${isLogin}`)
    let page = isLogin ? 'pages/home/HomePage' : 'pages/login/LoginPage'
    router.replaceUrl({ url: page })
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width(400)
        .position({ x: 80 })

      Image($r("app.media.slogo"))
        .width(220)
        .position({ x: 6, y: 560 })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.welcome_bg"))
    .backgroundImageSize(1) //背景图铺满整个页面
  }
}

