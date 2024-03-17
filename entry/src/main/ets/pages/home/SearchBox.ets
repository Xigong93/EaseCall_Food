@Preview
@Component
export default struct SearchBox {
  build() {
    Row() {
      Search({ placeholder: '搜索' })
        .textFont({ size: 18 })
        .width('100%')
        .focusable(false)
    }
    .width('100%')
    .height(50)
    .margin({ top: 20 })
  }
}