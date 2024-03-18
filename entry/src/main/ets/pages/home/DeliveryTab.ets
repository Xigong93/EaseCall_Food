import image from '@ohos.multimedia.image'
import SearchBox from './SearchBox'

import { PagePadding } from '../../style/AppDimission'
import router from '@ohos.router'
import appApi from '../../api/AppApi'
import Food from '../food/Food'
import FoodCell from '../food/FoodCell'
import HomeTitleBar from './HomeTitltBar'
import HorizontalLine from '../../widget/HorizontalLine'
import { pageBackground } from '../../style/AppColor'


@Preview
@Component
export default struct DeliveryTab {
  build() {
    Column() {
      HomeTitleBar({ title: "外卖" })
      HorizontalLine()
      List({ space: 20 }) {
        ListItem() {
          this.header()
        }

        ForEach(foods, (item: Food) => {
          ListItem() {
            FoodCell()
          }
        })
      }
      .padding({ left: PagePadding, right: PagePadding })

    }
    .backgroundColor(pageBackground)
    .width("100%")
    .height("100%")

  }

  @Builder
  header() {
    Column({ space: 20 }) {
      SearchBox()
        .margin({ top: 15 })
      functionArea()
      banner()
    }
  }
}

/**
 * 功能区
 */
@Builder function functionArea() {
  Row() {
    IconButton("美食", $r('app.media.icon_sandwich'), '')
    IconButton("蔬菜水果", $r('app.media.icon_fruit'), '')
    IconButton("看病买药", $r('app.media.icon_drug'), '')
    IconButton("品质百货", $r('app.media.icon_supermarket'), '')
  }
  .width("100%")
  .justifyContent(FlexAlign.SpaceAround)
}

@Builder
function IconButton(text: string, icon: Resource, url: string) {
  Column({ space: 8 }) {
    Image(icon)
      .width(32)
      .onClick(() => {
        //路由页面
        router.pushUrl({ url })
      })
    Text(text)
      .fontSize(13)
  }
}


const bannerImg = [
$r("app.media.banner1"),
$r("app.media.banner2"),
$r("app.media.banner3"),
$r("app.media.banner4"),
$r("app.media.banner5"),
$r("app.media.banner6")
]

@Builder
function banner() {

  Swiper() { //轮播
    ForEach(bannerImg, (img: Resource) => {
      Image(img)
        .borderRadius(8)
    })
  }
  .autoPlay(true)
  .width("100%")
  .height(140)
  .borderRadius(8)
}

const foods = appApi.getFoods()
