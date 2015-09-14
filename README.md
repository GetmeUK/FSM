# Finite State Machine (FSM)
A minimal finite state machine (FSM) for Javascript.

## Building
To build the library you'll need to use Grunt. First install the required node modules ([grunt-cli](http://gruntjs.com/getting-started) must be installed):
```
git clone https://github.com/GetmeUK/FSM.git
cd FSM
npm install
```

Then run `grunt build` to build the project.

## Testing
To test the library you'll need to use Jasmine. First install Jasmine:
```
git clone https://github.com/pivotal/jasmine.git
mkdir FSM/jasmine
mv jasmine/dist/jasmine-standalone-2.0.3.zip FSM/jasmine
cd FSM/jasmine
unzip jasmine-standalone-2.0.3.zip
```

Then open `FSM/SpecRunner.html` in a browser to run the tests.

## Documentation
Full documentation is available at http://getcontenttools.com/api/fsm

## Browser support
- Chrome
- Firefox
- IE9+
