import { pageBackground } from '../style/AppColor'

@Component
export default struct PageContainer {

  @BuilderParam
  private builder: () => void

  build() {
    Column() {
      this.builder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(pageBackground)
  }
}