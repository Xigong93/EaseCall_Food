export function delay(mill: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(() => resolve(), mill)
  })
}