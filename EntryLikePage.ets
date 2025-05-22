import { ShowList } from '../components/profile'
import { showService } from '../common/constants/ShowService'
import { ShowItem } from '../common/constants/ShowItem'

@Component
export struct EntryLikePage {
  @State likedShows: ShowItem[] = []
  onBack?: () => void
  onShowDetail?: (showId: string) => void

  aboutToAppear() {
    // 获取收藏的演出列表
    this.likedShows = showService.getLikedShows()
  }

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
        Text('收藏')
          .fontSize(84)
          .fontWeight(FontWeight.Medium)
          .margin({ left: '40%' })
      }
      .margin({ top: 229})
      .width('100%')
      .height(128)

      if (this.likedShows.length > 0) {
        ShowList({ 
          shows: this.likedShows,
          onItemClick: (show: ShowItem) => {
            if (this.onShowDetail) {
              this.onShowDetail(show.id)
            }
          }
        })
        .margin({ top: 69 })
      } else {
        Text('暂无收藏')
          .fontSize(48)
          .fontColor('#999999')
          .margin({ top: 200 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 