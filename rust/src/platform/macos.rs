use home::home_dir;
use macos_accessibility_client::accessibility::{
    application_is_trusted, application_is_trusted_with_prompt,
};
use std::fs::read_dir;
use std::process::Command;

#[cfg(target_os = "macos")]
#[link(name = "CoreGraphics", kind = "framework")]
extern "C" {
    fn CGPreflightScreenCaptureAccess() -> bool;
    fn CGRequestScreenCaptureAccess() -> bool;
}

pub async fn check_accessibility_permission() -> bool {
    return application_is_trusted();
}

pub async fn request_accessibility_permission() {
    application_is_trusted_with_prompt();
}

pub async fn check_screen_recording_permission() -> bool {
    unsafe { CGPreflightScreenCaptureAccess() }
}

pub async fn request_screen_recording_permission() {
    unsafe {
        CGRequestScreenCaptureAccess();
    }
}

pub async fn check_full_disk_access_permission() -> bool {
    let check_dirs = vec!["Library/Containers/com.apple.stocks", "Library/Safari"];

    if let Some(home) = home_dir() {
        for dir in check_dirs {
            if read_dir(home.join(dir)).is_ok() {
                return true;
            }
        }
    }

    false
}

pub async fn request_full_disk_access_permission() {
    let _ = Command::new("open")
        .arg("x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles")
        .spawn();
}
