setname = (name1) -> @name = name1
cat ={}
cat.setname = setname
cat.setname 'Mittens'
console.log cat.name
console.log ''

pig = {}
setname.apply pig,['Babe']
console.log pig.name
console.log ''

Dog = setname
dog1 = new Dog('Jimmy')
dog2 = new Dog('Jake')
console.log dog1.name
console.log dog2.name
console.log ''

setname 'lulu'
console.log name
console.log @name
console.log ''
