use std::os::raw::{c_char, c_int};

extern "C" {
    pub fn c_main(argc: c_int, argv: *const *const c_char) -> c_int;
}
