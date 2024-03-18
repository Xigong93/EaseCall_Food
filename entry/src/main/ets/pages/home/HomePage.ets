import router from '@ohos.router';
import image from '@ohos.multimedia.image';
import DeliveryTab from './DeliveryTab';
import ShoppingCartTab from './ShoppingCartTab'
import MineTab from './MineTab'
import { divider, primary } from '../../style/AppColor';

const normalColor = "#7a7a7a"
/**
 * 首页
 */
@Entry
@Component
struct HomePage {
  @State currentIndex: number = 0
  private barControl = new TabsController()

  @Builder
  TabBarItem(title: string, icon: Resource, selectedIcon: Resource, index: number) {

    Column() {
      Divider()
        .backgroundColor(divider)
      Image(this.currentIndex == index ? selectedIcon : icon)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex == index ? primary : normalColor)
    }
    .width('100%')
    .onClick(() => {
      this.currentIndex = index
      this.barControl.changeIndex(index)
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.barControl }) {
      // 外卖
      TabContent() {
        DeliveryTab()
      }
      .tabBar(this.TabBarItem("外卖", $r("app.media.home_deliv_0"), $r("app.media.home_deliv_1"), 0))

      // 购物车
      // TabContent() {
      //   ShoppingCartTab()
      // }
      // .tabBar(this.TabBarItem("购物车", $r("app.media.home_car_0"), $r("app.media.home_car_1"), 1))
      // 我的
      TabContent() {
        MineTab()
      }
      .tabBar(this.TabBarItem("我的", $r("app.media.home_mine_0"), $r("app.media.home_mine_1"), 2))
    }
    .width("100%")
    .height("100%")
    .scrollable(false)

  }
}
