import axios, { Axios, AxiosResponse } from '@ohos/axios'
import Logger from '../utils/Logger';
import { delay } from '../utils/PromiseUtil';

const logger = new Logger("HttpRequest")

/**
 * 需要替换成自己电脑在区域网中的ip
 */
const BASE_URL = "http://192.168.3.5:8000/"

class HttpRequest {
  private readonly client: Axios

  constructor(baseUrl: string = BASE_URL) {
    this.client = axios.create({ baseURL: baseUrl, });
  }

  async get<T>(url: string): Promise<T | null> {
    logger.info(`开始请求:${url}`)
    // 模拟网络耗时
    await delay(500)
    try {
      const result = await this.client.get<T, AxiosResponse<T>, null>(url)
      const data = result.data
      logger.info(`返回结果:${JSON.stringify(data)}`)
      return data
    } catch (e: any) {
      logger.error(`请求出错,${JSON.stringify(e)}`)
      return null
    }
  }

  async post<T>(url: string, body?: any): Promise<T | null> {
    logger.info(`开始请求:${url},body:${JSON.stringify(body)}`)
    // 模拟网络耗时
    await delay(500)
    try {
      const config = {
        headers: { "Content-Type": 'application/x-www-form-urlencoded' }
      }
      const result = await this.client.post<T, AxiosResponse<T>, null>(url, body, config)
      const data = result.data
      logger.info(`返回结果:${JSON.stringify(data)}`)
      return data
    } catch (e: any) {
      logger.error(`请求出错,${JSON.stringify(e)}`)
      return null
    }
  }
}

const httpRequest = new HttpRequest()

export default httpRequest


export class HttpResult {
  readonly code: number
  readonly msg: string
}

export function resultSuccess(result: HttpResult): boolean {
  return result.code == 200
}