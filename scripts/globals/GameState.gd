extends Node

enum State{
	LOGIN,REGISTER,PROFILE_FIRST_RUN,PROFILE,PLAYING
}
var currentState
func getState():
	return currentState
func setState(state):
	currentState = state