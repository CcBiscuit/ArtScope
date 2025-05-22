import { ShowItem } from '../common/constants/ShowItem'
import { eventBus } from '../common/constants/EventBus'
import { ShowDetailPayload } from '../common/constants/ShowDetailTypes'

@Component
export struct ShowList {
  @State shows: ShowItem[] = []
  onItemClick?: (show: ShowItem) => void

  build() {
    List({ space: 20 }) {
      ForEach(this.shows, (show: ShowItem) => {
        ListItem() {
          Row() {
            Image(show.image)
              .width(200)
              .height(200)
              .borderRadius(10)
            
            Column() {
              Text(show.title)
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
              
              Text(show.date)
                .fontSize(40)
                .margin({ top: 10 })
              
              Text(show.location)
                .fontSize(40)
                .margin({ top: 10 })
              
              Text(`¥${show.price}`)
                .fontSize(40)
                .fontColor(Color.Red)
                .margin({ top: 10 })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 20 })
            .layoutWeight(1)
          }
          .width('100%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(20)
          .onClick(() => {
            if (this.onItemClick) {
              this.onItemClick(show)
            } else {
              // 使用 EventBus 发送通知，以便 EntryPage 可以处理
              const payload: ShowDetailPayload = {
                showId: show.id
              };
              eventBus.emit('SHOW_DETAIL', payload)
            }
          })
        }
      })
    }
    .width('100%')
    .layoutWeight(1)
  }
}