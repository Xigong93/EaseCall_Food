import Food from '../pages/food/Food'

/**
 * 各种接口
 */
class AppApi {
  getSampleFood(): Food {
    return {
      id: 0,
      name: "必胜客",
      price: 89,
      image: "a",
      type: "a"
    }
  }

  getFoods(count = 20): Array<Food> {
    const foods: Array<Food> = []
    for (let i = 0; i < count; i++) {
      foods.push(this.getSampleFood())
    }
    return foods
  }
}

const appApi = new AppApi()

export default appApi