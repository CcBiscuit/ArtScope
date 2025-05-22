import { ShowItem, MOCK_SHOWS } from './ShowItem'
import { eventBus } from './EventBus'

class ShowService {
  private shows: ShowItem[] = MOCK_SHOWS
  private likedShows: Set<string> = new Set()
  private searchResults: ShowItem[] = []

  // 获取所有展示项目
  getAllShows(): ShowItem[] {
    return this.shows
  }

  // 获取收藏的展示项目
  getLikedShows(): ShowItem[] {
    return this.shows.filter(show => this.likedShows.has(show.id))
  }

  // 切换收藏状态
  toggleLike(showId: string): boolean {
    if (this.likedShows.has(showId)) {
      this.likedShows.delete(showId)
      return false
    } else {
      this.likedShows.add(showId)
      return true
    }
  }

  // 检查是否已收藏
  isLiked(showId: string): boolean {
    return this.likedShows.has(showId)
  }

  // 搜索展示项目
  searchShows(keyword: string): ShowItem[] {
    if (!keyword) {
      this.searchResults = []
      return []
    }
    this.searchResults = this.shows.filter(show => 
      show.title.toLowerCase().includes(keyword.toLowerCase()) ||
      show.location.toLowerCase().includes(keyword.toLowerCase())
    )
    return this.searchResults
  }

  // 获取搜索结果
  getSearchResults(): ShowItem[] {
    return this.searchResults
  }

  // 根据ID获取展示项目
  getShowById(id: string): ShowItem | undefined {
    return this.shows.find(show => show.id === id)
  }
}

export const showService = new ShowService() 