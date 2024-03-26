import router from '@ohos.router'
import { RouterOptions } from '@system.router'
import { grayFontColor, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import { VerticalSpace } from '../../widget/Space'
import TitleBar from '../../widget/TitleBar'
import Food from '../food/Food'
import { createFood } from '../food/FoodApi'
import OrderContentCard from './OrderContentCard'
import {
  getOrderStateInfo,
  OrderStateDelivering,
  OrderStateFinished,
  OrderStateInfo,
  OrderStatePreparing
} from './OrderState'
import { Order } from './OrderViewModel'

export default function openOrderDetailPage(order: Order): void {
  router.pushUrl({
    url: "pages/order/OrderDetailPage",
    params: {
      order: order
    }
  })
}

export function replaceToOrderDetailPage(order: Order): void {
  router.replaceUrl({
    url: "pages/order/OrderDetailPage",
    params: {
      order: order
    }
  })
}

@Entry
@Component
struct OrderDetailPage {
  @State
  private order: Order = new Order()
  /**
   * 订单状态
   */
  @State
  private orderStateInfo: OrderStateInfo = { state: OrderStatePreparing, leftMillis: 0 }
  private updateOrderTask: number

  aboutToAppear() {
    this.order = router.getParams()["order"]
    // 定时器更新订单状态
    this.stopUpdateOrderTask()
    this.updateOrderTask = setInterval(() => {
      this.updateOrderState()
    }, 1 * 1000)
    this.updateOrderState()
  }

  private updateOrderState() {
    this.orderStateInfo = getOrderStateInfo(this.order)
  }

  private stopUpdateOrderTask() {
    if (this.updateOrderTask >= 0) {
      clearInterval(this.updateOrderTask)
      this.updateOrderTask = -1
    }
  }

  aboutToDisappear() {
    this.stopUpdateOrderTask()
  }

  build() {
    Column() {
      TitleBar({ title: "订单详情" })
      Scroll() {
        Column({ space: 14 }) {
          Divider().height(0)
          this.orderStateDesc()

          StageBar({ orderState: this.orderStateInfo.state })

          OrderContentCard({ food: createFood(this.order.food) })
          OrderInfoCard({ order: this.order })
          VerticalSpace()
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: PagePadding, right: PagePadding })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }

  @Builder
  orderStateDesc() {
    if (this.orderStateInfo.state == OrderStateFinished) {
      Text(`订单已完成`)
        .fontColor(Color.Black)
        .fontSize(14)
    } else {
      Text(`商品${this.getOrderState()},预计还需要 ${formatMilliseconds(this.orderStateInfo.leftMillis)}`)
        .fontColor(Color.Black)
        .fontSize(14)
    }
  }

  getOrderState(): string {
    const state = this.orderStateInfo.state
    if (state == OrderStatePreparing) {
      return "制作中"
    } else if (state == OrderStateDelivering) {
      return "配送中"
    } else {
      return "已完成"
    }
  }
}

@Component
struct OrderInfoCard {
  private order: Order

  build() {
    Column({ space: 14 }) {
      this.itemInfo("期望时间", "立即配送")
      this.itemInfo("配送地址", "天津市河西区平江道62号\n小明 18588886666")
      this.itemInfo("配送服务", "商家自配")
      Divider()
      this.itemInfo("订单号码", this.order.orderNo)
      this.itemInfo("下单时间", this.order.orderDate)
      this.itemInfo("支付方式", "在线支付")
      this.itemInfo("餐具数量", "1套")

    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(PagePadding)
    .backgroundColor('#fff')
    .borderRadius(6)
  }

  @Builder
  itemInfo(label: string, content: string) {
    Row() {
      Text(label)
        .fontColor(grayFontColor)
        .fontSize(14)
      Blank()
      Text(content)
        .fontColor(Color.Black)
        .fontSize(14)
        .textAlign(TextAlign.End)
    }
    .width('100%')

  }
}


@Preview
@Component
struct StageBar {
  @Prop
  private orderState: number
  private readonly stages = ["已下单", "制作中", '配送中', '已完成']

  build() {
    Column({ space: 8 }) {
      Row() {
        ForEach(this.stages, (label: string, index: number) => {
          if (index == this.orderState) {
            this.activeStateText(label)
          } else {
            this.stateText(label)
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row({ space: 6 }) {
        ForEach(this.stages, (label: string, index: number) => {
          if (index > 0) {
            if (this.orderState >= index) {
              this.activeStateLine()
            } else {
              this.stateLine()
            }
          }
          if (this.orderState == index) {
            this.activeStatePoint()
          } else {
            this.statePoint()
          }
        })
      }
      .width('100%')
    }
    .padding(PagePadding)
    .backgroundColor(Color.White)
    .width('100%')
    .borderRadius(8)
  }

  @Builder
  stateText(text: string) {
    Text(text)
      .fontColor(Color.Black)
      .fontSize(13)
  }

  @Builder
  activeStateText(text: string) {
    Text(text)
      .fontColor(primary)
      .fontSize(13)
  }

  @Builder
  statePoint() {
    Button()
      .width(8)
      .height(8)
      .backgroundColor(primary)
      .type(ButtonType.Circle)
  }

  @Builder
  activeStatePoint() {
    Image($r('app.media.radio_button_checked'))
      .width(16)
      .height(16)

  }

  @Builder
  stateLine() {
    Divider()
      .layoutWeight(1)
      .backgroundColor(grayFontColor)

  }

  @Builder
  activeStateLine() {
    Divider()
      .layoutWeight(1)
      .backgroundColor(primary)

  }
}

function formatMilliseconds(milliseconds) {
  const seconds = Math.floor(milliseconds / 1000);
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  if (minutes > 0) {
    return `${minutes}分${remainingSeconds}秒`;
  } else {
    return `${remainingSeconds}秒`;
  }
}
