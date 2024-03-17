import UIAbility from '@ohos.app.ability.UIAbility'

var uiAbility: UIAbility | null = null

export function installUiAbility(abi: UIAbility) {
  uiAbility = abi
}

export function getUiAbility(): UIAbility {
  return uiAbility
}