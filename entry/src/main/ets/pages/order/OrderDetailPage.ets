import router from '@ohos.router'
import { grayFontColor, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import { VerticalSpace } from '../../widget/Space'
import TitleBar from '../../widget/TitleBar'
import OrderContentCard from './OrderContentCard'

export default function openOrderDetail(id: string) {
  router.pushUrl({
    url: "pages/order/OrderDetailPage",
    params: {
      orderId: id
    }
  })
}

@Entry
@Component
struct OrderDetailPage {
  build() {
    Column() {
      TitleBar({ title: "订单详情" })
      Scroll() {
        Column({ space: 14 }) {
          StageBar()
            .margin({ top: 20 })
          OrderContentCard()
          OrderInfoCard()
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
}

@Component
struct OrderInfoCard {
  build() {
    Column({ space: 14 }) {
      this.itemInfo("期望时间", "立即配送")
      this.itemInfo("配送地址", "天津市河西区平江道62号\n小明 18588886666")
      this.itemInfo("配送服务", "商家自配")
      Divider()
      this.itemInfo("订单号码", "3009 9345 4122 1882 25")
      this.itemInfo("下单时间", "2024-03-20 21:39:58")
      this.itemInfo("支付方式", "微信支付")
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

enum OrderState {
  Ordered, Preparing, Delivering, Finished
}

@Component
struct StageBar {
  private orderState: OrderState = OrderState.Finished

  build() {
    Column({ space: 8 }) {
      Row() {
        this.stateText("已下单", Color.Black)
        this.stateText("制作中", Color.Black)
        this.stateText("配送中", Color.Black)
        this.stateText("已完成", primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row({ space: 6 }) {
        this.statePoint()
        this.stateLine()
        this.statePoint()
        this.stateLine()
        this.statePoint()
        this.stateLine()
        this.lastStatePoint()
      }
      .width('100%')
    }
    .padding(PagePadding)
    .backgroundColor(Color.White)
    .width('100%')
    .borderRadius(8)
  }

  @Builder
  stateText(text: string, color: ResourceColor) {
    Text(text)
      .fontColor(color)
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
  lastStatePoint() {
    Image($r('app.media.radio_button_checked'))
      .width(16)
      .height(16)

  }

  @Builder
  stateLine() {
    Divider()
      .layoutWeight(1)
      .backgroundColor(primary)

  }
}