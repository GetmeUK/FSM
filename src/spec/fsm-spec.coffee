describe 'My pet dragon called Burt', () ->

    burt = {}
    sounds = {}
    beforeEach ->

        # Build a finite state machine for our pet dragon Burt
        burt = new FSM.Machine()

        # Define some callbacks that burt might make for different states
        sounds =
            growl: () ->
                console.log('Grrr')

            roar: () ->
                console.log('Roar')

            snore: () ->
                console.log('Zzzz')

        # By default any action will inrage burt
        burt.setDefaultTransition 'enraged', () ->
            sounds.roar()
        spyOn(sounds, 'roar')

        # If Burt is sleeping then any action will wake him (he's always
        # grumpy when he wakes up).
        burt.addTransitionAny 'sleeping', 'grumpy', () ->
            sounds.growl()

        spyOn(sounds, 'growl')

        # Various things will sooth Burt when he's gumpy
        burt.addTransition('stroke', 'grumpy', 'content')
        burt.addTransition('feed', 'grumpy', 'content')

        # The only way to get Burt back to sleep is by singing to him
        burt.addTransition 'sing-to', 'content', 'sleeping', () ->
            sounds.snore()#

        spyOn(sounds, 'snore')

        # Burt is sleeping
        burt.setInitialState('sleeping')

    it 'should growl when he wakes (as he will be grumpy)', () ->
        burt.process('call')
        expect(burt.getCurrentState()).toBe 'grumpy'
        expect(sounds.growl).toHaveBeenCalled()

    it 'should enrage if you kick him when awake', () ->
        burt.process('call')
        burt.process('kick')
        expect(burt.getCurrentState()).toBe 'enraged'
        expect(sounds.roar).toHaveBeenCalled()

    it 'should be soothed if you stroke him', () ->
        burt.process('call')
        burt.process('stroke')
        expect(burt.getCurrentState()).toBe 'content'

    it 'should go to sleep if you feed and then sing to him', () ->
        burt.process('call')
        burt.process('feed')
        burt.process('sing-to')
        expect(burt.getCurrentState()).toBe 'sleeping'
        expect(sounds.snore).toHaveBeenCalled()

    it 'should go back to sleep when reset (even if enraged)', () ->
        burt.process('call')
        burt.process('prod')
        burt.reset()
        expect(burt.getCurrentState()).toBe 'sleeping'
