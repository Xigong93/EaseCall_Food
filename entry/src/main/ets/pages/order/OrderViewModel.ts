import httpRequest, { HttpResult, resultSuccess } from '../../net/HttpRequest'
import Food from '../food/Food'

export default class OrderViewModel {
  /**
   * 获取订单列表
   * @returns
   */
  async getOrderList(): Promise<Array<Order>> {
    const result: HttpResult<Array<Order>> = await httpRequest.post("web/app/getOrderList.do")
    const orders = result.data ?? []
    return orders
  }

  /**
   * 下订单
   * @param food
   * @returns
   */
  async order(foodId: string, money: number): Promise<boolean> {
    const form = {
      id: foodId,
      totalAmount: money
    }
    const result: HttpResult<void> = await httpRequest.post("web/app/upOrder.do", form)
    return result && resultSuccess(result)
  }
}

export class Order {
  /**
   * 订单号
   */
  readonly orderNo: string

  /**
   * 状态
   */
  readonly status: string
  /**
   * 总金额
   */
  readonly totalAmount: number
  /**
   * 订单时间
   */
  readonly orderDate: string
  /**
   * 商品
   */
  readonly food: Staff
}

class Staff {
  readonly foodId: number
  readonly foodName: string
  // 类型
  readonly foodType: string
  // 图片
  readonly photoPath: string
  // 价格
  readonly price: number
}