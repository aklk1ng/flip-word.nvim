# flip-word.nvim

simply invert the word under cursor and have no side effects

# Usage

```lua
require('flip-word').setup()
```

# Default config

```lua
table = {
  ['true'] = 'false',
  ['True'] = 'False',
  ['TRUE'] = 'FALSE',
  ['yes'] = 'no',
  ['Yes'] = 'No',
  ['YES'] = 'NO',
  ['min'] = 'max',
  ['Min'] = 'Max',
  ['MIN'] = 'MAX',
  ['and'] = 'or',
  ['And'] = 'Or',
  ['AND'] = 'OR',
  ['off'] = 'on',
  ['Off'] = 'On',
  ['OFF'] = 'ON',
  ['<'] = '>',
  ['+'] = '-',
  ['+='] = '-=',
  ['=='] = '!=',
  ['<='] = '>=',
  ['<<'] = '>>',
  ['<<='] = '>>=',
  ['->'] = '<-',
  ['&&'] = '||',
  ['&'] = '|',
  ['&='] = '|=',
},
key = 'ta',
```
