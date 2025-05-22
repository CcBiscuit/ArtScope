@Component
export struct EntryDealPage {
  onBack?: () => void

  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.det_back'))
          .width(34)
          .height(55)
          .margin({ left: 32 })
          .onClick(() => {
            if (this.onBack) {
              this.onBack()
            }
          })
        Text('订单')
          .fontSize(84)
          .fontWeight(FontWeight.Medium)
          .margin({ left: '40%' })
      }
      .margin({ top: 229})
      .width('100%')
      .height(128)
      
      // 暂不显示订单列表
      Text('没有更多了')
        .fontSize(48)
        .fontColor('#999999')
        .margin({ top: 200 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 