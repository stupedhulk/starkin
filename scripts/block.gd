extends StaticBody3D

@onready var mesh_instance = get_child(0)

func color(color):
	mesh_instance = get_child(0)
	mesh_instance.set_material_override(mesh_instance.material_override.duplicate())
	mesh_instance.material_override.albedo_color = color

func create(cull):
	var mesh = Mesh.new()
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	if !cull['Y+']:
		var a = Vector3(-.5,.5,.5)
		var b = Vector3(.5,.5,-.5)
		var c = Vector3(.5,.5,.5)
		var d = Vector3(-.5,.5,-.5)
		st.add_triangle_fan(([a,b,c]))
		st.add_triangle_fan(([b,a,d]))
		
	if !cull['Y-']:
		var a = Vector3(-.5,-.5,.5)
		var b = Vector3(.5,-.5,-.5)
		var c = Vector3(.5,-.5,.5)
		var d = Vector3(-.5,-.5,-.5)
		st.add_triangle_fan(([b,a,c]))
		st.add_triangle_fan(([a,b,d])) 
		
	if !cull['X+']:
		var a = Vector3(.5,.5,-.5)
		var b = Vector3(.5,-.5,.5)
		var c = Vector3(.5,.5,.5)
		var d = Vector3(.5,-.5,-.5)
		st.add_triangle_fan(([a,b,c]))
		st.add_triangle_fan(([b,a,d]))
		
	if !cull['X-']:
		var a = Vector3(-.5,.5,-.5)
		var b = Vector3(-.5,-.5,.5)
		var c = Vector3(-.5,.5,.5)
		var d = Vector3(-.5,-.5,-.5)
		st.add_triangle_fan(([b,a,c]))
		st.add_triangle_fan(([a,b,d])) 
		
	if !cull['Z+']:
		var a = Vector3(.5,-.5,.5)
		var b = Vector3(-.5,.5,.5)
		var c = Vector3(.5,.5,.5)
		var d = Vector3(-.5,-.5,.5)
		st.add_triangle_fan(([a,b,c]))
		st.add_triangle_fan(([b,a,d]))
		
	if !cull['Z-']:
		var a = Vector3(.5,-.5,-.5)
		var b = Vector3(-.5,.5,-.5)
		var c = Vector3(.5,.5,-.5)
		var d = Vector3(-.5,-.5,-.5)
		st.add_triangle_fan(([b,a,c]))
		st.add_triangle_fan(([a,b,d])) 
	
	st.commit(mesh)
	$MeshInstance3D.set_mesh(mesh)
	
	
	#if cull['X+']: 
