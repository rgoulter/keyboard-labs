use std::env;

fn main() {
    match env::var("MINIF4_36_REVISION") {
        Ok(r) => {
            match r.as_str() {
                "2021.1" => println!("cargo:rustc-cfg=keyboard_revision=\"2021.1\""),
                "2020.1" => println!("cargo:rustc-cfg=keyboard_revision=\"2020.1\""),
                _ => println!("cargo:warning=MINIF4_36_REVISION version not recognised")
            }
        }

        Err(_) => {
            println!("cargo:warning=MINIF4_36_REVISION is not set");
        }
    }
}
