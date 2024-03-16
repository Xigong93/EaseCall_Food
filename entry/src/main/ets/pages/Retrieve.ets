import router from '@ohos.router'


@Entry
@Component
struct Retrieve {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Column(){
        Row() {
          Image($r('app.media.return2'))
            .height(30)
            .width(45)
            .interpolation(ImageInterpolation.High)
            .margin({top:15,left:10})//页面头，返回
            .onClick(()=>{
              router.showAlertBeforeBackPage({
                message: '找回密码未完成'
              })
              //return
              router.back()
            })

          Text('找回密码')
            .fontSize(25)
            .textAlign(TextAlign.Center)
            .position({x:65,y:15})

        }
        .width('100%')
        Divider()
          .width('100%')
      }.width('100%')
      .margin({bottom:60})
      Column(){
        Row(){
          Column(){
            Row(){
              Image($r('app.media.phone'))
                .width(25)
                .height(30)

              TextInput({ placeholder: '手机号'})
                .backgroundColor('#ffF')
                .type(InputType.Number) //手机号数字输入
                .width(160)
                .height(45)
              Button('重新发送')
                .border({radius:10})
                .backgroundColor('#00bfff')
                .onClick(()=>{   //重新发送验证码

                })
            }.width('100%')
            Divider()
              .width('90%')
          }
        }.width('80%')
        .margin({bottom:20})
//验证码
        Row(){
          Column(){
            Row(){
              Image($r('app.media.shield'))
                .width(25)
                .height(30)


              TextInput({ placeholder: '手机验证码'})
                .backgroundColor('#ffF')
                .fontSize(40) //
                .type(InputType.Number)
                .width(160)
                .height(45)
            }.width('100%')
            Divider()
              .width('90%')

          }
        }.width('80%')
        .margin({bottom:20})
//新的密码
        Row(){
          Column(){
            Row(){
              Image($r('app.media.lock'))
                .width(25)
                .height(30)

              TextInput({ placeholder: '新的密码'})
                .backgroundColor('#ffF')
                .type(InputType.Number) //密码输入
                .width(250)
                .height(45)
                .type(InputType.Password)
                .maxLength(60)
                .showPasswordIcon(true)
            }.width('100%')
            Divider()
              .width('90%')
          }
        }.width('80%')
        .margin({bottom:20})
        Button('确定')
          .border({radius:10})
          .backgroundColor('#00bfff')
          .onClick(()=>{   //重新设置密码成功
            //首先设置条件是否符合 验证码 / 新密码的格式 然会返回成功修改
              router.back()
          })

      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
  }
}