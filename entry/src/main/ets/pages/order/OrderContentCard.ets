import appApi from '../../api/AppApi'
import { pageBackground } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import Food from '../food/Food'

@Preview
@Component
export default struct OrderContentCard {
  private food: Food

  build() {
    Column({ space: 14 }) {
      cardTitle("商品信息")
      FoodCard({ food: this.food })
      Divider()
      this.priceItem("打包费", "￥2")
      this.priceItem("配送费", "￥3")
      this.negativePrice("平台红包", "-￥5")
      Divider()
      this.totalPrice()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(PagePadding)
    .backgroundColor('#fff')
    .borderRadius(6)
  }

  @Builder
  priceItem(subject: string, price: string) {
    Row() {
      Text(subject)
        .fontColor(Color.Black)
        .fontSize(14)
      Blank()
      Text(price)
        .fontColor(Color.Black)
        .fontSize(14)
    }
    .width('100%')

  }

  @Builder
  totalPrice() {
    Row() {
      Text("总计")
        .fontColor(Color.Black)
        .fontSize(18)
      Blank()
      Text(`￥${this.food.price}`)
        .fontColor(Color.Black)
        .fontSize(18)
    }
    .width('100%')

  }

  @Builder
  negativePrice(subject: string, price: string) {
    Row() {
      Text(subject)
        .fontColor(Color.Black)
        .fontSize(14)
      Blank()
      Text(price)
        .fontColor(Color.Red)
        .fontSize(14)
    }
    .width('100%')

  }

  @Builder
  foodArea() {

  }
}

@Component
struct FoodCard {
  private food: Food

  build() {
    Row() {
      Image(this.food.image)
        .width(120)
        .backgroundColor(pageBackground)
        .height('100%')
        .borderRadius(6)
      this.textArea()
    }
    .height(80)
  }

  @Builder
  textArea() {
    Column() {
      Text(this.food.name)
        .textAlign(TextAlign.Start) //zu
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
      Text("320克")
        .fontSize(12)
        .fontColor("#7a7a7a")
      Text(`￥${this.food.price}`)
        .fontSize(14)
    }
    .height('100%')
    .layoutWeight(1)
    .margin({ left: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Builder
function cardTitle(label: string) {
  Text(label)
    .fontColor(Color.Black)
    .fontSize(16)
    .fontWeight(FontWeight.Medium)
}