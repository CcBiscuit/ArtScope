interface PerformerInfo {
  name: string
  image: ResourceStr
}

@Entry
@Component
struct DetailPage {
  @State isLiked: boolean = false
  @State performers: PerformerInfo[] = [
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
  ]

  build() {
    Column() {
      // 顶部返回和收藏按钮
      Row() {
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.det_back'))
            .width(26)
            .height(42)
        }
        .width(127)
        .height(127)
        .backgroundColor(Color.White)

        Button({ type: ButtonType.Circle }) {
          Image(this.isLiked ? $r('app.media.det_fullheart') : $r('app.media.det_emptyheart'))
            .width(54)
            .height(50)
        }
        .width(127)
        .height(127)
        .backgroundColor(Color.White)
        .onClick(() => {
          this.isLiked = !this.isLiked
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 75, right: 75 })
      .margin({ top: 170 })

      // 中间的海报图片
      Image($r('app.media.dnacover'))
        .width(669)
        .height(936)
        .objectFit(ImageFit.Cover)
        .margin({ top: 67 })

      // 演出名称和价格
      Column() {
        Text('演出名称')
          .fontSize(64)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Start)
        
        Text('第二行演出名称')
          .fontSize(64)
          .opacity(0.6)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 8 })

        Text('¥ xxx')
          .fontSize(72)
          .fontColor('#FF0000')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 31 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 90 ,bottom:90})
      .padding({ left: 123})

      // 底部白色区域
      Column({space:48}) {
        // 时间和提醒
        Row() {
          Text('xxxx.xx.xx（演出时间）')
            .fontSize(48)
          
          Row() {
            Text('设置提醒')
              .fontSize(48)
            Image($r('app.media.det_rightarrow'))
              .width(26)
              .height(42)
              .margin({ left: 20 })
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 16, bottom: 16 })

        // 地点和平台
        Column({space:48}) {
          Text('省份 演出地点')
            .fontSize(48)
            .margin({ bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)
          Text('售票平台')
            .fontSize(48)
            .width('100%')
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ bottom: 20 })

        // 底部滚动演员列表
        Text('阵容')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Start)

        Scroll() {
          Row({ space: 158 }) {
            ForEach(this.performers, (item: PerformerInfo) => {
              Column() {
                Image(item.image)
                  .width(240)
                  .height(240)
                  .borderRadius(120)
                
                Text(item.name)
                  .fontSize(46)
                  .margin({ top: 8 })
              }
            })
          }
          .padding({ left: 20, right: 20 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 75, right: 75, top: 50 })
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 20, topRight: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
