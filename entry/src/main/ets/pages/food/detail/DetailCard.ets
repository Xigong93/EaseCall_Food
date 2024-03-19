import { PagePadding } from '../../../style/AppDimission'
@Preview
@Component
export default struct DetailCard {
  build() {
    Column() {
      Text("详情")
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .fontSize(18)


      Column({ space: 8 }) {

        this.rowInfo("主料", "虾尾")
        this.rowInfo("菜系", "其它菜系")
        this.rowInfo("分量", "2人份")
        this.rowInfo("口味", "蒜香")
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