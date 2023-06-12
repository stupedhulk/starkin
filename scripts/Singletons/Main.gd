extends Node






#round_vector
const FLOOR = 0
const CEIL = 1
const ROUND = 2

func round_vector(Vector, operation):
	if typeof(Vector) == TYPE_VECTOR3:
		if operation == 0:
			return Vector3(floor(Vector.x), floor(Vector.y), floor(Vector.z))
		elif operation == 1:
			return Vector3(ceil(Vector.x), ceil(Vector.y), ceil(Vector.z))
		elif operation == 2:
			return Vector3(round(Vector.x), round(Vector.y), round(Vector.z))
			
	elif typeof(Vector) == TYPE_VECTOR2:
		if operation == 0:
			return Vector2(floor(Vector.x), floor(Vector.y))
		elif operation ==1:
			return Vector2(ceil(Vector.x), ceil(Vector.y))
		elif operation == 2:
			return Vector2(round(Vector.x), round(Vector.y))


func always_positive(value):
	var output = value
	if typeof(value) == TYPE_INT or typeof(value) == TYPE_FLOAT:
		if value < 0:
			value *= -1
		output = value
	if typeof(value) == TYPE_VECTOR2:
		if value.x < 0:
			value.x *= -1
		if value.y < 0:
			value.y *= -1
		output = value
	if typeof(value) == TYPE_VECTOR3:
		if value.x < 0:
			value.x *= -1
		if value.y < 0:
			value.y *= -1
		if value.z < 0:
			value.z *= -1
		output = value
	if typeof(value) == TYPE_ARRAY:
		output = []
		for x in value:
			output.append(always_positive(x))
	if typeof(value) == TYPE_DICTIONARY:
		output = {}
		for x in value.keys():
			output[x] = always_positive(value[x])
	return output
