import axios, { AxiosResponse } from '@ohos/axios';
import { getCurrentTime } from './OnlineTime';
import { Order } from './OrderViewModel';

/**
 * 已下单
 */
export const OrderStateOrdered = 0

/**
 * 准备中
 */
export const OrderStatePreparing = 1

/**
 * 派送中
 */
export const OrderStateDelivering = 2

/**
 * 已完成
 */
export const OrderStateFinished = 3

export interface OrderStateInfo {
  /**
   * 订单状态
   */
  readonly state: number
  /**
   * 预计到下一个状态的剩余时间,单位毫米
   */
  readonly leftMillis: number
  readonly order: Order
}

/**
 * 获取订单状态，通过时间模拟的
 *  1. 下单时间5分钟内，商家准备中
 *  2. 下单时间5到10分钟内，派送中
 *  3. 超过10分钟，已送达
 * @returns
 */
export function getOrderStateInfo(order: Order): OrderStateInfo {
  const orderTime = new Date(order.orderDate)
  const currentTime = getCurrentTime()
  const minutesPerMillis = 60 * 1000
  const diff = currentTime.getTime() - orderTime.getTime()
  if (diff >= 10 * minutesPerMillis) {
    return {
      order,
      state: OrderStateFinished,
      leftMillis: 0
    }
  } else if (diff >= 5 * minutesPerMillis) {
    return {
      order,
      state: OrderStateDelivering,
      leftMillis: 10 * minutesPerMillis - diff
    }
  } else {
    return {
      order,
      state: OrderStatePreparing,
      leftMillis: 5 * minutesPerMillis - diff
    }
  }
}


export function formatMilliseconds(milliseconds) {
  const seconds = Math.floor(milliseconds / 1000);
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  if (minutes > 0) {
    return `${minutes}分${remainingSeconds}秒`;
  } else {
    return `${remainingSeconds}秒`;
  }
}
