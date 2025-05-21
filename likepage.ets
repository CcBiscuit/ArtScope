import { ShowList } from '../components/profile'
import router from '@ohos.router'

@Entry
@Component
struct LikePage {
  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.det_back'))
          .width(34)
          .height(55)
          .margin({ left: 32 })
          .onClick(() => {
            router.back()
          })
        Text('收藏')
          .fontSize(84)
          .fontWeight(FontWeight.Medium)
          .margin({ left: '40%' })
      }
      .margin({ top: 229})
      .width('100%')
      .height(128)

      ShowList()
        .margin({ top: 69 })
      
      Text('没有更多了')
        .fontSize(48)
        .fontColor('#999999')
        .margin({ top:86 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 