import { auxiliary, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import showToast from '../../utils/ToastUtil'
import Loading from '../../widget/Loading'
import TitleBar from '../../widget/TitleBar'
import Food from '../food/Food'
import foodApi from '../food/FoodApi'
import FoodCell from '../food/FoodCell'

@Entry
@Component
export default struct SearchPage {
  @State
  private loading: boolean = false
  @State
  private foods: Array<Food> = []

  build() {
    Column() {
      TitleBar({ title: "搜索" })
      Stack() {
        Column() {
          SearchBox({ onSearch: (text) => {
            this.performSearch(text)
          } })
            .margin({ top: 20, left: PagePadding, right: PagePadding })
          List({ space: PagePadding }) {
            ForEach(this.foods, (food: Food) => {
              ListItem() {
                FoodCell({ food: food })
              }
            })
          }.padding(PagePadding)
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')

        if (this.loading) {
          Loading({ msg: "搜索中" })
        }
      }
      .width('100%')
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }

  private async performSearch(keyword: string) {
    if (!keyword) {
      showToast("请输入关键字进行搜索")
      return
    }
    this.loading = true
    try {
      const foods = await foodApi.searchFood(keyword.trim())
      this.foods = foods ?? []
      if (!foods || foods.length == 0) {
        showToast("搜索结果为空")
      }
    } finally {
      this.loading = false
    }
  }
}

@Preview
@Component
struct SearchBox {
  private onSearch: (value: string) => void
  private inputText = ''

  build() {
    Row() {
      Image($r('app.media.home_search'))
        .width(22)
        .width(22)
      TextInput({ placeholder: '搜索', text: "黄瓜" })
        .fontSize(18)
        .margin({ left: 8 })
        .fontColor("#dcdcdc")
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onChange((value) => {
          this.inputText = value
        })
        .layoutWeight(1)
      Text("搜索")
        .padding({ left: 10, right: 10, top: 6, bottom: 6 })
        .fontColor(primary)
        .onClick(() => {
          this.onSearch(this.inputText)
        })
    }
    .padding({ left: 10, right: 10 })
    .width('100%')
    .height(46)
    .backgroundColor(Color.White)
    .borderRadius(23)
  }
}