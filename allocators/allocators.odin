package main

import "core:mem"
import "core:runtime"
import "core:fmt"



main :: proc() {
    // The context system has 2 allocators
    a := context.allocator // general purpose allocations, malloc/free style
    // Odin default temp allocator is a ring buffer, which doesnt require freeing, but this will be subject to change in the future
    ta := context.temp_allocator // temporary allocations

    // An arena is a linear allocator. Allocations/deallocations are a simple operation involving moving the buffer offset around
    arena: mem.Arena 
    mem_buffer: [1024]byte
    mem.arena_init(&arena, mem_buffer[:]) // Use a buffer on the stack for the internal buffer

    context.temp_allocator = mem.arena_allocator(&arena) // We need to create an allocator from the arena
    // Everything in this current scope now will use our new temp allocator
    temp_string := fmt.tprintf("This is a temporary string.") // Will use our arena
    {
        context.allocator = context.temp_allocator
        // aprintf will use context.allocator, but we set it to our temp_allocator, so it becomes equivalent to tprintf
        another_temp_string := fmt.aprintf("This is still temporary")
    } // When we end this scope, the context gets rolled back

    not_a_temp_string := fmt.aprintf("This string needs to be deleted.")
    // delete() will use context.allocator by default, so we usually don't need to specify it. 
    // If you are messing around with the context too much, keep in mind that you need to specify the allocator used to allocate your data
    delete(not_a_temp_string, context.allocator) // We got to delete it, since we are using the general purpose allocator here

    {
        context.allocator = context.temp_allocator
        dynamic_literal := [dynamic]int{32, 42} // This will be allocated using the current context.allocator
    } // Context rollback again
    
    free_all(context.temp_allocator) // Free the entire arena, everything allocated with it will be invalidated

    
}