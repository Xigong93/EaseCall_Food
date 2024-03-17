export default interface Food {
  /**
   * 名称
   */
  readonly name: string
  /**
   * 图片
   */
  readonly image: string
  /**
   * 价格，单位元
   */
  readonly price: number
}