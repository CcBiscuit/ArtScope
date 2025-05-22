import { ShowItem } from '../common/constants/ShowItem'
import { PerformerInfo } from '../pages/detailpage'
import { showService } from '../common/constants/ShowService'

@Component
export struct EntryDetailPage {
  @State currentShow: ShowItem | undefined = undefined
  @State isLiked: boolean = false
  @State showId: string = ''
  @State performers: PerformerInfo[] = [
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
    { name: '名称', image: $r('app.media.dnacover') },
  ]
  onBack?: () => void

  aboutToAppear() {
    if (this.showId) {
      this.currentShow = showService.getShowById(this.showId)
      this.isLiked = showService.isLiked(this.showId)
    }
  }

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
        .onClick(() => {
          if (this.onBack) {
            this.onBack()
          }
        })

        Button({ type: ButtonType.Circle }) {
          Image(this.isLiked ? $r('app.media.det_fullheart') : $r('app.media.det_emptyheart'))
            .width(54)
            .height(50)
        }
        .width(127)
        .height(127)
        .backgroundColor(Color.White)
        .onClick(() => {
          if (this.currentShow) {
            this.isLiked = showService.toggleLike(this.currentShow.id)
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 75, right: 75 })
      .margin({ top: 170 })

      if (this.currentShow) {
        // 中间的海报图片
        Image(this.currentShow.image)
          .width(669)
          .height(936)
          .objectFit(ImageFit.Cover)
          .margin({ top: 67 })

        // 演出名称和价格
        Column() {
          Text(this.currentShow.title)
            .fontSize(64)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text(`¥${this.currentShow.price}`)
            .fontSize(72)
            .fontColor('#FF0000')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 31 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 90, bottom: 90 })
        .padding({ left: 123 })

        // 底部白色区域
        Column({ space: 48 }) {
          // 时间和提醒
          Row() {
            Text(this.currentShow.date)
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

          // 地点
          Text(this.currentShow.location)
            .fontSize(48)
            .margin({ bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)

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
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 