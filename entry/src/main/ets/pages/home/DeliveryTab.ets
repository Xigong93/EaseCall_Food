import image from '@ohos.multimedia.image'

import { PagePadding } from '../../style/AppDimission'
import router from '@ohos.router'
import appApi from '../../api/AppApi'
import Food from '../food/Food'
import FoodCell from '../food/FoodCell'
import { pageBackground } from '../../style/AppColor'
import { openFoodDetailPage } from '../food/detail/FoodDetailPage'
import openFoodList from '../food/FoodListPage'
import foodApi from '../food/FoodApi'
import Logger from '../../utils/Logger'

const logger = new Logger("外卖Tab")

@Preview
@Component
export default struct DeliveryTab {
  @State
  private foods: Array<Food> = []

  async aboutToAppear() {
    logger.info("页面可见")
    this.foods = await foodApi.getFoods()
  }

  aboutToDisappear() {
    logger.info("页面销毁")
  }

  build() {
    Column() {
      SearchBox()
        .margin(PagePadding)
      List({ space: 20 }) {
        ListItem() {
          this.header()
        }

        ForEach(this.foods, (item: Food) => {
          ListItem() {
            FoodCell({ food: item })
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
    IconButton("美食", $r('app.media.icon_sandwich'), $r('app.media.food_header'))
    IconButton("蔬菜水果", $r('app.media.icon_fruit'), $r('app.media.fruit_header'))
    IconButton("看病买药", $r('app.media.icon_drug'), $r('app.media.drag_header'))
    IconButton("品质百货", $r('app.media.icon_supermarket'), $r('app.media.mark_header'))
  }
  .width("100%")
  .justifyContent(FlexAlign.SpaceAround)
}

@Builder
function IconButton(text: string, icon: Resource, headerImg: Resource) {
  Column({ space: 8 }) {
    Image(icon)
      .width(32)
    Text(text)
      .fontSize(13)
  }
  .onClick(() => openFoodList(text, headerImg))
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