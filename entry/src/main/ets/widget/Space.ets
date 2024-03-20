@Component
export struct HorizontalSpace {
  private readonly space: Length = 10

  build() {
    Divider()
      .backgroundColor(Color.Transparent)
      .width(this.space)
      .height(1)
  }
}

@Component
export struct VerticalSpace {
  private readonly space: Length = 10

  build() {
    Divider()
      .backgroundColor(Color.Transparent)
      .width(1)
      .height(this.space)
  }
}