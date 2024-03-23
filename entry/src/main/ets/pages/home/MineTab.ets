import router from '@ohos.router'
import { auxiliary, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import { User, userManager } from '../../user/UserManager'
import showToast from '../../utils/ToastUtil'
import HorizontalLine from '../../widget/HorizontalLine'

@Preview
@Component
export default struct MineTab {
  @State
  private user: User = { id: "0", name: "未登录", token: "" }

  async aboutToAppear() {
    this.user = await userManager.getUser()
  }

  build() {
    Column() {
      this.header()
      Row().height(30)
      this.list()
      Button("退出登录")
        .width(120)
        .margin({ top: 60 })
        .backgroundColor(auxiliary)
        .onClick(() => this.logout())
    }
    .width('100%')
    .height('100%')
    .padding({ left: PagePadding, right: PagePadding })
    .backgroundColor(pageBackground)

  }

  /**
   * 退出登录
   */
  async logout() {
    await userManager.logout()
    router.replaceUrl({ url: 'pages/login/LoginPage' })
  }

  @Builder
  header() {
    Row() {

      Image($r('app.media.mine_header'))
        .width(60)
        .height(60)
        .borderRadius(30)


      Column({ space: 10 }) {
        Text(this.user ? this.user.name : "未登录")
          .fontSize(16)
          .fontColor(Color.Black)
        Text(`ID:${this.user ? this.user.id : "0"}`)
          .fontColor('#7a7a7a')
          .fontSize(14)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
    }
    .width("100%")
    .margin({ left: 20, top: 20, right: 20 })
  }

  @Builder
  list() {
    Column() {
      item($r("app.media.home_mine_order"), "我的订单", () => {
        router.pushUrl({ url: 'pages/order/MyOrderPage' })

      })
      this.listDivider()
      item($r("app.media.home_mine_clear"), "清除缓存", () => {
        showToast("清除成功")
      })
      this.listDivider()
      appUpdate()
      this.listDivider()
      item($r('app.media.home_mine_about'), "关于我们", () => {
        showToast("简吃是一个大学生外卖平台，提供更实惠，更高品质的用餐体验")
      })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .border({ radius: 12 })
  }

  @Builder
  listDivider() {
    HorizontalLine()
      .margin({ left: 12, right: 12 })
  }
}


@Builder
function appUpdate() {
  Row() {
    Image($r("app.media.home_mine_app_update"))
      .width(22)
      .width(22)
    Text("软件更新")
      .fontSize(12)
      .margin({ left: 10 })
    Blank()
    Text("v1.0.0")
      .fontSize(12)
      .fontColor('#7a7a7a')
    Image($r('app.media.home_mine_arrow'))
      .width(22)
      .width(22)
  }
  .padding({ left: PagePadding, right: PagePadding })
  .width('100%')
  .height(50)
  .onClick(() => showToast("已是最新版本"))
}

@Builder
function item(icon: Resource, title: string, onClick: () => void) {
  Row() {
    Image(icon)
      .width(22)
      .width(22)
    Text(title)
      .fontSize(12)
      .margin({ left: 10 })
    Blank()
    Image($r('app.media.home_mine_arrow'))
      .width(22)
      .width(22)
  }
  .padding({ left: PagePadding, right: PagePadding })
  .width('100%')
  .height(50)
  .onClick(onClick)
}