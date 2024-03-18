import { auxiliary, pageBackground, primary } from '../../style/AppColor'
import { PagePadding } from '../../style/AppDimission'
import showToast from '../../utils/ToastUtil'
import TitleBar from '../../widget/TitleBar'

@Entry
@Component
export default struct SearchPage {
  private inputText = ''

  build() {
    Column() {
      TitleBar({ title: "搜索" })

      SearchBox({ onSearch: (text) => {
        showToast(`开始搜索，输入的文字是:${text}`)
      } })
        .margin({ top: 20, left: PagePadding, right: PagePadding })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
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
      TextInput({ placeholder: '搜索' })
        .fontSize(18)
        .margin({ left: 8 })
        .fontColor("#dcdcdc")
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onChange((value) => {
          this.inputText = value
        })
        .layoutWeight(1)
      Text("确定")
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