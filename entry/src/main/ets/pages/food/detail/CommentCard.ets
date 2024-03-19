import { divider } from '../../../style/AppColor'
import { PagePadding } from '../../../style/AppDimission'

@Preview
@Component
export default struct CommentCard {
  build() {
    Column() {
      Row() {
        Text("外卖评价")
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .fontSize(18)
        Text("(好评率95%)")
          .fontSize(14)
          .margin({ left: 6 })
          .fontColor("#7a7a7a")
      }


      Column({ space: 12 }) {
        this.rowInfo($r("app.media.head_001"), "包装很严实，到手还热乎乎的，味道也不错，很满意的一顿饭。")
        Divider().backgroundColor(divider)
        this.rowInfo($r("app.media.head_002"), "好吃，推荐，分量足，实惠")
      }
      .margin({ top: 18 })
      .alignItems(HorizontalAlign.Start)

    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(PagePadding)
  }

  @Builder
  rowInfo(icon: Resource, text: string) {
    Row({ space: 12 }) {
      Image(icon)
        .width(46)
        .height(46)
        .borderRadius(23)
      Column({ space: 12 }) {
        Row() {
          Text(text)
            .layoutWeight(1)
            .fontSize(14)
            .fontColor(Color.Black)

          Text("2024.03.14")
            .fontColor('#7a7a7a')
            .margin({ left: 15 })
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Row({ space: 6 }) {
          Image($r('app.media.user_food_01'))
            .width(60)
            .height(60)
            .borderRadius(6)
          Image($r('app.media.user_food_02'))
            .width(60)
            .height(60)
            .borderRadius(6)
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}