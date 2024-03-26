import axios, { AxiosResponse } from '@ohos/axios';
import Logger from '../../utils/Logger';

const logger = new Logger("网络时间")


async function getNetworkTime(): Promise<Date> {
  const url = 'http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp'
  const result = await axios.get(url)
  const millis = result.data["data"]["t"]
  return new Date(Number.parseInt(millis));
}

var netTime = new Date()
var updateTime = new Date()


export async function syncTime() {
  try {
    const time = await getNetworkTime()
    netTime = time
    updateTime = new Date()
    logger.info(`同步网络时间成功:${netTime}`)
    logger.info(`当前时间:${getCurrentTime()}`)
  } catch (e) {
    logger.error(`同步网络时间失败:${JSON.stringify(e)}`)
  }

}

export function getCurrentTime(): Date {
  const diff = new Date().getTime() - updateTime.getTime()
  return new Date(netTime.getTime() + diff)
}
