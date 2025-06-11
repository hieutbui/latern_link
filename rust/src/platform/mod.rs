#[cfg(target_os = "macos")]
mod macos;
#[cfg(target_os = "windows")]
mod windows;
#[cfg(target_os = "linux")]
mod linux;

#[cfg(not(any(target_os = "macos", target_os = "windows", target_os = "linux")))]
mod fallback;

#[cfg(target_os = "macos")]
pub use self::macos::*;
#[cfg(target_os = "windows")]
pub use self::windows::*;
#[cfg(target_os = "linux")]
pub use self::linux::*;
#[cfg(not(any(target_os = "macos", target_os = "windows", target_os = "linux")))]
pub use self::fallback::*;