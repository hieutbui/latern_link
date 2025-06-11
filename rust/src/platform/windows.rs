use std::mem::{size_of, zeroed};
use std::process::exit;
use std::ptr::null_mut;
use windows_sys::Win32::{
    Foundation::{CloseHandle, FALSE, HANDLE},
    Security::{GetTokenInformation, TokenElevation, TOKEN_ELEVATION, TOKEN_QUERY},
    System::Threading::{GetCurrentProcess, OpenProcessToken},
    UI::Shell::ShellExecuteW,
    UI::WindowsAndMessaging::SW_SHOWNORMAL,
};

pub fn is_windows_admin() -> bool {
    unsafe {
        let mut token: HANDLE = 0;

        if OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &mut token) == FALSE {
            return false;
        }

        let mut elevation: TOKEN_ELEVATION = zeroed();
        let mut return_length = 0;

        if GetTokenInformation(
            token,
            TokenElevation,
            &mut elevation as *mut _ as *mut _,
            size_of::<TOKEN_ELEVATION>() as u32,
            &mut return_length,
        ) == FALSE
        {
            CloseHandle(token);
            return false;
        }

        CloseHandle(token);
        elevation.TokenIsElevated != 0
    }
}

pub fn request_windows_admin() {
    unsafe {
        let current_exe_path = std::env::current_exe().unwrap();
        let current_exe_str: Vec<u16> = current_exe_path
            .to_string_lossy()
            .encode_utf16()
            .chain(std::iter::once(0))
            .collect();
        let operation: Vec<u16> = "runas".encode_utf16().chain(std::iter::once(0)).collect();

        ShellExecuteW(
            0,
            operation.as_ptr(),
            current_exe_str.as_ptr(),
            null_mut(),
            null_mut(),
            SW_SHOWNORMAL,
        );

        exit(0);
    }
}

pub async fn check_accessibility_permission() -> bool {
    // Windows does not have a direct equivalent for macOS accessibility permissions.
    // This function can return true by default or implement a custom check if needed.
    false
}

pub async fn request_accessibility_permission() {
    // Windows does not have a direct equivalent for macOS accessibility permissions.
    // This function can be left empty or implement a custom request if needed.
}

pub async fn check_screen_recording_permission() -> bool {
    // Windows does not have a direct equivalent for macOS screen recording permissions.
    // This function can return true by default or implement a custom check if needed.
    false
}

pub async fn request_screen_recording_permission() {
    // Windows does not have a direct equivalent for macOS screen recording permissions.
    // This function can be left empty or implement a custom request if needed.
}

pub async fn check_full_disk_access_permission() -> bool {
    // Windows does not have a direct equivalent for macOS full disk access permissions.
    // This function can return true by default or implement a custom check if needed.
    false
}

pub async fn request_full_disk_access_permission() {
    // Windows does not have a direct equivalent for macOS full disk access permissions.
    // This function can be left empty or implement a custom request if needed.
}
