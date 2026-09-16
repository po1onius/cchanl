fn main() {
    let numbers = [20, 22];
    assert_eq!(numbers.iter().sum::<u32>(), 42);
    println!("rust-bin smoke test passed");
}
