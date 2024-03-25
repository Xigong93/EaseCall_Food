import { primary } from '../style/AppColor'

@Preview
@Component
export default struct Loading {
  @Prop
  private msg: string
  private readonly loadingSize: number = 120
  private readonly color: Color = Color.White

  build() {
    Column() {
      Stack() {
        Column() {
          LoadingProgress()
            .width(70)
            .height(70)
            .color(this.color)
          Text(this.msg ?? "加载中")
            .fontColor(this.color)
        }
      }
      .width(this.loadingSize)
      .height(this.loadingSize)
      .backgroundColor("#cc000000")
      .alignContent(Alignment.Center)
      .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#7f000000')
    .onClick(() => {
      // 拦截点击事件
    })
  }
}