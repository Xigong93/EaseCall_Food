import router from '@ohos.router'
import {Header} from '../common/CommonComponents'
@Styles function card(){
  .position({y:90})
  .width('100%')
  .height(500)
  .backgroundColor('#FFFFFF')
  .border({radius:10})//目的保证圆滑
}
@Entry
@Component
struct  LogOrRegister {
  @State message: string = 'Hello World'
  @State variable: number = 1
  build() {
    Column() {
      Row(){
        Image($r('app.media.return2'))
          .height(30)
          .width(45)
          .interpolation(ImageInterpolation.High)
          .onClick(()=>{
            router.showAlertBeforeBackPage({
              message: '用户未登录，部分功能会无法使用，是否返回？'
            })
            //return
            router.back()
          })
          .margin({top:10,left:10})//页面头，返回
        Blank()
        Text('注册')
          .fontSize(25)
          .fontColor(Color.White)
          .height(40)
          .margin({right:20,top:5})
          .onClick(()=>{
            // router 跳转   if条件语句 跳转
            this.variable = 0

          })
      }
      .alignItems(VerticalAlign.Top)
      .margin({top :10})
      .height(30)
      .width('100%')

      Row() {
        if(this.variable){
          Column(){
            Image($r('app.media.LogTop'))
              .width('50%')

            Text($r('app.string.LogText'))
              .fontSize(18)
              .fontColor('#ffddaf')
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center) //文字居中
              .margin({bottom:50})
            Row(){//账号
              TextInput({placeholder:'请输入您的账号'})
                .width(400)
                .height(40)
                .margin(20)
                .maxLength(9)


            }
            Row(){//密码
              TextInput({ placeholder: '请输入密码' })
                .width(400)
                .height(40)
                .margin({right:20,left:20,bottom:20})
                .type(InputType.Password)
                .maxLength(9)
                .showPasswordIcon(true)
            }
            Button('登陆账号')
              .border({radius:10})
              .width(100)
              .height(30)
              .backgroundColor(0xffddaf)
              .onClick(()=>{
                // router 跳转
                router.replaceUrl({  //转到主页面登陆成功，并销毁该页面，不压入stack中
                  url: 'pages/MainPage',
                  params: 1 //传参
                },
                  router.RouterMode.Single,
                  err =>{
                    if(err){
                      console.log(`路由失败，errCode:${err.code} errMsg:${err.message}`)
                    }
                  }
                )

              })
            Column(){
              Row(){
                Text('-其他方式登录-')
                  .fontColor(0xffddaf)
                  .fontSize(10)
                  .margin(10)
              }
              Image($r('app.media.wechat'))
                .width(20)
                .onClick(()=>{

                })
            }.justifyContent(FlexAlign.SpaceBetween)
            .margin({right:10,left:10,top:20})
            Blank()
            Text('忘记密码')
              .fontColor(0xffddaf)
              .textAlign(TextAlign.End)
              .fontSize(15)
              .padding(10)
              .width('100%')
              .onClick(()=>{ //转到找回密码的
                router.pushUrl({
                  url: 'pages/Retrieve',
                  params: 1 //传参
                },
                  router.RouterMode.Single,
                  err =>{
                    if(err){
                      console.log(`路由失败，errCode:${err.code} errMsg:${err.message}`)
                    }
                  }
                )
              })
          }
          .card() //样式函数

        }
        else {
          Column() {
            Image($r('app.media.LogTop'))
              .width('50%')

            Text($r('app.string.LogText'))
              .fontSize(18)
              .fontColor('#ffddaf')
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center) //文字居中
              .margin({ bottom: 50 })
            Row() { //账号
              TextInput({ placeholder: '请输入您的账号' })
                .width(400)
                .height(40)
                .margin(20)
                .maxLength(9)
            }

            Row() { //密码
              TextInput({ placeholder: '请输入密码' })
                .width(400)
                .height(40)
                .margin({ right: 20, left: 20, bottom: 20 })
                .type(InputType.Password)
                .maxLength(9)
                .showPasswordIcon(true)
            }
              Row() { //密码
                TextInput({ placeholder: '请再次输入确认密码' })
                  .width(400)
                  .height(40)
                  .margin({ right: 20, left: 20, bottom: 20 })
                  .type(InputType.Password)
                  .maxLength(9)
                  .showPasswordIcon(true)
              }

              Button('注册账号')
                .border({ radius: 10 })
                .width(100)
                .height(30)
                .backgroundColor(0xffddaf)
                .onClick(() => {

                  this.variable = 1

                })


          }
          .card() //样式函数
        }

      }
      .width('70%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffddaf')
  }
}