import router from '@ohos.router'
@Component
export struct Header {
  private title: ResourceStr
  @State params:any = router.getParams()
  build() {
    Row() {    //四个主页面的  顶部组件
      Image($r('app.media.return2'))
        .height(26)
        .width(39)
        .interpolation(ImageInterpolation.High)
        .onClick(()=>{
          // router.showAlertBeforeBackPage({
          //   message: '用户未登录，部分功能会无法使用，是否返回？'
          // })
          //return
          router.back()
      })
      if(this.params && this.title){
        Text(this.params.id+'.'+this.title)//
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Orange)
      }
      Blank()

    }
    .alignItems(VerticalAlign.Top)
    .margin({top :10})
    .height(30)
    .width('90%')
  }
}