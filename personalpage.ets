import router from '@ohos.router'
import tab from 'ets/components/tab'

interface RecordItem {
  image: ResourceStr
  comment: string
  rating: number
  height: number
  date?: string
}

// 修改为使用独立的接口定义
interface NewRecord {
  images: ResourceStr[]
  comment: string
  rating: number
  height: number
  date: string
}

interface RecordParams {
  newRecord: NewRecord
}

const heights: number[] = [220, 300, 380]

@Component
export struct PersonalPage {
  @State records: RecordItem[] = (() => {
    const arr: RecordItem[] = []
    let lastHeightIndex: number = -1
    for (let i = 0; i < 20; i++) {
      // 过滤掉上一个用过的高度
      const available = heights.filter((_, idx) => idx !== lastHeightIndex)
      const idx = Math.floor(Math.random() * available.length)
      const height = available[idx]
      lastHeightIndex = heights.indexOf(height)
      arr.push({
        image: $r('app.media.dnacover'),
        comment: `演出记录${i + 1}`,
        rating: Math.floor(Math.random() * 3) + 3,
        height
      })
    }
    return arr
  })()

  newRecord?: RecordItem
  onPublish?: () => void
  onNavigateToLike?: () => void
  onNavigateToDeal?: () => void

  aboutToAppear() {
    // 检查是否有新的记录数据
    if (this.newRecord) {
      this.records.unshift(this.newRecord)
    }
  }

  build() {
    Column() {
      // 用户信息
      Row() {
        Image($r('app.media.dnacover'))
          .width(175)
          .height(175)
          .borderRadius(64)
          .margin({ left: 32 })

        Text('用户名')
          .fontColor(Color.Black)
          .fontSize(64)
          .margin({ left: 64 })
      }
      .width('85%')
      .margin({ top: 231 })

      // 订单和收藏
      Column() {
        Column() {
          Text('我的订单')
            .fontSize(40)
            .fontColor(Color.Black)
            .onClick(() => {
              if (this.onNavigateToDeal) {
                this.onNavigateToDeal()
              }
            })
            .margin(40)
        }
        .width('100%')
        .layoutWeight(1)

        Divider()
          .width('90%')
          .color('#E2E2E2')

        Column({space:64}) {
          Text('我的收藏')
            .fontSize(40)
            .fontColor(Color.Black)
            .onClick(() => {
              if (this.onNavigateToLike) {
                this.onNavigateToLike()
              }
            })
            .margin(40)
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('90%')
      .height(299)
      .margin({ top: 69 })
      .backgroundColor(Color.White)
      .borderRadius(40)

      // 观演记录容器
      Column() {
        // 观演记录标题和发布按钮
        Row() {
          Text('我的观演记录')
            .fontSize(64)
            .fontColor(Color.Black)
            .margin({top:35,left:73})

          Button('去发布 >')
            .fontSize(48)
            .fontColor(Color.White)
            .backgroundColor(Color.Black)
            .width(394)
            .height(126)
            .borderRadius(28)
            .onClick(() => {
              if (this.onPublish) {
                this.onPublish()
              }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ top: 47, bottom: 32, left: 32, right: 32 })

        // 瀑布流展示记录
        Stack() {
          WaterFlow() {
            ForEach(this.records, (item: RecordItem) => {
              FlowItem() {
                Column() {
                  Image(item.image)
                    .width('100%')
                    .height('100%')
                    .aspectRatio(1)
                    .borderRadius(16)
                }
                .height(item.height)
                .padding(38)
                .backgroundColor(Color.White)
                .borderRadius(16)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .itemConstraintSize({
            minWidth: 0,
            maxWidth: '100%',
            minHeight: 200,
            maxHeight: 300
          })
          .padding({ left: 32, right: 32 })
        }
      }
      .width('90%')
      .margin({ top: 32 })
      .backgroundColor(Color.White)
      .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 