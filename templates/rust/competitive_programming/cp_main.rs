mod fastio {
    use std::fs::File;
    use std::io::{stdout, BufRead, BufReader, BufWriter, Write};

    #[cfg(not(chegoryu))]
    use std::io::stdin;

    #[cfg(chegoryu)]
    const INPUT_FILE_NAME: &str = "input.txt";

    #[cfg(chegoryu)]
    pub fn get_in() -> impl BufRead {
        let stdin = File::open(INPUT_FILE_NAME).expect("Failed to open input file");
        BufReader::new(stdin)
    }

    #[cfg(all(unix, not(chegoryu)))]
    pub fn get_in() -> impl BufRead {
        use std::os::unix::prelude::{AsRawFd, FromRawFd};
        unsafe {
            let stdin = File::from_raw_fd(stdin().as_raw_fd());
            BufReader::new(stdin)
        }
    }

    #[cfg(all(windows, not(chegoryu)))]
    pub fn get_in() -> impl BufRead {
        use std::os::windows::prelude::{AsRawHandle, FromRawHandle};
        unsafe {
            let stdin = File::from_raw_handle(stdin().as_raw_handle());
            BufReader::new(stdin)
        }
    }

    #[cfg(unix)]
    pub fn get_out() -> impl Write {
        use std::os::unix::prelude::{AsRawFd, FromRawFd};
        unsafe {
            let stdout = File::from_raw_fd(stdout().as_raw_fd());
            BufWriter::new(stdout)
        }
    }

    #[cfg(windows)]
    pub fn get_out() -> impl Write {
        use std::os::windows::prelude::{AsRawHandle, FromRawHandle};
        unsafe {
            let stdout = File::from_raw_handle(stdout().as_raw_handle());
            BufWriter::new(stdout)
        }
    }
}

mod scanner {
    use std::io::BufRead;

    pub struct Scanner<R> {
        reader: R,
        buf_str: Vec<u8>,
        buf_iter: std::str::SplitAsciiWhitespace<'static>,
    }

    impl<R: BufRead> Scanner<R> {
        pub fn new(reader: R) -> Self {
            Self {
                reader,
                buf_str: Vec::new(),
                buf_iter: "".split_ascii_whitespace(),
            }
        }

        pub fn next<T: std::str::FromStr>(&mut self) -> T {
            loop {
                if let Some(token) = self.buf_iter.next() {
                    return token.parse().ok().expect("Failed to parse token");
                }
                unsafe {
                    self.buf_str.set_len(0);
                }
                self.reader
                    .read_until(b'\n', &mut self.buf_str)
                    .expect("Failed read next line");
                self.buf_iter = unsafe {
                    let slice = std::str::from_utf8_unchecked(&self.buf_str);
                    std::mem::transmute(slice.split_ascii_whitespace())
                }
            }
        }
    }
}

fn main() {
    solve(scanner::Scanner::new(fastio::get_in()), fastio::get_out());
}

use std::io::{BufRead, Write};

#[allow(dead_code)]
const INF: i32 = 1000 * 1000 * 1000 + 21;
#[allow(dead_code)]
const LLINF: i64 = (1i64 << 60) + 5;
#[allow(dead_code)]
const MOD: i32 = 1000 * 1000 * 1000 + 7;

pub fn solve<R: BufRead, W: Write>(mut scanner: scanner::Scanner<R>, mut out: W) {
    #[allow(unused_macros)]
    macro_rules! puts {($($format:tt)*) => (let _ = writeln!(out, $($format)*););}

    {{_cursor_}}
}
