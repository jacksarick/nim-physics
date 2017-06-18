include math

###########
# General #
###########

# Constants
var G: float = 1.0

# Squaring
proc sqr(a: float): float =
  return a * a

###########
# Vectors #
###########

# Define a vector
type Vector = tuple[x: float, y: float]

# Adding vectors
proc `+`(a: Vector, b: Vector): Vector =
  return (x: a.x + b.x, y: a.y + b.y)

# Distance between vectors
proc `<->`(a: Vector, b: Vector): float =
  return sqrt((sqr(a.x - b.x)) + (sqr(a.y - b.y)))

#########
# World #
#########

# Defining an object
## They have position, velocity, acceleration, and mass
type Object = tuple[p: Vector, v: Vector, a: Vector, m: float]

proc gravity(a, b: Object): Vector =
  let
    force: float = G * ((a.m * b.m) / (a.p <-> b.p))
    𝜽: float = arctan2(b.p.y - a.p.y, b.p.x - a.p.x)
    x_a: float = force * cos(𝜽)
    y_a: float = force * sin(𝜽)

  if force == Inf: return (x: 0.0, y: 0.0)
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
  planet: Object = ((x: 0.0, y:0.0), (x: 0.0, y:0.0), (x: 0.0, y:0.0), 10.0)
  ship: Object = ((x: 100.0, y:50.0), (x: 0.0, y:0.0), (x: 0.0, y:0.0), 1.0)

while true:
  ship.a = ship.a + gravity(ship, planet)
  # echo ship
  echo(ship.a)
  echo((planet.p.y - ship.p.y, planet.p.x - ship.p.x))
  echo "\n"
  ship = update_object(ship)
  discard readline(stdin)