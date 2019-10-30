-- I am a comment
print("hello worlds")

-- global scoped variable float
-- numbers are float by default
float1 = 1.111
float2 = 1

-- local scoped variable and string concatenation
local str = "string" .. " " .. [[concatenation]]

-- truthiness
-- only false and nil are falsy

-- equality
print(true == false) -- false
print(true ~= false) -- true
-- equal to  ==
-- not equal to  ~=
-- less than  <
-- greater than  >
-- less than or equal to  <=
-- greater than or equal to  >=

-- coercion
print("string" .. 1) -- "string1"
print("1" + 3) -- 4.0
print(nil) -- nil
print(not nil) -- true
print(not 1) -- false
print(not 0) -- true

-- coercion doesn't work here
print(10 == "10") -- false
print(10 == tonumber(10)) -- true

-- not
print(not true) -- false

-- and
-- returns first arg if false/nil
-- returns second argument if first is not false/nil
print(false and true) -- false
print(false and "string") -- false
print(nil and false) -- nil
print(nil and "string") -- nil

print(true and true) -- true
print(true and false) -- false
print(true and 9) -- 9
print(9 and "test") -- "test"
print("test" and 3) -- 3

-- or
-- returns first argument if not false/nil
-- returns second argument if first is false/nil
print(true or true) -- true
print(true or false) -- true
print("string" or nil) -- "string"
print(false or nil) -- nil
print(false or 9) -- 9

local x = y or "default" -- can be used when assigning variables
local x = (y or 0) + 1 -- allows default value for operations too

-- if
if true then
  print(true)
else
  print(false)
end
-- true

if false then
  print(true)
else
  print(false)
end
-- false

if 0 then
  print(true)
else
  print(false)
end
-- true

-- tables
local t = {}
local n = "name"
print(t) -- table <id>

t[1] = "first"
t["foo"] = 1
t.bar = 2
t[666] = "scary!"
t[n] = "some name"

print(t[1]) -- first
print(t["foo"]) -- 1
print(t.bar) -- 2
print(t[666]) -- scary!
print(t.name) -- some name
print(t.name == t[n]) -- true

-- table shorthand
local tt = {"a", ["foo"] = 1, bar = 2, [666] = "scary!", [n] = "some name"}

-- variables referencing the same table are equal
-- different tables are never equal, even with the same contents
local at = t
print(t == t) -- true
print(at == t) -- true
print(t == tt) -- false

-- iterate over table k/v pairs
-- table pairs are not ordered
for k, v in pairs(t) do
  print(k, v)
end

-- tables as arrays
-- the # operator can be used to get the array length
-- # should only be used on non-sparse arrays
local arr = {"a", "b", "c"} -- a b c

