import router from '@ohos.router';
import { SearchBox } from '../../widget/SearchBox';


class Card {
  name: string
  image: ResourceStr
  score: number
  price: number
  subsidies: number
  url: string

  constructor(name: string, image: ResourceStr, score: number, price: number, url: string, subsidies?: number) {
    this.name = name
    this.image = image
    this.score = score
    this.price = price
    this.subsidies = subsidies
    this.url = url
  }
}

class Item {
  name: string
  image: ResourceStr
  //页面路径
  url: string

  constructor(name: string, image: ResourceStr, url: string) {
    this.name = name
    this.image = image
    this.url = url
  }
}

@Builder function ItemState(item: Item) {
  Column() {
    Image(item.image).interpolation(ImageInterpolation.High)
      .width(40)
      .onClick(() => {
        //路由页面
        router.pushUrl({
          url: item.url,
          params: { id: 1 }
        },
          router.RouterMode.Single,
          err => {
            if (err) { //路由失败 错误检查
              console.log(`路由失败，errCode:${err.code} errMsg:${err.message}`)
            }
          }
        )
      })
    Text(item.name)
  }.margin(10)

}

@Builder function CardState(card: Card) {
  Column() {
    Image(card.image).interpolation(ImageInterpolation.High)
      .width('100%')

    Row() {
      Text(card.name)
        .textAlign(TextAlign.Start) //zu
        .fontSize(20)
        .fontWeight(FontWeight.Regular)

    }
    .width('100%')
    .margin({ left: 5, top: 2, bottom: 10 })


    Column() {
      if (card.subsidies) {
        Text('原价：￥' + card.price).decoration({
          type: TextDecorationType.LineThrough,
          color: Color.Red
        })
          .fontSize(15)
          .fontColor('#696969')

        Row() {
          Text('折扣价：￥' + (card.price - card.subsidies))
            .fontSize(13)
            .fontColor('#DC143C')
        }

        Row() {
          Text('已减至' + (card.price - card.subsidies) / card.price * 10 + '折')
            .fontSize(10)
            .fontColor('#DC143C')
        }

      }
      else {
        Text('￥' + card.price)
          .fontSize(20)
          .fontColor('#DC143C')
      }
    }
    .alignItems(HorizontalAlign.Start) //水平方向 左对齐
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
  .width(160)
  .height('100%')
  .backgroundColor('#fff')
  .borderRadius(20)
  .padding(10)
  .height(240)
  .margin(10)
}


/**
 * 首页
 */
@Entry
@Component
struct HomePage {
  @State message: string = 'Hello World'
  @State MessageNum: number = 1
  @State currentIndex: number = 0
  private barController: TabsController = new TabsController()
  private items: Array<Item> = [
    new Item('外卖', $r('app.media.icon_sandwich'), 'pages/TakeoutPage'),
    new Item('蔬菜水果', $r('app.media.icon_fruit'), 'pages/FruitPage'),
    new Item('药品', $r('app.media.icon_drug'), 'pages/DrugPage'),
    new Item('品质百货', $r('app.media.icon_supermarket'), 'pages/StorePage'),
  ]
  private cards: Array<Card> = [
    new Card('必胜客', $r('app.media.icon'), 9.6, 100, '', 99),
    new Card('必胜客', $r('app.media.icon'), 9.6, 100, ''),
    new Card('必胜客', $r('app.media.icon'), 9.6, 100, '', 76),
    new Card('必胜客', $r('app.media.icon'), 9.6, 100, ''),
    new Card('必胜客', $r('app.media.icon'), 9.6, 100, '')
  ]

  @Builder
  TabBarItem(title: string, icon: Resource, selectedIcon: Resource, index: number) {
    Column() {
      if (title == '消息') {
        Badge({ count: this.MessageNum, position: BadgePosition.RightTop, style: { fontSize: 12 } }) {
          Image(this.currentIndex === index ? selectedIcon : icon).size({ width: 25, height: 25 })
        }
      } else {
        Image(this.currentIndex === index ? selectedIcon : icon).size({ width: 25, height: 25 })
      }
      Text(title).fontColor(this.currentIndex == index ? "#14c145" : Color.Black)

    }
    .width('100%')
    .height(50)
    .onClick(() => {
      this.currentIndex = index
      this.barController.changeIndex(index)
    })
  }

  build() {
    Column() {


      Tabs({ barPosition: BarPosition.End, controller: this.barController }) {
        TabContent() {
          //首页
          Column() {
            Row() {
              Text('xx：')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)

            }
            .justifyContent(FlexAlign.Start)
            .margin({ top: 5, left: 5 })
            .width('100%')

            SearchBox()

              .width('100%')
            Column() {
              Row() {
                Text('外卖专区')
              }

              Row({ space: 10 }) {
                List({ space: 10 }) {
                  ForEach(
                    this.items, //要遍历的数组
                    (item: Item) => {
                      ListItem() {
                        ItemState(item)
                      }
                    }
                  )
                }
                .listDirection(Axis.Horizontal)
                .width('100%')
              }

            }
            .justifyContent(FlexAlign.Start)
            .height(100)
            .width('90%')
            .backgroundColor(Color.White)
            .border({ radius: 20 })

            Swiper() { //轮播
              Image($r('app.media.icon'))
              Image($r('app.media.icon'))
              Image($r('app.media.icon'))
            }
            .loop(true)
            .autoPlay(true)
            .interval(4000)
            .indicatorStyle({
              size: 30,
              right: 0,
              color: Color.White
            })
            .width('100%')
            .height('30%')
            //
            Row() {
              Grid() {
                ForEach(
                  this.cards, //遍历卡片数组
                  (card: Card) => {
                    GridItem() {
                      CardState(card)

                    }
                  }
                )
              }
              .columnsTemplate('1fr 1fr')

            }
            .backgroundColor("#d3d3d3")
            .height('100%')
            .width('100%')
            .margin({ top: 10 })
            .layoutWeight(1) //弹性布局 剩余位置都给我


          }
          .width('100%')
          .backgroundColor(0xffffe0)
          .height('100%')
        }
        .tabBar(this.TabBarItem("外卖", $r("app.media.iconmonstr_home"), $r("app.media.slected_home"), 0))

        TabContent() {
          //消息
          Column() {

          }
        }
        .tabBar(this.TabBarItem("消息", $r("app.media.message"), $r("app.media.slected_message"), 1))

        TabContent() {
          //我的
          Column() {
            Text('个人中心').fontSize(30)
              .alignSelf(ItemAlign.Center)
              .margin({ top: 20, bottom: 40 })
            Row() {
              //用户头像和姓名
            }

            Row() {
              //购物车
            }

            Row() {
              Column() {
                Text('订单')
                  .fontSize(20)
                  .margin({ top: 10, left: 5, bottom: 5 })
                //采用list罗列出历史订单
              }
            }.width('100%')
            .backgroundColor(Color.White)
            .border({ radius: 15 })

          }
          .backgroundColor('#DCDCDC')
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBarItem("我的", $r("app.media.smile"), $r("app.media.slected_smile"), 2))
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
