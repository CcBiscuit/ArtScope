import hilog from '@ohos.hilog'
import { TabItem } from '../common/constants'

const TAG: string = '[TabBar]'
const DOMAIN: number = 0x0000
const TAB_BAR_HEIGHT: number = 147
const TAB_ITEM_WIDTH: number = 120
const TAB_ICON_SIZE: number = 54

@Component
export struct TabBar {
  @Link currentIndex: number
  private tabItems: TabItem[] = []

  build() {
    Row({ space: 0 }) {
      ForEach(this.tabItems, (item: TabItem, index: number) => {
        Column() {
          Image(this.currentIndex === index ? item.activeIcon : item.normalIcon)
            .height(TAB_ICON_SIZE)
            .width(TAB_ICON_SIZE)
            .objectFit(ImageFit.Contain)
        }
        .width(TAB_ITEM_WIDTH)
        .height(TAB_BAR_HEIGHT)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          if (this.currentIndex !== index) {
            this.currentIndex = index
            hilog.info(DOMAIN, TAG, 'Tab changed to: %{public}d', index)
          }
        })
      }, (item: TabItem) => JSON.stringify(item))
    }
    .borderRadius(TAB_BAR_HEIGHT / 2)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceAround)
    .backgroundColor(Color.White)
    .height(TAB_BAR_HEIGHT)
    .width('100%')
    .shadow({
      radius: 20,
      color: '#1F000000',
      offsetX: 2,
      offsetY: 4
    })
    .expandSafeArea()
  }
} 