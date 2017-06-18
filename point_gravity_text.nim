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
    force = G * ((a.m * b.m) / (a.p <-> b.p))
    x_a: float = cos(force) * (if a.p.x > a.p.x: 1 else: -1)
    y_a: float = sin(force) * (if a.p.y > a.p.y: 1 else: -1)

  # if force == inf: return (x: 0, y: 0)
  echo((x: x_a, y: y_a))
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
  ship: Object = ((x: 5.0, y:5.0), (x: 0.0, y:0.0), (x: 0.0, y:0.0), 1.0)

echo ship
while true:
  ship.a = ship.a + gravity(ship, planet)
  ship = update_object(ship)
  echo ship
  discard readline(stdin)