## Minimal JSON

This example showcases a simple usage of `core:encoding/json`. 

### Tips and Considerations

- A json `Object` is simply a `distinct map[string]Value`. A `Value` is a simple `enum` encapsulates all the json types, including a `json.Object`. Considering this, the final data structure behaves like a tree
- Calling `json.destroy_value()` on the root value will delete all the json data. This means that if you want to You'll need to clone things like strings if you want to store them somewhere else. 
- Consider using an arena when parsing the json. That way you have all your data stored in one place, and you can easily `free_all` everything when you are done with it.
