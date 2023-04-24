use std::ffi::OsStr;
use std::path::Path;
use std::{env, fs};

const INPUT_FILE_NAME: &str = "input.txt";

fn main() {
    let target_dir_path = env::var("OUT_DIR").unwrap();

    copy(&target_dir_path, INPUT_FILE_NAME);
}

fn copy<S: AsRef<OsStr>, P: Copy + AsRef<Path> + AsRef<OsStr>>(target_dir_path: &S, file_name: P) {
    fs::copy(
        Path::new(&file_name),
        Path::new(&target_dir_path).join("../../..").join(file_name)
    ).unwrap();
}

{{_cursor_}}
