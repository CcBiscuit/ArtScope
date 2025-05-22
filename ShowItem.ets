// 展示项目接口定义
export interface ShowItem {
  id: string
  title: string
  image: ResourceStr
  date: string
  location: string
  price: string
  isLiked?: boolean
}

// 模拟数据
export const MOCK_SHOWS: ShowItem[] = [
  {
    id: '1',
    title: '演出1',
    image: $r('app.media.dnacover'),
    date: '2024-03-20',
    location: '福建大剧院',
    price: '280',
    isLiked: false
  },
  {
    id: '2',
    title: '演出2',
    image: $r('app.media.dnacover'),
    date: '2024-03-25',
    location: '福建大剧院',
    price: '380',
    isLiked: false
  }
] 