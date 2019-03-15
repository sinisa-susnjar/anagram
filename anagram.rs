use std::collections::hash_map::Entry::{Occupied, Vacant};
use std::collections::{HashMap};
use std::io::prelude::*;
use std::io::BufReader;
use std::fs::File;
use std::env;
fn main() {
    let args: Vec<String> = env::args().collect();
    let reader = BufReader::new(File::open((&args[1]).clone()).unwrap());
    let mut anagrams : HashMap<String, Vec<String>>  = HashMap::new();
    for line in reader.lines().map(|l| l.unwrap()) {
        let lc = line.to_lowercase();
        let s = lc.trim();
        let mut chars = s.chars().collect::<Vec<char>>();
        chars.sort();
        let sorted = chars.iter().cloned().collect();
        match anagrams.entry(sorted) {
            Vacant(entry) => entry.insert(Vec::new()),
            Occupied(entry) => entry.into_mut(),
        }.push(s.to_string());
    }
    for a in anagrams.values() {
        if a.len() > 1 {
            for word in a { print!("{} ", word) }
            println!();
        }
    }
}
