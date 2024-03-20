import { pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import TitleBar from '../../widget/TitleBar'
import Food from '../food/Food'
import openOrderDetail from './OrderDetailPage'

@Entry
@Component
export default struct MyOrderPage {
  build() {
    Column() {
      TitleBar({ title: "我的订单" })
      List({ space: 15 }) {
        ListItem() {
          OrderCell()
        }
        .margin({ top: 20 })

        ListItem() {
          OrderCell()
        }

        ListItem() {
          OrderCell()
        }
      }
      .padding({ left: PagePadding, right: PagePadding })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}

class Order {
  readonly food: Food
  money: number
  date: string
}

@Component
struct OrderCell {
  private order: Order = {
    food: { name: "香辣炒虾尾", image: "app.media.food1", price: 68 },
    money: 11,
    date: '2024-03-15 20:02'
  }

  build() {

    Column() {
      Row() {
        Text(`下单时间: ${(this.order.date)}`)
          .fontSize(12)
        Blank()
        Text("配送中")
          .fontSize(14)
      }
      .width('100%')

      Row() {
        Image($r("app.media.food1"))
          .width(120)
          .height(80)
          .borderRadius(6)
        this.textArea()
      }
      .width('100%')
      .height(100)

    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    .backgroundColor('#fff')
    .borderRadius(6)
    .onClick(() => openOrderDetail("a"))

  }

  @Builder
  textArea() {
    Column() {
      Text(this.order.food.name)
        .textAlign(TextAlign.Start) //zu
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
      Text(`数量: 1`)
        .fontSize(12)
      Text(`共计: ￥${(this.order.money)}`)
        .fontSize(12)

      // .width(1)
      // .width('100%')
    }
    .height(80)
    .margin({ left: 10 })
    .alignItems(HorizontalAlign.Start)
    .alignRules({ right: { anchor: 'parent', align: HorizontalAlign.End } })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}