include math

proc sqrt(a: int): int = 
  return toInt(sqrt(toFloat(a)))

# Vectors
## Define a vector
type Vector = tuple[x: int, y: int]

## Adding vectors
proc `+`(a: Vector, b: Vector): Vector =
  return (x: a.x + b.x, y: a.y + b.y)

## Distance between vectors
proc `<->`(a: Vector, b: Vector): int =
  return sqrt(((a.x - b.x) ^ 2) + ((a.y - b.y) ^ 2))

type Object = tuple[p: Vector, v: Vector, a: Vector]

var
  a: Vector = (x: 0, y:0)
  b: Vector = (x: 1, y:1)

echo a <-> b 

proc update_object(obj: Object): Object =
  let
    pos: Vector = (x: obj.p.x + obj.v.x, y: obj.p.y + obj.v.y)
    vel: Vector = (x: obj.v.x + obj.a.x, y: obj.v.y + obj.a.y)
    acc: Vector = (x: obj.a.x, y: obj.a.y)
    new_obj: Object = (p: pos, v: vel, a: acc)
  return new_obj