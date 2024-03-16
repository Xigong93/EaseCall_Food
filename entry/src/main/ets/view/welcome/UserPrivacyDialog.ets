@Preview
@CustomDialog
export default struct UserPrivacyDialog {
  controller: CustomDialogController
  confirm: () => void  //无参 函数
  cancel: () => void
  build() {
    Column({space:10}){
      //标题
      Text($r('app.string.user_privacy_title'))
        .fontSize(20)
        .fontWeight(110)

      //内容
      Text('xxxxxxxxxxxxxxxxx,xxxxxxxxxxxxxxxxx,' +
      'xxxxxxxxxxxxxxxxx' +
      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' +
      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' +
      'xxxxxxxxxxxxxxxxx')
      //按钮
      Row()
      {
        Button($r('app.string.disagree_label'))
          .width(120)
          .backgroundColor($r('app.color.light_grey'))
          .onClick(()=>{
            this.cancel()
            this.controller.close()
          })
        Blank()
        Button($r('app.string.agree_label'))
          .width(120)
          .backgroundColor(Color.Orange)
          .onClick(()=>{
            this.confirm()
            this.controller.close()
          })
      }.width('100%')
      .padding(30)
    }
    .width('100%')
    .padding(10)
    .height(220)
  }
}