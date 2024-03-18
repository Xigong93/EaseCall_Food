import { pageBackground } from '../../style/AppColor'
import HomeTitleBar from './HomeTitltBar'

@Preview
@Component
export default struct ShoppingCartTab {
  build() {
    Column() {
      HomeTitleBar({ title: "购物车" })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}

/**
 * 商品
 */
class Commodity {
  /** 名称 */
  readonly name: string
  /** 图片 */
  readonly image: string
  /** 价格，单位元 */
  readonly price: number

  /** 数量 */
  readonly count: number
}

@Preview
@Component
struct CommodityCell {
  private commodity:Commodity
  build(){

  }
}