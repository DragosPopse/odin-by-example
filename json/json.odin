package main

import "core:encoding/json"
import "core:fmt"

main :: proc() {
    json_input := #load("example.json", string)
    json_obj, err := json.parse_string(json_input) // uses the default allocator
    if err != .None {
        fmt.printf("Parsing error: %v\n", err)
    }
    defer json.destroy_value(json_obj) // This recursively destroys the tree. It's not needed if we use a temporary allocator or arena.

    root := json_obj.(json.Object) // the root value is always an object, aka a map
    
    for key, val in root {
        #partial switch v in val {
            case json.Object: // {}
                fmt.printf("%s is a dictionary: ", key)
                for _, dict_val in v {
                    fmt.printf("%v ", dict_val)
                }
                fmt.printf("\n")
            
            case json.Array: // []
                fmt.printf("%s is an array: ", key)
                for arr_val in v {
                    fmt.printf("%v ", arr_val)
                }
                fmt.printf("\n")
        }
    }
}