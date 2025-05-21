import router from '@ohos.router'
import tab from 'ets/components/tab'

interface StarRating {
  text: string
  score: number
}

interface ImageItem {
  uri: ResourceStr
}


@Component
export struct RecordPage {
  @State starCount: number = 0
  @State uploadedImages: ImageItem[] = []
  @State comment: string = ''
  private ratingTexts: StarRating[] = [
    { text: '非常差', score: 1 },
    { text: '差', score: 2 },
    { text: '一般', score: 3 },
    { text: '满意', score: 4 },
    { text: '超赞', score: 5 }
  ]

  getRatingText(): string {
    return this.ratingTexts.find(item => item.score === this.starCount)?.text || '非常差'
  }

  build() {
    Column() {
      // 内容区域用 Scroll 包裹，保证可以滚动
      Scroll() {
        Column() {
          // 顶部标题
          Text('记录')
            .fontSize(84)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 29 })
            .width('100%')
            .textAlign(TextAlign.Center)

          // 评分部分
          Column() {
            Text('为演出打分~')
              .fontWeight(FontWeight.Medium)
              .fontSize(58)
              .margin({ top: 66, left: 63 })
              .alignSelf(ItemAlign.Start)

            Row() {
              ForEach([1, 2, 3, 4, 5], (star: number) => {
                Image(star <= this.starCount ? $r('app.media.Star_filled') : $r('app.media.Star'))
                  .width(80)
                  .height(80)
                  .margin({ right: 20, top: 41 })
                  .onClick(() => {
                    this.starCount = star
                  })
              })

              Text(this.getRatingText())
                .fontSize(48)
                .margin({ left: 40, top: 50 })
                .opacity(0.6)
            }
            .margin({ top: 20, left: 63 })
            .alignSelf(ItemAlign.Start)
          }
          .margin({top:85})
          .backgroundColor(Color.White)
          .height(354)
          .width('90%')
          .borderRadius(50)

          // 图片上传区域
          Column() {
            Column() {
              TextArea({ placeholder: '输入你的感想......' })
                .placeholderFont({ size: 58 })
                .backgroundColor(Color.White)
                .height(400)
                .width('90%')
                .margin({ top: 40})
                .alignSelf(ItemAlign.Start)
                .onChange((value: string) => {
                  this.comment = value
                })
            }

            Column() {
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
                // 已上传的图片
                ForEach(this.uploadedImages, (item: ImageItem, index: number) => {
                  Stack() {
                    Image(item.uri)
                      .width(200)
                      .height(200)
                      .objectFit(ImageFit.Cover)

                    Button() {
                      Image($r('app.media.dnacover'))
                        .width(40)
                        .height(40)
                    }
                    .width(40)
                    .height(40)
                    .position({ x: 160, y: 0 })
                    .onClick(() => {
                      this.uploadedImages.splice(index, 1)
                    })
                  }
                  .margin(10)
                })

                // 上传按钮，放在已有图片后面
                if (this.uploadedImages.length < 9) {
                  Button() {
                    Image($r('app.media.upload'))
                      .width('100%')
                      .height('100%')
                  }
                  .width(200)
                  .height(200)
                  .backgroundColor('#F5F5F5')
                  .onClick(() => {
                    // TODO: 处理上传逻辑
                    if (this.uploadedImages.length < 9) {
                      this.uploadedImages.push({ uri: $r('app.media.dnacover') })
                    }
                  })
                }
              }
              .margin({ left: 63, bottom: 63 })
            }
          }
          .padding(30)
          .width('90%')
          .height(1155)
          .backgroundColor(Color.White)
          .borderRadius(50)
          .margin({ top: 52 })

          // 发布按钮
          Row() {
            Button('发布')
              .width('40%')
              .height(120)
              .fontSize(48)
              .fontColor(Color.White)
              .backgroundColor(Color.Black)
              .onClick(() => {
                router.back()
              })
          }
          .width('100%')
          .margin({ top: 40, bottom: 40 })
          .justifyContent(FlexAlign.End)
          .padding({ right: '5%' })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1) // 让内容区域占据除底部导航外的所有空间

      // 底部导航栏
      tab()
        .height(150) // 给tab一个固定高度
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#e2e2e2')
  }
} 