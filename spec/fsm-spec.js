(function() {
  describe('My pet dragon called Burt', function() {
    var burt, sounds;
    burt = {};
    sounds = {};
    beforeEach(function() {
      burt = new FSM.Machine();
      sounds = {
        growl: function() {
          return console.log('Grrr');
        },
        roar: function() {
          return console.log('Roar');
        },
        snore: function() {
          return console.log('Zzzz');
        }
      };
      burt.setDefaultTransition('enraged', function() {
        return sounds.roar();
      });
      spyOn(sounds, 'roar');
      burt.addTransitionAny('sleeping', 'grumpy', function() {
        return sounds.growl();
      });
      spyOn(sounds, 'growl');
      burt.addTransition('stroke', 'grumpy', 'content');
      burt.addTransition('feed', 'grumpy', 'content');
      burt.addTransition('sing-to', 'content', 'sleeping', function() {
        return sounds.snore();
      });
      spyOn(sounds, 'snore');
      return burt.setInitialState('sleeping');
    });
    it('should growl when he wakes (as he will be grumpy)', function() {
      burt.process('call');
      expect(burt.getCurrentState()).toBe('grumpy');
      return expect(sounds.growl).toHaveBeenCalled();
    });
    it('should enrage if you kick him when awake', function() {
      burt.process('call');
      burt.process('kick');
      expect(burt.getCurrentState()).toBe('enraged');
      return expect(sounds.roar).toHaveBeenCalled();
    });
    it('should be soothed if you stroke him', function() {
      burt.process('call');
      burt.process('stroke');
      return expect(burt.getCurrentState()).toBe('content');
    });
    it('should go to sleep if you feed and then sing to him', function() {
      burt.process('call');
      burt.process('feed');
      burt.process('sing-to');
      expect(burt.getCurrentState()).toBe('sleeping');
      return expect(sounds.snore).toHaveBeenCalled();
    });
    return it('should go back to sleep when reset (even if enraged)', function() {
      burt.process('call');
      burt.process('prod');
      burt.reset();
      return expect(burt.getCurrentState()).toBe('sleeping');
    });
  });

}).call(this);
