import Food from '../pages/food/Food'

/**
 * 各种接口
 */
class AppApi {
  getFoods(count = 50): Array<Food> {
    const foods: Array<Food> = []
    for (let i = 0; i < count; i++) {
      foods.push({
        name: "必胜客",
        price: 89,
        image: "a"
      })
    }
    return foods
  }
}

const appApi = new AppApi()

export default appApi