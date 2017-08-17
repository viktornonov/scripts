# Revert migrations before switch a branch

This script reverts any migrations that does not exist on the target branch

### Usage:
```
./revert-migrations.rb master
```

### Example:
Life without this script:
1. You have a high quality Rails app which stores data in a table called ```stuff``` with column called ```shitty_column```
2. ```master``` is the main branch of a Rails app
3. You create a new branch where you add and run migration that renames ```shitty_column``` to ```even_more_shitty_column```
4. You switch to ```master``` and all the pages that use ```shitty_column``` are broken

Life with this script:
1. First three steps from above repeat again
2. You run the script on the newly created branch
```sh
./revert-migrations.rb master
```
3. If you switch to master all the pages that use ```shitty_column``` still work
4. You can continue doing useless stuff
