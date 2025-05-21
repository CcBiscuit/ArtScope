import { ShowList } from '../components/profile'
import router from '@ohos.router'
import { PAGES } from '../common/constants'
import hilog from '@ohos.hilog'

const TAG: string = '[MainPage]'
const DOMAIN: number = 0x0000

interface SwiperItem {
  id: number
  image: ResourceStr
}

@Component
export struct MainPage {
  @State searchText: string = ''
  @State currentRegion: string = '福建'
  @State currentIndex: number = 0
  @State swiperList: SwiperItem[] = [
    { id: 1, image: $r('app.media.dnacover') },
    { id: 2, image: $r('app.media.dnacover') },
    { id: 3, image: $r('app.media.dnacover') }
  ]

  build() {
    Column() {
      Row() {
        Row() {
          Text(this.currentRegion)
            .fontSize(48)
            .fontColor(Color.Black)
          Image($r('app.media.arrow_down'))
            .width(14)
            .height(7)
            .margin({ left: 12 })
        }
        .margin({ left: 60 })
        .onClick(() => {
          // TODO: 实现区域选择弹窗
        })

        // 搜索框
        Row() {
          Image($r('app.media.pro_search'))
            .width(52)
            .height(53)
            .margin({ right: 8, left: 30 })
        }
        .width(901)
        .height(112)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#ffffffff')
        .borderRadius(55)
        .margin({ left: 75 })
        .onClick(() => {
          router.pushUrl({
            url: PAGES.SEARCH
          }).then(() => {
            hilog.info(DOMAIN, TAG, 'Navigation to search page successful')
          }).catch((err: Error) => {
            hilog.error(DOMAIN, TAG, 'Navigation failed: %{public}s', err.message)
          })
        })
      }
      .width('100%')
      .margin({
        left: 16,
        right: 16,
        top: 139,
        bottom: 91
      })

      // 轮播图
      Swiper() {
        ForEach(this.swiperList, (item: SwiperItem) => {
          Stack() {
            Image(item.image)
              .width('100%')
              .height('100%')
              .borderRadius(8)
          }
        })
      }
      .backgroundColor('#ffffff')
      .width(1113)
      .height(383)
      .margin({ bottom: 52 })
      .autoPlay(true)
      .interval(5000)
      .indicator(true)
      .padding({ left: 16, right: 16 })

      // 列表区域
      Column() {
        ShowList()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffdbd9d9')
  }
}