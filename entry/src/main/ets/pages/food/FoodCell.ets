import { auxiliary, primary } from '../../style/AppColor'
import Food from './Food'

@Preview
@Component
export default struct FoodCell {
  private food: Food = { name: "香辣炒虾尾", image: "app.media.food1", price: 68 }

  build() {

    Row() {
      Image($r("app.media.food1"))
        .width(120)
        .height(80)
        .borderRadius(6)
      this.textArea()
    }
    // .padding({ left: 10, right: 10 })
    .width('100%')
    .height(100)
    .padding({ left: 12, right: 12 })
    .backgroundColor('#fff')
    .borderRadius(6)
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

        Text("购买")
          .width(56)
          .height(26)
          .textAlign(TextAlign.Center)
          .fontSize(12)
          .fontColor(Color.White)
          .margin({ left: 90 })
          .borderRadius(13)
          .backgroundColor(primary)

      }
    }
    .height(80)
    .margin({ left: 10 })
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}




