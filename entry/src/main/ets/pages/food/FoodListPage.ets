import router from '@ohos.router'
import image from '@ohos.multimedia.image'
import appApi from '../../api/AppApi'
import { pageBackground } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import TitleBar from '../../widget/TitleBar'
import Food from './Food'
import FoodCell from './FoodCell'
import Logger from '../../utils/Logger'
import foodApi from './FoodApi'
import PageStateView, { ContentPage, EmptyPage, LoadingPage } from '../../widget/PageState'

export default function openFoodList(title: string, image: Resource) {
  const params = {
    title, image
  }
  router.pushUrl({
    url: "pages/food/FoodListPage", params
  })
}

const logger = new Logger("商品列表")

@Entry
@Component
struct FoodListPage {
  @State
  private foods: Array<Food> = []
  @State
  private pageState: number = LoadingPage

  async aboutToAppear() {
    this.pageState = LoadingPage
    this.foods = await foodApi.getFoods()
    if (this.foods.length > 0) {
      this.pageState = ContentPage
    } else {
      this.pageState = EmptyPage
    }

  }

  getTitle(): string {
    return router.getParams()["title"] ?? "美食"
  }

  getImage(): Resource {
    return router.getParams()["image"] ?? $r("app.media.food_header")
  }

  build() {
    Column() {
      TitleBar({ title: this.getTitle() })

      PageStateView({ pageState: this.pageState }) {
        List({ space: 15 }) {
          ListItem()
          ListItem() {
            Image(this.getImage())
              .borderRadius(6)
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

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}
