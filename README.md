# Dispatch
crystal-queue

### Super simple job queueing
```crystal
# example.cr
require "./src/Dispatch"

class FakeJob
  include Dispatch::Performable

  def perform(name)
    p "#{Time.now}: Hello, #{name}"
  end
end

FakeJob.perform_async("Bob")
FakeJob.perform_async("Emily")
FakeJob.perform_now("James")
FakeJob.perform_in(5.seconds, "Billy")
FakeJob.perform_async("Maddy")

sleep 10
```

Output:
```
"2016-11-30 15:51:04 -0500: Hello, James"
"2016-11-30 15:51:04 -0500: Hello, Bob"
"2016-11-30 15:51:04 -0500: Hello, Emily"
"2016-11-30 15:51:04 -0500: Hello, Maddy"
"2016-11-30 15:51:09 -0500: Hello, Billy"
```
