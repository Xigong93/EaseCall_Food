import { auxiliary, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import HorizontalLine from '../../widget/HorizontalLine'

@Preview
@Component
export default struct MineTab {
  build() {
    Column() {
      this.header()
      Row().height(30)
      this.list()
      Button("退出登录")
        .width(120)
        .margin({ top: 60 })
        .backgroundColor(auxiliary)
    }
    .width('100%')
    .height('100%')
    .padding({ left: PagePadding, right: PagePadding })
    .backgroundColor(pageBackground)

  }

  @Builder
  header() {
    Row() {
      Image($r('app.media.mine_header'))
        .width(60)
        .height(60)
        .borderRadius(30)
      Column() {
        Text("姓名")
          .fontColor(Color.Black)
        Text("ID:001")
      }
      .margin({ left: 16 })
    }
    .width("100%")
    .margin({ left: 20, top: 20, right: 20 })
  }

  @Builder
  list() {
    Column() {
      item("", "我的订单")
      this.listDivider()
      item("", "清除缓存")
      this.listDivider()
      item("", "软件版本")
      this.listDivider()
      item("", "关于我们")
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
function item(icon: string, title: string) {
  Row() {
    Image($r('app.media.home_mine_order'))
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
}