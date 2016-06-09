FSM = {}

class FSM.Machine

    # A finite state machine.
    #
    # NOTE: Always set the initial state (using the `setInitialState` method
    # before calling the `process` method.

    constructor: (@context) ->
        @_stateTransitions = {}
        @_stateTransitionsAny = {}
        @_defaultTransition = null
        @_initialState = null
        @_currentState = null

    addTransition: (action, state, nextState, callback) ->
        # Add a transition for a state

        unless nextState
            nextState = state

        @_stateTransitions[[action, state]] = [nextState, callback]

    addTransitions: (actions, state, nextState, callback) ->
        # Add multiple transitions for a state

        unless nextState
            nextState = state

        for action in actions
            @addTransition(action, state, nextState, callback)

    addTransitionAny: (state, nextState, callback) ->
        # Add a default transition for a state

        unless nextState
            nextState = state

        @_stateTransitionsAny[state] = [nextState, callback]

    setDefaultTransition: (state, callback) ->
        # Set the default transition
        @_defaultTransition = [state, callback]

    getTransition: (action, state) ->
        # Return the transition for the specified action and state

        if @_stateTransitions[[action, state]]
            return @_stateTransitions[[action, state]]

        else if @_stateTransitionsAny[state]
            return @_stateTransitionsAny[state]

        else if @_defaultTransition
            return this._defaultTransition

        throw new Error("Transition is undefined: (#{action}, #{state})")

    getCurrentState: () ->
        # Return the current state of the machine
        return @_currentState

    setInitialState: (state) ->
        # Set the initial state of for the machine

        @_initialState = state

        unless @_currentState
            @reset()

    reset: () ->
        # Reset the machine to its initial state
        @_currentState = @_initialState

    process: (action) ->
        # Process an action

        result = @getTransition(action, @_currentState)

        # Call any associated callback
        if result[1]
            result[1].call(@context or= @, action)

        # Transition to the next state
        @_currentState = result[0]


# Export the namespace

# Browser (via window)
if typeof window != 'undefined'
    window.FSM = FSM

# Node/Browserify
if typeof module != 'undefined' and module.exports
    exports = module.exports = FSM