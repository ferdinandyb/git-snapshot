use std::env;
use std::ffi::CString;
use std::os::raw::{c_char, c_int};

use git;

fn main() {
    let args: Vec<CString> = env::args()
        .map(|arg| CString::new(arg).unwrap())
        .collect();
    let c_args: Vec<*const c_char> = args.iter().map(|arg| arg.as_ptr()).collect();

    unsafe {
        git::c_main(c_args.len() as c_int, c_args.as_ptr());
    }
    println!("Hello, world!");
}
