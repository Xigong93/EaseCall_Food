/**
 * 食物详情页面
 */
import router from '@ohos.router'
import appApi from '../../../api/AppApi'
import { divider, pageBackground, primary } from '../../../style/AppColor'
import { PagePadding } from '../../../style/AppDimission'
import TitleBar from '../../../widget/TitleBar'
import Food from '../Food'
import CommentCard from './CommentCard'
import DetailCard from './DetailCard'

/**
 * 打开食物详情页面
 * @param food
 */
export function openFoodDetailPage(food: Food) {
  router.pushUrl({ url: "pages/food/detail/FoodDetailPage", params: { food } })
}

@Entry
@Component
struct FoodDetailPage {
  private readonly food: Food = appApi.getSampleFood()

  build() {
    Column() {
      TitleBar({ title: this.food.name })
      this.content()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  content() {
    Scroll() {
      Column() {
        Image($r("app.media.food1"))
          .width('100%')
          .aspectRatio(16 / 9)
        this.infoCard()
        this.divider()
        DetailCard()
        this.divider()
        CommentCard()
        Row().height(PagePadding)
      }
      .width('100%')

    }
    .scrollable(ScrollDirection.Vertical)
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  divider() {
    Row()
      .height(8)
      .width('100%')
      .backgroundColor(divider)
  }

  @Builder
  infoCard() {
    Column({ space: 10 }) {
      Row() {
        Text("香辣炒虾尾（30颗，颗颗Q弹~够香够辣，不好吃全额退款")
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .fontSize(18)
      }
      .width('100%')

      Text("月售300+")
        .fontColor('#7a7a7a')

      Row({ space: 6 }) {
        Text(`￥${this.food.price}`)
          .fontSize(24)
          .fontColor(Color.Red)
        Text(`￥${this.food.price * 1.1}`)
          .fontSize(12)
          .decoration({ type: TextDecorationType.LineThrough })
          .fontColor('#7a7a7a')

        Text(`打包费 ￥0.99/1份`)
          .fontSize(12)
          .fontColor('#7a7a7a')
        Blank()
        Text("购买")
          .width(80)
          .height(30)
          .textAlign(TextAlign.Center)
          .fontSize(12)
          .fontColor(Color.White)
          .borderRadius(4)
          .backgroundColor(primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(PagePadding)
  }
}

