use extendr_api::prelude::*;
use uuid::Uuid;

#[extendr]
/// Generate new UUIDs
///
/// Note that if creating a v7 UUID, `uuid::UUIDgenerate(use.time = TRUE, output = "string")` is faster whereas a v4 UUID is ~20x faster using this implementation.
/// @param n the number of uuids to generate
/// @export
fn new_v4(n: i32) -> Strings {
    let n = n as usize;

    let range = 0..n;
    range
        .into_iter()
        .map(|_| Uuid::new_v4().hyphenated().to_string())
        .collect::<Strings>()
}

#[extendr]
/// @export
/// @rdname new_v4
fn new_v7(n: i32) -> Strings {
    let n = n as usize;

    let range = 0..n;
    range
        .into_iter()
        .map(|_| Uuid::now_v7().hyphenated().to_string())
        .collect::<Strings>()
}

#[extendr]
fn impute_uuid_(x: Strings, prefix: &str) {
    let mut x = x;

    for i in 0..x.len() {
        let xi = &x[i];
        if xi.is_na() {
            let uuid = Uuid::new_v4().hyphenated().to_string();
            x.set_elt(i, Rstr::from(format!("{prefix}{uuid}")))
        }
    }
}
// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod uwu;
    fn new_v4;
    fn new_v7;
    fn impute_uuid_;
}
