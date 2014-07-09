_currentSuite = null



###
Declares a test Suite.  For example:

      describe 'my suite name', ->
        it 'does something', ->
          expect(true).to.equal true


@param name: The name/description of the suite.
@param func: The suite function.

@returns the resulting [Suite] object.
###
describe = BDD.describe = (name, func) ->
  # Setup initial conditions.
  isRoot = not _currentSuite?
  startingSuite = _currentSuite ?= BDD.suite
  name = 'Untitled' if Util.isBlank(name)

  # Create the new suite.
  suite = _currentSuite.add(new BDD.Suite(name))
  _currentSuite = suite

  # Configure the suite.
  if Object.isFunction(func)
    func()

  # Finish up.
  result = _currentSuite
  _currentSuite = if isRoot then null else startingSuite
  result


# ----------------------------------------------------------------------


###
Declares a "spec" (test specification).
@param name: The name/descripion of the test.
@param func: The test function.
###
it = (name, func) -> getSuite()?.add(new BDD.Spec(name, func))


# ----------------------------------------------------------------------


###
Registers a function to run "before all" specs within the suite.
@param func: The function to run.
###
before = (func) -> getSuite()?.before.push(func)


###
Registers a function to run "before each" spec within the suite.
@param func: The function to run.
###
beforeEach = (func) -> getSuite()?.beforeEach.push(func)


###
Registers a function to run "after all" specs within the suite.
@param func: The function to run.
###
afterEach = (func) -> getSuite()?.afterEach.push(func)


###
Registers a function to run "after all" specs within the suite.
@param func: The function to run.
###
after = (func) -> getSuite()?.after.push(func)




# PRIVATE ----------------------------------------------------------------------


getSuite = -> _currentSuite ? BDD.suite



