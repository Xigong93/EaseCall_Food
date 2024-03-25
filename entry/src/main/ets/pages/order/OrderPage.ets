import router from '@ohos.router'
import appApi from '../../api/AppApi'
import { divider, grayFontColor, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import { delay } from '../../utils/PromiseUtil'
import showToast from '../../utils/ToastUtil'
import Loading from '../../widget/Loading'
import TitleBar from '../../widget/TitleBar'
import { openFoodDetailPage } from '../food/detail/FoodDetailPage'
import Food from '../food/Food'
import { replaceMyOrderPage } from './MyOrderPage'
import OrderContentCard from './OrderContentCard'
import openOrderDetail, { replaceToOrderDetailPage } from './OrderDetailPage'
import OrderViewModel from './OrderViewModel'

export default function openOrderPage(food: Food) {
  router.pushUrl(
    {
      url: "pages/order/OrderPage",
      params: {
        food
      }
    }
  )
}

@Entry
@Component
struct OrderPage {
  @State
  private loading: boolean = false
  @State
  private food: Food = appApi.getSampleFood()
  private viewModel = new OrderViewModel()

  aboutToAppear() {
    this.food = router.getParams()["food"]
  }

  build() {
    Column() {
      TitleBar({ title: "订单" })
      Stack() {
        Scroll() {
          Column({ space: 14 }) {
            AddressCard().margin({ top: 14 })
            OrderContentCard({ food: this.food })
            PaymentCard()
            this.payButton()
          }
          .width('100%')

        }
        .width('100%')
        .height('100%')
        .padding({ left: PagePadding, right: PagePadding })

        if (this.loading) {
          Loading({ msg: "支付中" })
        }
      }
      .width('100%')
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }

  @Builder
  payButton() {
    Button("立即支付")
      .width('100%')
      .margin({ bottom: 40 })
      .type(ButtonType.Normal)
      .backgroundColor(primary)
      .borderRadius(8)
      .onClick(() => this.performOrder())
  }

  async performOrder() {
    this.loading = true
    try {
      await delay(1000)
      const success = await this.viewModel.order(this.food.id, this.food.price)
      if (success) {
        showToast("支付成功")
        delay(200)
        router.back()
        replaceMyOrderPage()
      } else {
        showToast("网络错误请重试")
      }

    } finally {
      this.loading = false
    }
  }
}

@Builder
function cardTitle(label: string) {
  Text(label)
    .fontColor(Color.Black)
    .fontSize(16)
    .fontWeight(FontWeight.Medium)
}

@Preview
@Component
struct AddressCard {
  build() {
    Column({ space: 10 }) {
      cardTitle("收货地址")
      this.item("联系方式", "小明  18588886666")
      Divider().backgroundColor(divider)
      this.item("收货地址", "天津市河西区平江道62号")
    }
    .padding(PagePadding)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
  }

  @Builder
  item(label: string, content: string) {
    Row() {

      Text(label)
        .fontColor(grayFontColor)
        .fontSize(12)
      TextInput({ text: content })
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Color.Transparent)
        .fontSize(14)
    }
    .width('100%')

  }
}


@Component
struct PaymentCard {
  @State
  private selectedPayment: string = "wechat"

  build() {
    Column({ space: 14 }) {
      cardTitle("支付方式")
      this.payOption($r('app.media.order_wechat'), "微信", 'wechat')
      Divider()
        .margin({ left: 30 })
      this.payOption($r('app.media.order_alipay'), "支付宝", 'alipay')

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(PagePadding)
    .backgroundColor('#fff')
    .borderRadius(6)
  }

  @Builder
  payOption(icon: Resource, subject: string, name: string) {
    Row() {
      Image(icon)
        .width(22)
        .height(22)
      Text(subject)
        .fontColor(Color.Black)
        .fontSize(14)
        .margin({ left: 8 })
      Blank()
      Image(this.selectedPayment == name ? $r('app.media.radio_button_checked') : $r('app.media.radio_button_normal'))
        .width(22)
        .width(22)
    }
    .width('100%')
    .onClick(() => this.selectedPayment = name)

  }
}

