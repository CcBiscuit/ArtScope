import router from '@ohos.router'
import tab from 'ets/components/tab'
import hilog from '@ohos.hilog'

const TAG: string = '[CommentsPage]'
const DOMAIN: number = 0x0000

interface CommentDetail {
  images: ResourceStr[]
  title: string
  content: string
  rating: number
  date: string
}

@Entry
@Component
struct CommentsPage {
  @State currentIndex: number = 0
  private swiperController: SwiperController = new SwiperController()
  
  @State commentDetail: CommentDetail = {
    images: [$r('app.media.dnacover')],
    title: '',
    content: '',
    rating: 0,
    date: ''
  }

  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'CommentsPage aboutToAppear')
    const params = router.getParams() as CommentDetail
    if (params) {
      this.commentDetail = params
      hilog.info(DOMAIN, TAG, 'Received comment detail: %{public}s', JSON.stringify(params))
    }
  }

  aboutToDisappear() {
    hilog.info(DOMAIN, TAG, 'CommentsPage aboutToDisappear')
  }

  onPageShow() {
    hilog.info(DOMAIN, TAG, 'CommentsPage onPageShow')
  }

  onPageHide() {
    hilog.info(DOMAIN, TAG, 'CommentsPage onPageHide')
  }

  onBackPress() {
    hilog.info(DOMAIN, TAG, 'CommentsPage onBackPress')
    router.back()
    return true
  }

  build() {
    Stack() {
      Column() {
        // 返回按钮和标题
        Row() {
          Image($r('app.media.det_back'))
            .width(35)
            .height(57)
            .margin({ left: 32 })
            .onClick(() => {
              router.back()
            })
          
          Text('演出评论')
            .fontSize(84)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 32 })
        }
        .width('100%')
        .margin({ top: 100 })
        .alignItems(VerticalAlign.Center)
        
        // 图片轮播
        Row() {
          Image($r('app.media.det_back'))
            .width(35)
            .height(57)
            .onClick(() => {
              this.swiperController.showPrevious()
            })
          
          Swiper(this.swiperController) {
            ForEach(this.commentDetail.images, (image: ResourceStr) => {
              Image(image)
                .width('100%')
                .height('100%')
                .borderRadius(50)
                .backgroundColor('#F5F5F5')
            })
          }
          .width('80%')
          .aspectRatio(0.75)
          .loop(true)
          .onChange((index: number) => {
            this.currentIndex = index
          })
          .indicator(true)
          
          Image($r('app.media.det_rightarrow'))
            .width(40)
            .height(40)
            .onClick(() => {
              this.swiperController.showNext()
            })
        }
        .margin({ top: 50 })
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
      }
      .height('100%')
      .zIndex(1)

      // 评论内容区域
      Column() {
        Column() {
          Row() {
            Divider()
              .width(174)
              .height(10)
              .borderRadius(25)
              .backgroundColor('#e2e2e2')
              .margin({ top: 50 })
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          // 评论标题
          Text(this.commentDetail.title)
            .fontSize(64)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 40, left: 32 })

          // 评分
          Row() {
            ForEach([1, 2, 3, 4, 5], (star: number) => {
              Image(star <= this.commentDetail.rating ? $r('app.media.Star_filled') : $r('app.media.Star'))
                .width(40)
                .height(40)
                .margin({ right: 10 })
            })
          }
          .margin({ top: 20, left: 32 })

          // 日期
          Text(this.commentDetail.date)
            .fontSize(32)
            .fontColor('#999999')
            .margin({ top: 20, left: 32 })

          // 评论内容
          Text(this.commentDetail.content)
            .fontSize(48)
            .fontColor(Color.Black)
            .margin({ top: 40, left: 32, right: 32 })
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .height('40%')
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .position({ y: '60%' })
      .zIndex(2)

      tab()
        .position({ x: 0, y: '95%' })
        .zIndex(100)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#e2e2e2')
  }
}
