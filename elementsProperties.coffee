UP = -0.8
DOWN = 0.8

elements =
  "Void":
    rgb: [0,0,0]
    density: 0
    nextToThese: ["Torch", "WaterFountain", "OilFountain"]
    becomesRespectivelyThis: ["Fire", "Water", "Oil"]
    withRespectiveProbs: [1, 1, 1]
  "Wall":
    tags: ["solid"]
    rgb: [200,200,200]
    density: 1
  "Fire":
    tags: ["flammable"]
    rgb: [255,0,0]
    density: 0.01
    verticalMoveProb: UP
    horizontalMoveProb: 0.25
    transmutatesTo: "Void"
    transmutationProb: 0.1
    nextToThese: ["Water", "Steam"]
    becomesRespectivelyThis: ["Void", "Void"]
    withRespectiveProbs: [1, 1]
  "Water":
    tags: ["liquid"]
    rgb: [0,0,255]
    density: 0.5
    verticalMoveProb: DOWN
    horizontalMoveProb: 0.5
    nextToThese: ["Plant","Fire"]
    becomesRespectivelyThis: ["Plant","Steam"]
    withRespectiveProbs: [0.01,1]
  "Steam":
    tags: ["gas"]
    rgb: [150,100,255]
    density: 0.3
    verticalMoveProb: UP
    horizontalMoveProb: 0.25
    transmutatesTo: "Water"
    transmutationProb: 0.01
  "Plant":
    tags: ["solid"]
    rgb: [0,255,0]
    density: 1
    nextToThese: ["Fire"]
    becomesRespectivelyThis: ["Fire"]
    withRespectiveProbs: [1]
  "Oil":
    tags: ["liquid","flammable"]
    rgb: [150,98,0]
    density: 0.4
    verticalMoveProb: DOWN
    horizontalMoveProb: 0.5
    nextToThese: ["Fire"]
    becomesRespectivelyThis: ["Fire"]
    withRespectiveProbs: [1]
  "Torch":
    tags: ["flammable"]
    rgb: [100,100,0]
    density: 1
  "WaterFountain":
    tags: ["liquid"]
    rgb: [0,0,150]
    density: 1
  "OilFountain":
    tags: ["liquid","flammable"]
    rgb: [200,100,50]
    density: 1
  "Fuse":
    tags: ["flammable", "solid"]
    rgb: [255,0,0]
    density: 1
    nextToThese: ["BurntFuse", "Fire"]
    becomesRespectivelyThis: ["BurntFuse", "BurntFuse"]
    withRespectiveProbs: [1, 1]
  "BurntFuse":
    tags: ["solid"]
    rgb: [120,40,0]
    density: 1
