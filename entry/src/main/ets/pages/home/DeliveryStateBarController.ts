import Logger from '../../utils/Logger'
import { getOrderStateInfo, OrderStateFinished, OrderStateInfo } from '../order/OrderState'
import OrderViewModel, { Order } from '../order/OrderViewModel'

const logger = new Logger("配送状态条控制器")

class DeliveryStateBarController {
  private updateOrderTask: number = 0


  private unFinishedOrders: Array<Order> = []

  /**
   * 回调监听
   */
  orderStateListener?: (state: OrderStateInfo | null) => void


  start() {
    this.getAllOrder()
    // 定时器更新订单状态
    this.stopUpdateOrderTask()
    this.updateOrderTask = setInterval(() => {
      this.updateOrderState()
    }, 1 * 1000)
    this.updateOrderState()
  }

  stop() {
    this.stopUpdateOrderTask()
  }

  private updateOrderState() {
    const focusOrder = this.getFocusOrder()
    if (!this.orderStateListener) {
      return
    }

    if (focusOrder) {
      const orderState = getOrderStateInfo(focusOrder)
      this.orderStateListener(orderState)
    } else {
      this.orderStateListener(null)
    }
  }

  private async getAllOrder() {
    const orderVM = new OrderViewModel()
    const allOrder = await orderVM.getOrderList()
    this.unFinishedOrders = allOrder.filter((o) => getOrderStateInfo(o).state != OrderStateFinished)
    logger.info(`未完成的订单数量:${this.unFinishedOrders.length}`)
  }

  private getFocusOrder(): Order | null {
    if (this.unFinishedOrders.length > 0) {
      return this.unFinishedOrders[0]
    } else {
      return null
    }
  }

  private stopUpdateOrderTask() {
    if (this.updateOrderTask >= 0) {
      clearInterval(this.updateOrderTask)
      this.updateOrderTask = -1
    }
  }
}

const deliveryStateBarController = new DeliveryStateBarController()

export default deliveryStateBarController