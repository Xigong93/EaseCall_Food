import httpRequest, { formatImgUrl, HttpResult } from '../../net/HttpRequest'
import Food from './Food'

/**
 * 各种接口
 */
class FoodApi {
  async searchFood(keyword: string): Promise<Array<Food>> {
    const foods = await this.getFoods()
    return foods.filter((f) => f.name.includes(keyword))
  }

  async getFoods(): Promise<Array<Food>> {
    const result: HttpResult<Array<FoodResp>> = await httpRequest.post("web/app/getFoodList.do")
    const origin = result.data ?? []
    const foods = origin.map(createFood)
    return foods
  }

  async getFoodsByType(type: string): Promise<Array<Food>> {
    const foods = await this.getFoods()
    return foods.filter((f: Food) => f.type == type)
  }
}


export class FoodResp {
  readonly foodId: number
  readonly foodName: string
  // 类型
  readonly foodType: string
  // 图片
  readonly photoPath: string
  // 价格
  readonly price: number
}

export function createFood(food: FoodResp): Food {
  return {
    id: food.foodId,
    name: food.foodName,
    price: food.price,
    image: formatImgUrl(food.photoPath),
    type: food.foodType
  }
}

const foodApi = new FoodApi()

export default foodApi