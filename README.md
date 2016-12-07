# Dispatch [![Build Status](https://travis-ci.org/bmulvihill/dispatch.svg?branch=master)](https://travis-ci.org/bmulvihill/dispatch)


### Super simple in-memory job queuing
```crystal
# example.cr
require "./src/dispatch"

class FakeJob
  include Dispatchable

  def perform(name)
    p "#{Time.now}: Hello, #{name}"
  end
end

FakeJob.dispatch("Bob")
FakeJob.dispatch("Emily")
FakeJob.dispatch_in(5.seconds, "Billy")
FakeJob.dispatch("Maddy")

sleep 10
```

Output:
```
"2016-11-30 15:51:04 -0500: Hello, Bob"
"2016-11-30 15:51:04 -0500: Hello, Emily"
"2016-11-30 15:51:04 -0500: Hello, Maddy"
"2016-11-30 15:51:09 -0500: Hello, Billy"
```
