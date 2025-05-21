import { ShowList } from '../components/profile';

@Entry
@Component
struct SearchPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Row({space:60}) {
        Row() {
          Image($r('app.media.pro_search'))
            .width(52)
            .height(53)
            .margin({ right: 8, left: -20 })
        }
        .width(923)
        .height(82)
        .padding({ left: 78, right: 16 })
        .backgroundColor('#ffffffff')
        .borderRadius(55)
        .margin({ left: 75, top: 139 })
        Text('取消')
          .fontWeight(FontWeight.Medium)
          .fontSize(48)
          .margin({top:139})
      }
      ShowList()
        .margin({top:80})
      Text('没有更多了')
        .opacity(0.5)
        .fontSize(48)
        .fontWeight(FontWeight.Medium)
        .margin({top:1000})
    }
    .backgroundColor('#e2e2e2')
    .height('100%')
    .width('100%')
  }
}