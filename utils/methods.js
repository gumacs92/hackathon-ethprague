
export function normalizeContractOutput (input) {
  if (input instanceof Array) {
    return input.map(i => normalize(i))
  }
  return normalize(input)
}

function normalize (input) {
  const normalized = {}
  Object.getOwnPropertyNames(input).forEach((key) => {
    if (isNaN(key)) {
      if (input[key] instanceof Object && !(input[key] instanceof Array)) {
        normalized[key] = parseInt(input[key]._hex, 16)
      } else {
        normalized[key] = input[key]
      }
    }
  })
  return normalized
}
