import appApi from '../../api/AppApi'
import { formatImgUrl } from '../../net/HttpRequest'
import { auxiliary, pageBackground, primary } from '../../style/AppColor'
import { openFoodDetailPage } from './detail/FoodDetailPage'
import Food from './Food'

@Preview
@Component
export default struct FoodCell {
  private food: Food = appApi.getSampleFood()

  build() {
    Row() {
      Image(formatImgUrl(this.food.image))
        .width(120)
        .backgroundColor(pageBackground)
        .height(80)
        .borderRadius(6)
      this.textArea()
    }
    .width('100%')
    .height(100)
    .padding(12)
    .backgroundColor('#fff')
    .borderRadius(6)
    .onClick(() => openFoodDetailPage(this.food))
  }

  @Builder
  textArea() {
    Column() {
      Text(this.food.name)
        .textAlign(TextAlign.Start) //zu
        .fontSize(20)
        .fontWeight(FontWeight.Regular)
      Text("月售100+")
        .fontSize(12)
        .fontColor("#7a7a7a")
      Row() {
        Text(`￥${this.food.price}`)
          .fontSize(16)
          .fontColor(Color.Red)
        // Blank(80)

        Blank()
        Text("购买")
          .width(56)
          .height(26)
          .textAlign(TextAlign.Center)
          .fontSize(12)
          .fontColor(Color.White)
          .borderRadius(13)
          .backgroundColor(primary)
      }
      .width('100%')
    }
    .layoutWeight(1)
    .height('100%')
    .margin({ left: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}




