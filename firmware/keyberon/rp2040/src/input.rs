use rp2040_hal as hal;

use hal::gpio::{DynPinId, FunctionNull, FunctionSio, Pin, PullDown, PullUp, SioInput, SioOutput};

pub type UnconfiguredPin<I> = Pin<I, FunctionNull, PullDown>;

pub type Input = Pin<DynPinId, FunctionSio<SioInput>, PullUp>;

pub type Output = Pin<DynPinId, FunctionSio<SioOutput>, PullDown>;
