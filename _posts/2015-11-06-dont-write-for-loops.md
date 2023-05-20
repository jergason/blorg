---
author: jamison
layout: post
title: "Don't Write For Loops"
published: true
description: ""
---

Behold, a for loop!

```javascript
var output = []
for (let i = 0; i < array.length; i++) {
  let changedData = changeData(array[i])
  output[i] = changedData
}
```

If you squint your eyes and look at the shape of this code, it looks like . . .
a for loop. There is so much boilerplate that the meaning of the code is hidden
behind the noise of looping, tracking indicies and pulling items out of an
array.

We can clean it up a little, but the for loop book-keeping still takes up more
space than operating on the data.

```javascript
var output = []
for (let i = 0; i < array.length; i++) {
  output.push(changeData(array[i])
}
```

Three of the four lines in this function tell you nothing more than "HELLO
CODE-READER WE ARE LOOPING OVER A THING". What we need is an abstraction for
transforming each item in an array into a different item in a new array. If
only such a thing existed OH WAIT IT DOES.

```javascript
const output = array.map(changeData)
```

For loops are the worst. They make you write lots of code, but worse, they
obscure the meaning of the code. There are [higher-order
functions](http://eloquentjavascript.net/05_higher_order.html#h_xxCc98lOBK)
for operating on arrays that communicate more clearly what you are actually
doing to the array. They also free you from writing the boilerplate for loop
code, which is surprisingly bug-prone.

Many for loops are just transforming an array in to another array, or
transforming an array in to a value. JavaScript has a bunch of functions that
help with both of these.

## Transforming an array into another array


If you want to turn an array into another array, use
[`map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map).


If you want to remove some items from an array, use
[`filter`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter).
If I want to get only the minerals out of an array of objects, I could do it like so:

```javascript
let objects = [
  {name: 'gold', type: 'mineral'},
  {name: 'potato', type: 'vegetable'},
  {name: 'silicon', type: 'mineral'},
  {name: 'jamison', type: 'animal'}
]
let minerals = objects.filter(o => o.type == 'mineral')
// [{name: 'gold', type: 'mineral'}, {name: 'silicon', type: 'mineral'}]
```


## Turning an array in to a value


[`find`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find)
and [`findIndex`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/findIndex)
are siblings. Both take a callback, and return the first item in the array
that the callback returns `true` for. `find` returns the item, and I bet you
can guess what `findIndex` returns.

```javascript
// find the spy
let suspects = [
  {name: 'Yolo Swaggins', isSpy: false},
  {name: 'Sneaky McSneakerson', isSpy: true},
  {name: 'Dastardly Diana', isSpy: true}
]
let spy = suspects.find(s => s.isSpy) // {name: 'Sneaky McSneakerson', isSpy: true},
console.log('ahah! we have found the spy,', spy.name, 'and surely now we are safe!')
```

[`every`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every)
and [`some`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/some)
are also siblings. They turn an array in to a boolean. `every` returns true
if every item in the array makes your callback return true, and `some` returns
true if *any* item in your array makes your callback return true.

Let's use `some` to tell if Sara likes any hair metal bands.

```javascript
let sarasFavoriteBands = [
  {name: 'Whitesnake', hairLength: 'long', makeup: true}
  {name: 'Mastodon', hairLength: 'long', makeup: false},
  {name: 'Bruce Springsteen', hairLength: 'short', makeup: false}
]
let isHairMetalFan = sarasFavoriteBands.some(b => b.hairLength == 'long' && b.makeup)
// true, Sara likes hair metal
```

[`reduce`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduc://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)
takes in an array and "reduces" it down to a single value.

Liz is a bodybuilder. She wants to know how many total pounds she lifts in a
workout. We can use `reduce` to do that.

```javascript
let workout = [
  {exercise: 'back squat', weight: 150, sets: 5, reps: 10},
  {exercise: 'deadlift', weight: 245, sets: 5, reps: 5},
  {exercise: 'bench press', weight: 100, sets: 5, reps: 8},
  {exercise: 'push press', weight: 75, sets: 4, reps: 7}
]

var weight = workout.reduce(function(weightSoFar, exercise) {
  return weightSoFar + (exercise.weight * exercise.reps * exercise.sets)
}, 0)
console.log(weight) // 19725, holy crap that is a lot of weight, congrats Liz
```

`reduce` offers you a lot of control, but the control comes at the cost of
readability. If you can accomplish your goal with another higher-order
function, prefer it to `reduce`. However, sometimes `reduce` is just what you
need.

### A word about `forEach`

[`forEach`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach)
is another array function. It doesn't transform the array or return anything.
All it does is hand each value in the array to your callback function. Since it
doesn't return data,`forEach` is almost always used for side-effecting things.

## Sometimes a for loop really is what you want

Absolutes like NEVER WRITE FOR LOOPS make for good blog post titles but poor
advice. [Beware of
dogma.](https://speakerdeck.com/anguscroll/the-politics-of-javascript) There
are always exceptions. Sometimes you really do want a for loop.

I still use for loops with `async/await` code because you can't use `forEach`.
