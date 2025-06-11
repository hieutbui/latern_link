use crate::platform;
use flutter_rust_bridge::frb;

#[frb]
pub async fn check_accessibility_permission() -> bool {
    platform::check_accessibility_permission().await
}

#[frb]
pub async fn request_accessibility_permission() {
    platform::request_accessibility_permission().await
}

#[frb]
pub async fn check_screen_recording_permission() -> bool {
    platform::check_screen_recording_permission().await
}

#[frb]
pub async fn request_screen_recording_permission() {
    platform::request_screen_recording_permission().await
}

#[frb]
pub async fn check_full_disk_access_permission() -> bool {
    platform::check_full_disk_access_permission().await
}

#[frb]
pub async fn request_full_disk_access_permission() {
    platform::request_full_disk_access_permission().await
}
