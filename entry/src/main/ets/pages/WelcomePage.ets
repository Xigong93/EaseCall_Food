import common from '@ohos.app.ability.common'
import preferences from '@ohos.data.preferences'
import router from '@ohos.router'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'

const PREF_KEY ='userPrivacyKey'
@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController= new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm:()=> this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })
 async aboutToAppear() {
   //加载首选项
   let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
   //判断是否同意
   if (isAgree) {
     //同意，跳转首页
     this.jumpToMainPage()

   }
   else {
     //不同意，弹窗
     this.controller.open()
   }

 }

  jumpToMainPage(){
  setTimeout(()=>{
    router.replaceUrl({
      url:'pages/MainPage'
    })
  },1000) //设置延迟时间
}
  onConfirm(){
    // 保存首选项
     PreferenceUtil.getPreferenceValue(PREF_KEY,false)
    //跳转到首页
    this.jumpToMainPage()
  }
  exitApp(){
    // exit  应用
    this.context.terminateSelf()
  }

  build() {
    Column() {
      //1.中央Slogan
      Image($r('app.media.logo')).width(400).position({x:80})

      Image($r('app.media.Slogo')).width(220).position({x:6,y:560})
      //3.文字描述
      Row(){
        Text('简吃支持').fontSize(15).opacity(0.8).fontColor(Color.White)
        Text('IPV6')
          .fontSize(13).opacity(0.8).fontColor(Color.White)
          .border({style:BorderStyle.Solid,width:1,color:Color.White,radius:15})
          .padding({left:6,right:5})
        Text('网络').fontSize(15).opacity(0.8).fontColor(Color.White)
      }.width('100%')
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.Center)
      .margin({bottom:20})
      .position({y:750})
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.WelcomePageColor'))
    .backgroundImageSize(1)//背景图铺满整个页面

  }
}