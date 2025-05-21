import tab from 'ets/components/tab';

@Component
export struct WalletPage {
  @State currentIndex: number = 0
  private swiperController: SwiperController = new SwiperController()
  private imageList: ResourceStr[] = [
    $r('app.media.dnacover'),
    $r('app.media.dnacover'),
    $r('app.media.dnacover')
  ]

  build() {
    Stack() {
      Column() {
        Text('票夹')
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .fontSize(84)
          .margin({ top: 229})
        
        Row() {
          Image($r('app.media.det_back'))
            .width(35)
            .height(57)
            .onClick(() => {
              this.swiperController.showPrevious()
            })
          
          Swiper(this.swiperController) {
            ForEach(this.imageList, (image: ResourceStr) => {
              Image(image)
                .width(908)
                .height(1406)
                .borderRadius(50)
                .backgroundColor('#F5F5F5')
            })
          }
          .width('80%')
          .aspectRatio(0.75)
          .loop(true)
          .onChange((index: number) => {
            this.currentIndex = index
          })
          .indicator(false)
          
          Image($r('app.media.det_rightarrow'))
            .width(40)
            .height(40)
            .onClick(() => {
              this.swiperController.showNext()
            })
        }
        .margin({top:236})
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
      }
      .height('100%')
      .zIndex(1)

      Column() {
        Column() {
          Row() {
            Divider()
              .width(174)
              .height(10)
              .borderRadius(25)
              .backgroundColor('#e2e2e2')
              .margin({ top: 50})
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          Text('历史票根')
            .fontSize(64)
            .fontColor(Color.Black)
            .margin({ top:79, left: 94 })
            .alignSelf(ItemAlign.Start)

        }
        .width('100%')
        .height('15%')
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .padding({ left: 24, right: 24 })
      }
      .borderRadius(150)
      .width('100%')
      .position({ y: '85%' })
      .zIndex(2)

      tab()
        .position({ x: 0, y: '95%' })
        .zIndex(100)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#e2e2e2')
  }
}
