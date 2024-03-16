import router from '@ohos.router'
import {Header} from '../common/CommonComponents'
import {SearchBox} from '../common/SearchBox'
class DrugCard {
  name :string
  image : ResourceStr
  url:string

  constructor(name:string,image:ResourceStr,url:string) {
    this.name=name
    this.image=image
    this.url=url
  }
}

@Builder function DrugItem(card:DrugCard) {
  Column() {
    Image(card.image).interpolation(ImageInterpolation.High)
      .width('80%')
    Text(card.name)
      .fontSize(13)
      .fontWeight(FontWeight.Regular)

  }.width('20%')
  .height('60%')
  .onClick(()=>{
    //路由页面
    router.pushUrl({
      url:card.url,
      params:{id:1}
    },
      router.RouterMode.Single,
      err =>{
        if(err){ //路由失败 错误检查
          console.log(`路由失败，errCode:${err.code} errMsg:${err.message}`)
        }
      }
    )
  })
}
@Entry
@Component
struct DrugPage {
  @State message: string = 'Hello World'
  private cards:Array<DrugCard> =[
    new DrugCard('感冒发烧',$r('app.media.icon'),''),
    new DrugCard('必胜客',$r('app.media.icon'),''),
    new DrugCard('必胜客',$r('app.media.icon'),'',),
    new DrugCard('必胜客',$r('app.media.icon'),''),
    new DrugCard('感冒发烧',$r('app.media.icon'),''),
    new DrugCard('必胜客',$r('app.media.icon'),''),
    new DrugCard('必胜客',$r('app.media.icon'),'',),
    new DrugCard('必胜客',$r('app.media.icon'),'')


  ]
  build() {
    Row() {
      Column() {
        Header({title:'买药'}).margin(({top:10,bottom:5}))
        SearchBox()
        //使用网格
        Row(){
          Grid(){
            ForEach(
              this.cards,//遍历卡片数组
              (card:DrugCard) => {
                GridItem(){
                  DrugItem(card)

                }
              }
            )
          }
          .rowsTemplate('1fr 1fr 1fr')

        }
        .width('90%')
        .height('35%')
        .margin({left:10,right:10})

      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}