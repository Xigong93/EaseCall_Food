@Preview
@Component
export default struct SearchBox {
  build() {
    Row() {
      Image($r('app.media.home_search'))
        .width(22)
        .width(22)
      Text('搜索')
        .fontSize(18)
        .margin({ left: 8 })
        .fontColor("#dcdcdc")
    }
    .padding({ left: 10, right: 10 })
    .width('100%')
    .height(46)
    .backgroundColor(Color.White)
    .borderRadius(23)
  }
}