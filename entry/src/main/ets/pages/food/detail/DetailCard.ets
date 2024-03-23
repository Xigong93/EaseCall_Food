import { PagePadding } from '../../../style/AppDimission'
import Food from '../Food'

@Preview
@Component
export default struct DetailCard {
  private food: Food

  build() {
    Column() {
      Text("详情")
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .fontSize(18)


      Column({ space: 8 }) {

        this.rowInfo("主料", this.food.name)
        this.rowInfo("菜系", "其它菜系")
        this.rowInfo("分量", "1人份")
        this.rowInfo("口味", "正常")
      }
      .margin({ top: 12 })
      .alignItems(HorizontalAlign.Start)

    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(PagePadding)
  }

  @Builder
  rowInfo(text1: string, text2: string) {
    Row() {
      Text(`${text1}:`)
        .width(60)
        .fontSize(12)
        .fontColor('#7a7a7a')

      Text(text2)
        .fontSize(12)
        .fontColor(Color.Black)
    }
  }
}