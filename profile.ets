import router from '@ohos.router'

interface ShowItem {
  id?: string
  name: string
  time: string
  price: string
  place: string
  platform: string
}

@Component
export struct ShowList {
  @State showList: ShowItem[] = [
    {
      id: '1',
      name: '演出名称',
      time: '时间',
      price: '¥xxx',
      platform: '售票平台',
      place: '演出地点'
    },
    {
      id: '2',
      name: '演出名称',
      time: '时间',
      price: '¥xxx',
      platform: '售票平台',
      place: '演出地点'
    },
    {
      name: '演出名称',
      time: '时间',
      price: '¥xxx',
      platform: '售票平台',
      place: '演出地点'
    },
    {
      name: '演出名称',
      time: '时间',
      price: '¥xxx',
      platform: '售票平台',
      place: '演出地点'
    },
    {
      name: '演出名称',
      time: '时间',
      price: '¥xxx',
      platform: '售票平台',
      place: '演出地点'
    },
    {
      name: '演出名称',
      time: '时间',
      price: '¥xxx',
      platform: '售票平台',
      place: '演出地点'
    }
  ]

  @Builder
  ShowItem(item: ShowItem) {
    Row() {
      Image($r('app.media.dnacover'))
        .width(260)
        .height(364)
        .borderRadius(8)
        .margin({ right: 48 })

      Column() {
        Text(item.name)
          .fontSize(44)
          .margin({ left: 8 })
        Text()
          .height(53)
          .width(1)
        Text(item.time)
          .fontColor('#505050')
          .fontSize(32)
          .margin({ left: 8})
        Text(item.platform)
          .fontColor('#505050')
          .fontSize(32)
          .margin({ left: 8 })
        Text(item.place)
          .fontColor('#505050')
          .fontSize(32)
          .margin({ left: 8 })
      }
      Text(item.price)
        .fontSize(64)
        .fontWeight(FontWeight.Medium)
        .margin({ left:450 ,top:325})
        .fontColor('#d14929')
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({left:77,top:48,bottom:48})
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 12 })
    .onClick(() => {
      if (item.id) {
        router.pushUrl({
          url: 'pages/detailpage',
          params: { id: item.id }
        })
      }
    })
  }

  build() {
    Scroll() {
      Column() {
        ForEach(this.showList, (item: ShowItem) => {
          this.ShowItem(item)
        })
      }
    }
    .scrollBar(BarState.Off)
  }
}