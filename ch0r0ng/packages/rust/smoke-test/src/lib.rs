/// Add two integers.
///
/// ```
/// assert_eq!(rust_bin_smoke_test::add(20, 22), 42);
/// ```
pub fn add(a: u32, b: u32) -> u32 {
    a + b
}

#[test]
fn arithmetic() {
    assert_eq!(add(20, 22), 42);
}
