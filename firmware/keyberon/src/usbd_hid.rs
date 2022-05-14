use keyberon::key_code::KbHidReport;

use usbd_hid::descriptor::KeyboardReport;

/// Adjust from
pub fn usbd_hid_report_from_keyberon_report(
    report: &KbHidReport
) -> KeyboardReport {
    let raw_report: &[u8] = report.as_bytes();
    KeyboardReport {
        modifier: raw_report[0],
        reserved: raw_report[1],
        leds: 0 as u8,
        keycodes: [
            raw_report[2],
            raw_report[3],
            raw_report[4],
            raw_report[5],
            raw_report[6],
            raw_report[7],
        ],
    }
}
