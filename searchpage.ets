import { ShowList } from '../components/profile';
import { showService } from '../common/constants/ShowService';
import router from '@ohos.router';
import { ShowItem } from '../common/constants/ShowItem';

@Entry
@Component
struct SearchPage {
  @State keyword: string = '';
  @State searchResults: ShowItem[] = [];

  aboutToAppear() {
    // 初始化时清空搜索结果
    this.searchResults = [];
  }

  build() {
    Column() {
      Row({space:60}) {
        Row() {
          Image($r('app.media.pro_search'))
            .width(52)
            .height(53)
            .margin({ right: 8, left: -20 })
          
          TextInput({ placeholder: '搜索演出...' })
            .width('80%')
            .height(82)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.keyword = value;
              // 实时搜索
              this.searchResults = showService.searchShows(value);
            })
        }
        .width(923)
        .height(82)
        .padding({ left: 78, right: 16 })
        .backgroundColor(Color.White)
        .borderRadius(55)
        .margin({ left: 75, top: 139 })

        Text('取消')
          .fontWeight(FontWeight.Medium)
          .fontSize(48)
          .margin({top:139})
          .onClick(() => {
            router.back();
          })
      }

      if (this.searchResults.length > 0) {
        ShowList({ shows: this.searchResults })
          .margin({top:80})
      } else {
        if (this.keyword) {
          Text('未找到相关演出')
            .fontSize(48)
            .fontColor('#999999')
            .margin({top:200})
        }
      }
    }
    .backgroundColor('#e2e2e2')
    .height('100%')
    .width('100%')
  }
}