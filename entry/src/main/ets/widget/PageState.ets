import { pageBackground } from '../style/AppColor'


export const LoadingPage = 1

export const EmptyPage = 2

export const ContentPage = 3

@Component
export default struct PageStateView {
  @BuilderParam
  private builder: () => void
  @Prop
  pageState: number

  build() {
    Column() {
      if (this.pageState == LoadingPage) {
        this.loading()
      } else if (this.pageState == ContentPage) {
        this.content()
      } else {
        this.empty()
      }
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor(pageBackground)
  }

  @Builder
  private loading() {
    Column() {
      LoadingProgress()
        .width(56)
        .height(56)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  @Builder
  private content() {
    this.builder()
  }

  @Builder
  private empty() {
    Column() {
      Text("没有内容")
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}