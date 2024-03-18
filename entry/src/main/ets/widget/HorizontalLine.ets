import { divider } from '../style/AppColor'

@Component
export default struct HorizontalLine {
  build() {
    Divider()
      .width("100%")
      .height(0.5)
      .backgroundColor(divider)
  }
}