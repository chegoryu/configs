////////////////////////////////////////////////////////////////////////////////

mod heaponly_alloc {
    use std::alloc::{alloc, Layout};

    pub struct HeapOnlyStruct {
        pub n: i32,
        {{_cursor_}}
    }

    impl HeapOnlyStruct {
        pub fn new() -> Box<Self> {
            unsafe {
                let layout = Layout::new::<Self>();
                let ptr = alloc(layout) as *mut Self;

                (*ptr).n = 1;

                Box::from_raw(ptr)
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
