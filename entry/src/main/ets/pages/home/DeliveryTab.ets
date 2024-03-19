import image from '@ohos.multimedia.image'

import { PagePadding } from '../../style/AppDimission'
import router from '@ohos.router'
import appApi from '../../api/AppApi'
import Food from '../food/Food'
import FoodCell from '../food/FoodCell'
import { pageBackground } from '../../style/AppColor'
import { openFoodDetailPage } from '../food/detail/FoodDetailPage'


@Preview
@Component
export default struct DeliveryTab {
  build() {
    Column() {
      SearchBox()
        .margin(PagePadding)
      List({ space: 20 }) {
        ListItem() {
          this.header()
        }

        ForEach(foods, (item: Food) => {
          ListItem() {
            FoodCell()
          }
        })
        ListItem()
      }
      .layoutWeight(1)
      .padding({ left: PagePadding, right: PagePadding })

    }
    .backgroundColor(pageBackground)
    .width("100%")
    .height("100%")

  }

  @Builder
  header() {
    Column({ space: 20 }) {

      functionArea()
      banner()
    }
    .margin({ top: 10 })
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

    Text(text)
      .fontSize(13)
  }.onClick(() => {
    //路由页面
    router.pushUrl({ url: "pages/food/FoodListPage", params: { title: text } })
  })
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
        .onClick(() => openFoodDetailPage(appApi.getSampleFood()))

    })
  }
  .autoPlay(true)
  .width("100%")
  .height(120)
  .borderRadius(8)
}

const foods = appApi.getFoods()


@Preview
@Component
struct SearchBox {
  build() {
    Row() {
      Image($r('app.media.home_search'))
        .width(22)
        .width(22)
      Text('搜索')
        .fontSize(18)
        .margin({ left: 8 })
        .fontColor("#dcdcdc")
    }
    .padding({ left: 10, right: 10 })
    .width('100%')
    .height(46)
    .backgroundColor(Color.White)
    .borderRadius(23)
    .onClick(() => {
      router.pushUrl({ url: 'pages/search/SearchPage' })
    })
  }
}