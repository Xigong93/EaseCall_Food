import router from '@ohos.router'

import { divider } from '../style/AppColor'

const TitleBarHeight = 55

/**
 * 标题栏
 */
@Preview
@Component
export default struct TitleBar {
  /**
   * 标题
   */
  private title?: ResourceStr
  /**
   * 显示分割线
   */
  private showDivider = true

  build() {
    Column() {
      Stack() {
        BackButton()
          .position({ x: 0, y: 0 })

        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .height(TitleBarHeight)
      .backgroundColor(Color.White)
      .alignContent(Alignment.Center)
      .width('100%')

      if (this.showDivider) {
        Divider()
          .color(divider)
          .width("100%")
          .height(0.5)
      }
    }.width("100%")
  }
}

@Preview
@Component
struct BackButton {
  build() {
    Stack() {
      Image($r('app.media.title_bar_back'))
        .height(28)
        .width(28)
    }
    .alignContent(Alignment.Center)
    .height(TitleBarHeight)
    .width(TitleBarHeight)
    .onClick(() => {
      router.back()
    })
  }
}