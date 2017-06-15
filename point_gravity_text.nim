include math

###########
# General #
###########

# Constants
var G: float = 1.0

# Square root
##Int -> Int isn't standard
proc sqrt(a: int): int = 
  return toInt(sqrt(toFloat(a)))

###########
# Vectors #
###########

# Define a vector
type Vector = tuple[x: int, y: int]

# Adding vectors
proc `+`(a: Vector, b: Vector): Vector =
  return (x: a.x + b.x, y: a.y + b.y)

# Distance between vectors
proc `<->`(a: Vector, b: Vector): int =
  return sqrt(((a.x - b.x) ^ 2) + ((a.y - b.y) ^ 2))

#########
# World #
#########

# Defining an object
## They have position, velocity, acceleration, and mass
type Object = tuple[p: Vector, v: Vector, a: Vector, m: int]

proc gravity(a, b: Object): Vector =
  let
    force = G * ((a.m * b.m) / (a.p <-> b.p))
    x_a: int = toInt(cos(force))
    y_a: int = toInt(sin(force))

  # if force == inf: return (x: 0, y: 0)
  return (x: x_a, y: y_a)

##############
# Simulation #
##############

# Update an object's qualities
proc update_object(obj: Object): Object =
  let
    pos: Vector = (x: obj.p.x + obj.v.x, y: obj.p.y + obj.v.y)
    vel: Vector = (x: obj.v.x + obj.a.x, y: obj.v.y + obj.a.y)
    acc: Vector = (x: obj.a.x, y: obj.a.y)
    new_obj: Object = (p: pos, v: vel, a: acc, m: obj.m)
  return new_obj

###########
# Program #
###########

# Create objects
var
  planet: Object = ((x: 0, y:0), (x: 0, y:0), (x: 0, y:0), 10)
  ship: Object = ((x: 5, y:5), (x: 0, y:0), (x: 0, y:0), 1)

echo ship
while true:
  ship.a = ship.a + gravity(ship, planet)
  ship = update_object(ship)
  echo ship
  discard readline(stdin)