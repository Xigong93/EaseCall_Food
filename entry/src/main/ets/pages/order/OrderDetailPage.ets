import router from '@ohos.router'
import { pageBackground } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import TitleBar from '../../widget/TitleBar'

function openOrderDetail(id: string) {
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
          OrderDetailPage()
        }
        .width('100%')

      }
      .width('100%')
      .padding({ left: PagePadding, right: PagePadding })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}