import { PagePadding } from '../../style/AppDimission'

@Component
export default struct HomeTitleBar {
  private title: string

  build() {
    Row() {
      Text(this.title)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .height(50)
    .width("100%")
    .padding({ left: PagePadding, right: PagePadding })
  }
}

@Preview
@Component
struct HomeTitleBarPreview {
  build() {
    HomeTitleBar({ title: "外卖" })
  }
}