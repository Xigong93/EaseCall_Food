@Component
export default struct MineTab {
  build() {
    Column() {
      Text('个人中心').fontSize(30)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 20, bottom: 40 })
      Row() {
        //用户头像和姓名
      }

      Row() {
        //购物车
      }

      Row() {
        Column() {
          Text('订单')
            .fontSize(20)
            .margin({ top: 10, left: 5, bottom: 5 })
          //采用list罗列出历史订单
        }
      }.width('100%')
      .backgroundColor(Color.White)
      .border({ radius: 15 })
    }
  }
}