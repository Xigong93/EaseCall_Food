import image from '@ohos.multimedia.image'
import SearchBox from './SearchBox'

import { PagePadding } from '../../style/AppDimission'
import router from '@ohos.router'
import appApi from '../../api/AppApi'
import Food from '../food/Food'
import FoodCell from '../food/FoodCell'


@Preview
@Component
export default struct DeliveryTab {
  build() {
    Column() {
      List({ space: 20 }) {
        ListItem() {
          Column({ space: 20 }) {
            SearchBox()
            functionArea()
            banner()
          }
        }

        ForEach(foods, (item: Food) => {
          ListItem() {
            FoodCell()
          }
        })
      }
    }
    .width("100%")
    .height("100%")
    .padding({ left: PagePadding, right: PagePadding })

  }
}

/**
 * 功能区
 */
@Builder function functionArea() {
  Row({ space: 30 }) {
    IconButton("美食", $r('app.media.icon_sandwich'), '')
    IconButton("蔬菜水果", $r('app.media.icon_fruit'), '')
    IconButton("看病买药", $r('app.media.icon_drug'), '')
    IconButton("品质百货", $r('app.media.icon_supermarket'), '')
  }
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
