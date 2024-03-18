import router from '@ohos.router'
import appApi from '../../api/AppApi'
import { pageBackground } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import TitleBar from '../../widget/TitleBar'
import Food from './Food'
import FoodCell from './FoodCell'

@Entry
@Component
struct FoodListPage {
  title: string

  aboutToAppear() {
    this.title = router.getParams()["title"]
  }

  build() {
    Column() {
      TitleBar({ title: this.title })
      List({ space: 15 }) {
        ListItem()
        ForEach(foods, (item: Food) => {
          ListItem() {
            FoodCell()
          }
        })
      }
      .padding({ left: PagePadding, right: PagePadding })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}

const foods = appApi.getFoods()
