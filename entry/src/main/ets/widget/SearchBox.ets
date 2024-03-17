@Preview
@Component
export struct SearchBox  {
  build() {
    Row(){
      Search({ placeholder: '搜索外卖信息' })
        .textFont({size:18})
        .width('60%')
        .height(40)
        .margin({left:20,right:10})
      Button('搜索')
        .border({ radius: 10 })
        .width('20%')
        .height(30)
        .backgroundColor(0xffddaf)
    }
    .width('100%')
    .margin({left:10,right:10})
  }
}