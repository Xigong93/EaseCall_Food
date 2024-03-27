import { primary } from '../../style/AppColor'
import showToast from '../../utils/ToastUtil'
import openOrderDetailPage from '../order/OrderDetailPage'
import { formatMilliseconds, OrderStateDelivering, OrderStateInfo, OrderStatePreparing } from '../order/OrderState'
import deliveryStateBarController from './DeliveryStateBarController'

@Component
export default struct DeliveryStateBar {
  @State
  private orderState: OrderStateInfo | null = null

  aboutToAppear() {
    deliveryStateBarController.start()
    deliveryStateBarController.orderStateListener = (state: OrderStateInfo | null) => {
      this.orderState = state
    }
  }

  aboutToDisappear() {
    deliveryStateBarController.stop()
    deliveryStateBarController.orderStateListener = null
  }

  build() {
    if (this.orderState) {
      if (this.orderState.state == OrderStatePreparing) {
        this.prepareState()
      } else if (this.orderState.state == OrderStateDelivering) {
        this.deliveringState()
      }
    }
    // DeliverState()
  }

  @Builder
  prepareState() {
    DeliverState({
      image: $r('app.media.chushi'),
      title: '厨师制作中',
      timeLeft: formatMilliseconds(this.orderState.leftMillis)
    })
      .onClick(() => {
        openOrderDetailPage(this.orderState.order)
      })
  }

  @Builder
  deliveringState() {
    DeliverState({
      image: $r('app.media.waimaiyuan'),
      title: '骑手配送中',
      timeLeft: formatMilliseconds(this.orderState.leftMillis)
    })
      .onClick(() => {
        openOrderDetailPage(this.orderState.order)
      })
  }
}

@Preview
@Component
struct DeliverState {
  private image: Resource = $r('app.media.waimaiyuan')
  private title: string = "骑手配送中"
  @Prop
  private timeLeft: string

  build() {
    Row({ space: 6 }) {
      Image(this.image)
        .width(36)
        .height(36)
        .backgroundColor(Color.White)
        .borderRadius(18)
      Column({ space: 2 }) {
        Text(this.title)
          .fontColor(Color.Black)
          .fontSize(12)
        Row() {
          Text(`预计还需: `)
            .fontColor(Color.Black)
            .fontSize(10)
          Text(this.timeLeft)
            .fontColor(Color.Red)
            .fontSize(10)
        }
      }
      .alignItems(HorizontalAlign.Start)

    }
    .height(40)
    .padding({ left: 2, right: 14 })
    .backgroundColor(primary)
    .borderRadius(25)
  }
}