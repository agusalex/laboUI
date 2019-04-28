extends Node

# Traté de hacer con 'match' pero la basura esa no sirve
func get_measurement_unit(aggregation_state):
	var unit = ""
	
	if aggregation_state == Aggregation_States.SOLID:
		unit = "gr"
	if aggregation_state == Aggregation_States.LIQUID:
		unit = "ml"
	if aggregation_state == Aggregation_States.GAS:
		unit = "cm3"
	if aggregation_state == Aggregation_States.PLASMA:
		unit = "cm3"
	
	return unit