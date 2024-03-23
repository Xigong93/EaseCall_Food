import { pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import PageStateView, { ContentPage, EmptyPage, LoadingPage } from '../../widget/PageState'
import TitleBar from '../../widget/TitleBar'
import openOrderDetail from './OrderDetailPage'
import OrderViewModel, { Order } from './OrderViewModel'

@Entry
@Component
export default struct MyOrderPage {
  @State
  private orders: Array<Order> = []
  @State
  private pageState: number = LoadingPage
  private viewModel = new OrderViewModel()

  async aboutToAppear() {
    this.pageState = LoadingPage
    this.orders = await this.viewModel.getOrderList()
    if (this.orders.length > 0) {
      this.pageState = ContentPage
    } else {
      this.pageState = EmptyPage
    }
  }

  build() {
    Column() {
      TitleBar({ title: "我的订单" })
      PageStateView({ pageState: this.pageState }) {
        List() {
          ForEach(this.orders, (order) => {
            ListItem() {
              OrderCell({ order })
            }
            .margin({ top: 15 })
          })
        }
        .padding({ left: PagePadding, right: PagePadding })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}


@Component
struct OrderCell {
  private order: Order

  build() {

    Column() {
      Row() {
        Text(`下单时间:${this.order.orderDate} `)
          .fontSize(12)
        Blank()
        Text(this.order.status)
          .fontSize(14)
      }
      .width('100%')

      Row() {
        Image(this.order.food.photoPath)
          .width(120)
          .height(80)
          .backgroundColor(pageBackground)
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
      Text(this.order.food.foodName)
        .textAlign(TextAlign.Start) //zu
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
      Text(`数量: 1`)
        .fontSize(12)
      Text(`共计: ￥${(this.order.totalAmount)}`)
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