-- modifying arrays properly
arr[#arr + 1] = "d" -- a b c d
table.insert(arr, "e") -- a b c d e
table.remove(arr, 2) -- a c d e
table.insert(arr, 2, "b") -- a b c d e

-- iterate array
for i, v in ipairs(arr) do
  print(i, v)
end

print(table.concat(arr, ":")) -- a:b:c:d:e

-- tables are only referenced, like JS objects
-- GC gets them when the last reference is gone
-- GC should clear even self-referencing tables
-- avoid using arrays if order doesn't matter

-- functions
f = function()
  print("function called!")
end
f()

fa = function(a)
  print("received", a)
end
fa(1)

-- can return multiple values
fm = function()
  return 1, 2
end
print(fm()) -- 1  2

-- assigning to a single variable
out = fm()
print(fo) -- 1

-- assigning to a table
out = {fm()}
print(table.concat(out, ":")) -- 1:2

-- assigning to multiple variables
-- nil is assigned to excess variables
out1, out2, out3 = fm()
print(out1, out2, out3) -- 1  1  nil

-- discard multiple values using brackets
out1, out2 = fm()
print(out1, out2) -- 1  nil

-- discards automatically as subexpression or firt arg
print("output: " .. fm()) -- output: 1
print(fm(), "0") -- 1  0

-- doesn't automatically discard when last arg
print("0", fm()) -- 0 1 2

-- brackets can discard here too
print("0", (fm())) -- 0 1

-- any number of arguments
fs = function(...)
  print(...)

  -- count the arguments
  local count = select("#", ...)
  print(count)

  -- select arguments from a given start index
  local selected = select(2, ...)
  print(selected)

  -- can also be packed into table
  local selectTable = {...}

  -- tables can be unpacked to arg list
  print(table.unpack(selectTable))

  -- a safer way to pack, avoids holes
  local selectTableSafe = table.pack(...)

  -- matching safe unpack
  print(selectTableSafe.n, table.unpack(selectTableSafe, 1, selectTableSafe.n))
end
fs(1, 2, 3, 4)
-- 1  2  3  4
-- 4
-- 2  3  4
-- 1  2  3  4
-- 4  1  2  3  4

fs(1)
-- 1
-- 1
-- nil
-- 1
-- 1  1

-- function statements too
function myFunc(...)
  -- do something
end

-- tail calls
-- returning a function call like this allows Lua to replace the
-- current stack slot with the new call
-- in this case tail returns helper which returns print - leaving only print
-- storing the call on a variable and returning the variable is less efficient
-- and can overflow with many recursive calls - use tail calls where possible
function helper(...)
  return print(...)
end
function tail(...)
  return helper(...)
end

-- userdata
-- foreign objects from C etc can be passed around and sometimes operated on
-- like tables within Lua, this is an advanced topic though

-- threads
-- Lua supports threading

-- type query
print(type(tail)) -- function
print(type(9)) -- number

-- multiple assignment
a, b = 1, 2
print(a, b) -- 1  2

-- swap them
a, b = b, a
print(a, b) -- 2  1

-- evaluation before assignment
-- expressions on the right are evaluated before assignment occurs
a = 3
a, b = a + 5, a
-- a, b = 3 + 5, 3
print(a, b) -- 8  3

-- mismatched list sizes
-- excess variables are assigned nil
a, b, c = 1, 2
print(a, b, c) -- 1  2  nil
-- excess values are ignored
a, b, c = 1, 2, 3, 4
print(a, b, c) -- 1  2  3

-- if
x = 4
if x < 5 then
  print(1)
elseif x < 10 then
  print(2)
else
  print(3)
end
-- 1

-- while
x = 4
while x < 5 do
  print("x < 5")
  x = x + 1
end
-- loops once

-- repeat
x = 5
repeat
  x = x * x
  print(x)
until x > 10
-- 25

-- for - without step
for i = 1, 5 do
  print("loop " .. i)
end
-- loop 1
-- loop 2
-- loop 3
-- loop 4
-- loop 5

-- for - with step
for i = 10, 0, -2 do
  print("reverse " .. i)
end
-- reverse 10
-- reverse 8
-- reverse 6
-- reverse 4
-- reverse 2
-- reverse 0

-- for - iterator
t = {"a", "b", "c"}
for k, v in ipairs(t) do
  print(k .. ":" .. v)
end
-- 1:a
-- 2:b
-- 3:c

-- break
-- only breaks first loop, parent loops continue
x = 0
while true do
  print("LOOP")
  if x > 5 then
    break
  end
  x = x + 5
end
-- LOOP
-- LOOP
-- LOOP

-- there is no continue statement
-- workarounds
-- goto label if true
-- -- >=5.2
-- for i = 1, 3 do
--   if i == 2 then
--     goto continue
--   end
--   print("loop1 " .. i)
--   ::continue::
-- end
-- -- loop1  1
-- -- loop1  3

-- <=5.1 method 1
-- run if false
for i = 1, 3 do
  if i ~= 2 then
    print("loop2 " .. i)
  end
end
-- loop2 1
-- loop2 3

-- <=5.1 method 2
-- nested loop to break if true
for i = 1, 3 do
  repeat
    if i == 2 then
      break
    end
    print("loop3 " .. i)
  until true
end
-- loop3 1
-- loop3 3

-- ternary if/else
condition = true
print(condition and "true output" or "false output") -- true output
x = 1
print(x == 1 and "true output" or "false output") -- true output
print(x ~= 1 and "true output" or "false output") -- false output

-- true output cannot be false or nil
condition = true
print(condition and false or true) -- true 
-- invert it all to fix
print(not condition and true or false) -- false
-- both values cannot be false - you must use some other workaround
-- using numbers or strings to represent different outcomes and then use
-- if/else to solve it

-- scoping
-- local vars are block scoped
local a = 2
do
  local a = 5
end
print(a) -- 2

-- local functions
local function locFn1() end -- statement
local locFn2 = function() end -- expression

-- local variables are inherited, like JS
local a = 1
do
  print(a) -- 1
end

