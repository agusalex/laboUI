extends Node

# Traté de hacer con 'match' pero la basura esa no sirve
func get_measurement_unit(aggregation_state):
	var unit = ""
	
	if aggregation_state == Aggregation_States.AggregationStates.SOLID:
		unit = "gr"
	if aggregation_state == Aggregation_States.AggregationStates.LIQUID:
		unit = "ml"
	if aggregation_state == Aggregation_States.AggregationStates.GAS:
		unit = "cm3"
	if aggregation_state == Aggregation_States.AggregationStates.PLASMA:
		unit = "cm3"
	
	return unit